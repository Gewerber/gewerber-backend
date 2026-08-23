#!/usr/bin/env bash
# Creates a PostgreSQL backup of the Gewerber backend database.
#
#   Usage: bash backup.sh [prod|test]
#
# Dumps the database inside the running postgres container (custom format,
# `-Fc`) into $BACKUP_DIR with a daily-stamped file name, verifies the
# archive and prunes backups older than $KEEP_DAYS days.
#
# Recommended schedule (crontab -e on the VPS):
#
#   # Daily Gewerber backend backup at 02:30, keep 14 days
#   30 2 * * * /opt/gewerber/deploy/backup.sh prod >> "$HOME/gewerber/backups/prod/backup.log" 2>&1
#
# For a tighter RPO than 24h run the same script more often (the file name
# carries a timestamp, reruns never overwrite each other), e.g. every 6 hours:
#
#   30 2,8,14,20 * * * /opt/gewerber/deploy/backup.sh prod >> "$HOME/gewerber/backups/prod/backup.log" 2>&1
#
# Optional environment variables:
#   DEPLOY_DIR   – where the environment stack lives (default:
#                  $HOME/gewerber/backend/<env>, must contain .env +
#                  docker-compose.yml, see deploy.sh)
#   BACKUP_DIR   – output directory (default: $HOME/gewerber/backups/<env>)
#   KEEP_DAYS    – prune dumps older than this many days (default: 14, 0 =
#                  keep forever)
set -euo pipefail

ENVIRONMENT="${1:-prod}"
case "$ENVIRONMENT" in
  prod|test) ;;
  *)
    echo "ERROR: unknown env '$ENVIRONMENT' (expected 'prod' or 'test')" >&2
    exit 1
    ;;
esac

DEPLOY_DIR="${DEPLOY_DIR:-$HOME/gewerber/backend/$ENVIRONMENT}"
BACKUP_DIR="${BACKUP_DIR:-$HOME/gewerber/backups/$ENVIRONMENT}"
KEEP_DAYS="${KEEP_DAYS:-14}"

COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME:-gewerber-backend-$ENVIRONMENT}"
export COMPOSE_PROJECT_NAME

DB_CONTAINER_SERVICE="postgres"
PG_USER="postgres"
DB_NAME="gewerber_backend"

if [ ! -f "$DEPLOY_DIR/docker-compose.yml" ]; then
  echo "ERROR: no docker-compose.yml in $DEPLOY_DIR — is the stack deployed?" >&2
  exit 1
fi
cd "$DEPLOY_DIR"

if ! docker compose ps --status running --services | grep -qx "$DB_CONTAINER_SERVICE"; then
  echo "ERROR: postgres container is not running in $DEPLOY_DIR." >&2
  exit 1
fi

STAMP="$(date +%Y%m%d_%H%M%S)"
OUT_FILE="$BACKUP_DIR/${DB_NAME}_${STAMP}.dump"
mkdir -p "$BACKUP_DIR"

echo "[$(date -Is)] Dumping $DB_NAME -> $OUT_FILE ..."
# `-T` disables the pseudo-TTY so the binary stream passes through unharmed;
# pg_dump fails (non-zero) on read errors thanks to `set -o pipefail`.
docker compose exec -T "$DB_CONTAINER_SERVICE" \
  pg_dump -U "$PG_USER" -d "$DB_NAME" -Fc > "$OUT_FILE"

if [ ! -s "$OUT_FILE" ]; then
  echo "ERROR: dump is empty ($OUT_FILE) — NOT removing it, investigate first." >&2
  exit 1
fi

# Integrity check: list the archive contents with the container's own
# pg_restore (same version family as the dump).
if ! docker compose exec -T "$DB_CONTAINER_SERVICE" \
    pg_restore --list /dev/stdin < "$OUT_FILE" > /dev/null; then
  echo "ERROR: dump failed integrity check ($OUT_FILE)." >&2
  exit 1
fi

SIZE="$(du -h "$OUT_FILE" | cut -f1)"
echo "[$(date -Is)] Backup OK: $OUT_FILE ($SIZE)"

if [ "$KEEP_DAYS" -gt 0 ] 2>/dev/null; then
  PRUNED="$(find "$BACKUP_DIR" -name "${DB_NAME}_*.dump" -type f -mtime +"$KEEP_DAYS" -print -delete | wc -l)"
  if [ "$PRUNED" -gt 0 ]; then
    echo "[$(date -Is)] Pruned $PRUNED backup(s) older than $KEEP_DAYS day(s)."
  fi
fi
