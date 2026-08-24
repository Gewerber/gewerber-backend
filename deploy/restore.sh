#!/usr/bin/env bash
# Restores the Gewerber backend PostgreSQL database from a backup created by
# backup.sh (custom format `.dump`).
#
#   Usage: bash restore.sh <path/to/dump> [prod|test] [--yes]
#
# What it does:
#   1. Verifies the dump file and its archive integrity.
#   2. Asks for confirmation (skipped with --yes).
#   3. Stops the API server container (no writes during the restore).
#   4. Runs pg_restore --clean --if-exists --no-owner inside the postgres
#      container (drops and recreates all objects from the dump).
#   5. Restarts the API server container.
#
# This is DESTRUCTIVE: every object currently in $DB_NAME is dropped and
# replaced by the dump's contents. Data written after the backup was taken
# is lost.
#
# Optional environment variables:
#   DEPLOY_DIR – where the environment stack lives (default:
#                $HOME/gewerber/backend/<env>, see deploy.sh)
set -euo pipefail

usage() {
  echo "usage: restore.sh <path/to/dump> [prod|test] [--yes]" >&2
  exit 1
}

DUMP_FILE=""
ENVIRONMENT=""
ASSUME_YES=0
for arg in "$@"; do
  case "$arg" in
    --yes) ASSUME_YES=1 ;;
    prod|test) ENVIRONMENT="$arg" ;;
    *) DUMP_FILE="$arg" ;;
  esac
done
ENVIRONMENT="${ENVIRONMENT:-prod}"
[ -n "$DUMP_FILE" ] || usage

DEPLOY_DIR="${DEPLOY_DIR:-$HOME/gewerber/backend/$ENVIRONMENT}"
COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME:-gewerber-backend-$ENVIRONMENT}"
export COMPOSE_PROJECT_NAME

SERVER_SERVICE="server"
DB_CONTAINER_SERVICE="postgres"
PG_USER="postgres"
DB_NAME="gewerber_backend"

if [ ! -f "$DUMP_FILE" ]; then
  echo "ERROR: dump file not found: $DUMP_FILE" >&2
  exit 1
fi
if [ ! -f "$DEPLOY_DIR/docker-compose.yml" ]; then
  echo "ERROR: no docker-compose.yml in $DEPLOY_DIR — is the stack deployed?" >&2
  exit 1
fi
cd "$DEPLOY_DIR"

echo "Environment : $ENVIRONMENT ($DEPLOY_DIR)"
echo "Target DB   : $DB_NAME (container service: $DB_CONTAINER_SERVICE)"
echo "Dump file   : $DUMP_FILE ($(du -h "$DUMP_FILE" | cut -f1))"

# Integrity check with the container's own pg_restore before touching
# anything.
if ! docker compose exec -T "$DB_CONTAINER_SERVICE" \
    pg_restore --list /dev/stdin < "$DUMP_FILE" > /dev/null; then
  echo "ERROR: '$DUMP_FILE' is not a valid pg_dump custom-format archive." >&2
  exit 1
fi
echo "Integrity   : OK"

if [ "$ASSUME_YES" -ne 1 ]; then
  echo
  echo "WARNING: this DROPS everything currently in '$DB_NAME' and restores"
  echo "the dump. Anything written after the backup was taken is lost."
  read -r -p "Type 'restore' to continue: " ANSWER
  if [ "$ANSWER" != "restore" ]; then
    echo "Aborted."
    exit 1
  fi
fi

echo "[$(date -Is)] Stopping API server ..."
docker compose stop "$SERVER_SERVICE"

echo "[$(date -Is)] Restoring database ..."
if docker compose exec -T "$DB_CONTAINER_SERVICE" \
    pg_restore \
      -U "$PG_USER" \
      -d "$DB_NAME" \
      --clean \
      --if-exists \
      --no-owner \
      < "$DUMP_FILE"; then
  echo "[$(date -Is)] Restore finished."
else
  STATUS=$?
  # pg_restore exits 1 also when *some* objects could not be restored (e.g.
  # harmless extension/ownership warnings); anything above that is fatal.
  if [ "$STATUS" -le 1 ]; then
    echo "[$(date -Is)] Restore finished WITH WARNINGS (exit $STATUS)."
    echo "Check the messages above for ignored errors."
  else
    echo "ERROR: pg_restore failed (exit $STATUS)." >&2
    echo "The server stays STOPPED so you can retry or inspect manually:" >&2
    echo "  cd $DEPLOY_DIR && docker compose start $SERVER_SERVICE" >&2
    exit "$STATUS"
  fi
fi

echo "[$(date -Is)] Starting API server ..."
docker compose start "$SERVER_SERVICE"

echo
echo "Done. Recommended follow-ups:"
echo "  - Watch startup logs: docker compose logs -f $SERVER_SERVICE"
echo "    (migrations re-apply automatically if the dump predates them;"
echo "     SERVERPOD_APPLY_MIGRATIONS=true)"
echo "  - Flush Redis if cached data may be stale:"
echo "    docker compose exec redis redis-cli -a \"\$REDIS_PASSWORD\" FLUSHDB"
echo "  - Verify data, e.g.:"
echo "    docker compose exec $DB_CONTAINER_SERVICE psql -U $PG_USER -d $DB_NAME \\"
echo "      -c 'SELECT max(\"time\") FROM serverpod_session_log;'"
