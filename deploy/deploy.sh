#!/usr/bin/env bash
# Deploys the Gewerber backend (Serverpod) on the VPS for a given environment.
#
# The GitHub Actions workflow copies this script and `docker-compose.yml` to
# the VPS, then invokes: `bash deploy.sh <env> <image>`.
#
#   env   : prod | test
#   image : full image reference pushed to GHCR by CI
#
# The stack per environment: Serverpod API server + PostgreSQL + Redis, wired
# into the existing Traefik reverse proxy. Secrets (DB/Redis passwords, JWT
# keys, service secret) are generated once per environment and persisted in
# $DEPLOY_DIR/.secrets so they survive redeploys.
#
# Optional environment variables:
#   GHCR_TOKEN / GHCR_USER  – credentials to pull the (private) image from GHCR
#   TRAEFIK_NETWORK, WEB_ENTRYPOINT, WEBSECURE_ENTRYPOINT, CERT_RESOLVER
#   DEPLOY_DIR              – base directory (default: $HOME/gewerber/backend/<env>)
#   SMTP_*                  – transactional email settings (see below)
#   GOOGLE_CLIENT_SECRET_JSON, APPLE_*, FACEBOOK_*, MICROSOFT_* – optional
#                             social sign-in credentials; omitted = provider
#                             disabled (see README.md, "Social sign-in")
set -euo pipefail

ENV="${1:?usage: deploy.sh <prod|test> <image>}"
IMAGE="${2:?usage: deploy.sh <prod|test> <image>}"

case "$ENV" in
  prod)
    CONTAINER_NAME="gewerber-backend"
    ROUTER_PREFIX="gwb"
    HOST_RULE='Host(`api.gewerber.de`)'
    RUNMODE="production"
    ;;
  test)
    CONTAINER_NAME="gewerber-backend-test"
    ROUTER_PREFIX="gwb-test"
    HOST_RULE='Host(`api.test.gewerber.de`)'
    RUNMODE="staging"
    ;;
  *)
    echo "unknown env: $ENV (expected 'prod' or 'test')" >&2
    exit 1
    ;;
esac

TRAEFIK_NETWORK="${TRAEFIK_NETWORK:-web}"
WEB_ENTRYPOINT="${WEB_ENTRYPOINT:-web}"
WEBSECURE_ENTRYPOINT="${WEBSECURE_ENTRYPOINT:-websecure}"
CERT_RESOLVER="${CERT_RESOLVER:-letsencrypt}"
DEPLOY_DIR="${DEPLOY_DIR:-$HOME/gewerber/backend/$ENV}"
COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME:-gewerber-backend-$ENV}"
export COMPOSE_PROJECT_NAME

# Log in to GHCR if credentials were provided (private image).
if [ -n "${GHCR_TOKEN:-}" ]; then
  echo "${GHCR_TOKEN}" | docker login ghcr.io -u "${GHCR_USER:-gewerber}" --password-stdin
fi

mkdir -p "$DEPLOY_DIR/config"

# docker-compose.yml is copied next to this script by CI.
cp -f "$(dirname "$0")/docker-compose.yml" "$DEPLOY_DIR/docker-compose.yml"

# Stable secrets, generated once per environment and reused on every deploy.
SECRETS="$DEPLOY_DIR/.secrets"
if [ ! -f "$SECRETS" ]; then
  gen() { openssl rand -hex 32; }
  cat > "$SECRETS" <<EOF
DB_PASSWORD=$(gen)
REDIS_PASSWORD=$(gen)
SERVICE_SECRET=$(gen)
EMAIL_SECRET_HASH_PEPPER=$(gen)
JWT_HMAC_SHA512_PRIVATE_KEY=$(gen)
JWT_REFRESH_TOKEN_HASH_PEPPER=$(gen)
EOF
  chmod 600 "$SECRETS"
  echo "Generated new secrets in $SECRETS"
fi
# shellcheck disable=SC1090
. "$SECRETS"

# Serverpod passwords file (config/passwords.yaml), mounted into the container.
# The section name must match the server run mode. Values are single-quoted so
# that arbitrary secret characters (`$`, backticks, quotes, `:`, ...) cannot
# break the YAML or be interpreted by the shell.
yaml_q() {
  local s=${1//\'/\'\'}
  printf "'%s'\n" "$s"
}
# Formats a multi-line PEM value as a YAML literal block scalar (`|`, indented
# by 4 spaces: 2 for the top-level key under `<mode>:` and 2 for the block
# content). Single-quoting a multi-line PEM would fold its newlines into spaces
# in YAML, making `dart_jsonwebtoken`'s `bytesFromPEM` decode an empty key.
yaml_block() {
  local line
  while IFS= read -r line || [ -n "$line" ]; do
    line=${line%$'\r'}
    if [ -z "$line" ]; then
      printf '\n'
    else
      printf '    %s\n' "$line"
    fi
  done <<< "$1"
}
PASSWORDS="$DEPLOY_DIR/config/passwords.yaml"
# Optional SMTP settings for transactional emails (verification codes). When
# SMTP_HOST is set, the values are written to the passwords file so MailService
# can deliver emails; otherwise the server only logs the codes.
SMTP_SETTINGS=""
if [ -n "${SMTP_HOST:-}" ]; then
  SMTP_SETTINGS="
  smtpHost: $(yaml_q "$SMTP_HOST")
  smtpPort: $(yaml_q "${SMTP_PORT:-465}")
  smtpUsername: $(yaml_q "${SMTP_USERNAME:-}")
  smtpPassword: $(yaml_q "${SMTP_PASSWORD:-}")
  smtpFromAddress: $(yaml_q "${SMTP_FROM_ADDRESS:-}")
  smtpFromName: $(yaml_q "${SMTP_FROM_NAME:-Gewerber}")
  smtpSsl: $(yaml_q "${SMTP_SSL:-true}")"
fi

# Optional social sign-in credentials. Each provider block is appended only
# when its driving environment variable is non-empty (`GOOGLE_CLIENT_SECRET_JSON`,
# `APPLE_SERVICE_IDENTIFIER`, `FACEBOOK_APP_ID`, `MICROSOFT_CLIENT_ID`), and
# optional keys within a block (`APPLE_ANDROID_PACKAGE_IDENTIFIER`,
# `APPLE_WEB_REDIRECT_URI`, `MICROSOFT_TENANT`) are written only when their own
# env var is non-empty as well. Absent or blank keys keep the provider disabled
# at startup (logged as `[auth] <provider>: disabled (missing ...)`); the server
# still starts. `GOOGLE_CLIENT_SECRET_JSON` is the downloaded
# `google_client_secret.json` (e.g. `jq -c . google_client_secret.json`),
# single-quoted so the YAML stays valid. `APPLE_KEY` is the multi-line PEM from
# `AuthKey_*.p8` (e.g. `APPLE_KEY="$(cat AuthKey_XXXXXX.p8)"`), written as a
# YAML block scalar (`|`) to preserve newlines for `dart_jsonwebtoken`.
SOCIAL_SETTINGS=""
if [ -n "${GOOGLE_CLIENT_SECRET_JSON:-}" ]; then
  SOCIAL_SETTINGS="$SOCIAL_SETTINGS
  googleClientSecret: $(yaml_q "$GOOGLE_CLIENT_SECRET_JSON")"
fi
if [ -n "${APPLE_SERVICE_IDENTIFIER:-}" ]; then
  SOCIAL_SETTINGS="$SOCIAL_SETTINGS
  appleServiceIdentifier: $(yaml_q "$APPLE_SERVICE_IDENTIFIER")
  appleBundleIdentifier: $(yaml_q "${APPLE_BUNDLE_IDENTIFIER:-}")
  appleRedirectUri: $(yaml_q "${APPLE_REDIRECT_URI:-}")
  appleTeamId: $(yaml_q "${APPLE_TEAM_ID:-}")
  appleKeyId: $(yaml_q "${APPLE_KEY_ID:-}")"
  if [ -n "${APPLE_KEY:-}" ]; then
    SOCIAL_SETTINGS="$SOCIAL_SETTINGS
  appleKey: |
$(yaml_block "$APPLE_KEY")"
  else
    SOCIAL_SETTINGS="$SOCIAL_SETTINGS
  appleKey: $(yaml_q "")"
  fi
  if [ -n "${APPLE_ANDROID_PACKAGE_IDENTIFIER:-}" ]; then
    SOCIAL_SETTINGS="$SOCIAL_SETTINGS
  appleAndroidPackageIdentifier: $(yaml_q "$APPLE_ANDROID_PACKAGE_IDENTIFIER")"
  fi
  if [ -n "${APPLE_WEB_REDIRECT_URI:-}" ]; then
    SOCIAL_SETTINGS="$SOCIAL_SETTINGS
  appleWebRedirectUri: $(yaml_q "$APPLE_WEB_REDIRECT_URI")"
  fi
fi
if [ -n "${FACEBOOK_APP_ID:-}" ]; then
  SOCIAL_SETTINGS="$SOCIAL_SETTINGS
  facebookAppId: $(yaml_q "$FACEBOOK_APP_ID")
  facebookAppSecret: $(yaml_q "${FACEBOOK_APP_SECRET:-}")"
fi
if [ -n "${MICROSOFT_CLIENT_ID:-}" ]; then
  SOCIAL_SETTINGS="$SOCIAL_SETTINGS
  microsoftClientId: $(yaml_q "$MICROSOFT_CLIENT_ID")
  microsoftClientSecret: $(yaml_q "${MICROSOFT_CLIENT_SECRET:-}")"
  if [ -n "${MICROSOFT_TENANT:-}" ]; then
    SOCIAL_SETTINGS="$SOCIAL_SETTINGS
  microsoftTenant: $(yaml_q "$MICROSOFT_TENANT")"
  fi
fi

{
  printf '%s:\n' "$RUNMODE"
  printf '  database: %s\n' "$(yaml_q "$DB_PASSWORD")"
  printf '  serviceSecret: %s\n' "$(yaml_q "$SERVICE_SECRET")"
  printf '  redis: %s\n' "$(yaml_q "$REDIS_PASSWORD")"
  printf '  emailSecretHashPepper: %s\n' "$(yaml_q "$EMAIL_SECRET_HASH_PEPPER")"
  printf '  jwtHmacSha512PrivateKey: %s\n' "$(yaml_q "$JWT_HMAC_SHA512_PRIVATE_KEY")"
  printf '  jwtRefreshTokenHashPepper: %s\n' "$(yaml_q "$JWT_REFRESH_TOKEN_HASH_PEPPER")"
  printf '%s\n' "$SMTP_SETTINGS"
  printf '%s\n' "$SOCIAL_SETTINGS"
} > "$PASSWORDS"
chmod 600 "$PASSWORDS"

# Per-environment .env consumed by docker-compose.yml. `HOST_RULE` contains
# literal backticks (Traefik rule syntax); they are written verbatim.
{
  echo "IMAGE=$IMAGE"
  echo "CONTAINER_NAME=$CONTAINER_NAME"
  echo "ROUTER_PREFIX=$ROUTER_PREFIX"
  echo "HOST_RULE=$HOST_RULE"
  echo "RUNMODE=$RUNMODE"
  echo "DB_PASSWORD=$DB_PASSWORD"
  echo "REDIS_PASSWORD=$REDIS_PASSWORD"
  echo "TRAEFIK_NETWORK=$TRAEFIK_NETWORK"
  echo "WEB_ENTRYPOINT=$WEB_ENTRYPOINT"
  echo "WEBSECURE_ENTRYPOINT=$WEBSECURE_ENTRYPOINT"
  echo "CERT_RESOLVER=$CERT_RESOLVER"
} > "$DEPLOY_DIR/.env"

cd "$DEPLOY_DIR"
docker compose pull
docker compose up -d --remove-orphans
docker image prune -f

echo "Deployed $ENV ($IMAGE) as '$CONTAINER_NAME' -> $HOST_RULE"
