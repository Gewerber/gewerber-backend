# Deployment — operations runbook

Stack per environment (prod / test): Serverpod API server + PostgreSQL 16
(pgvector image) + Redis, behind Traefik. See `docker-compose.yml`,
`.env.example` and `deploy.sh` for the wiring. Secrets are generated once per
environment by `deploy.sh` into `~/gewerber/backend/<env>/.secrets`.

| File | Purpose |
|---|---|
| `deploy.sh` | Deploy/upgrade one environment (CI calls it). |
| `backup.sh` | `pg_dump` (custom format) with daily-stamped names + retention pruning. |
| `restore.sh` | Verified, confirmed `pg_restore --clean` restore of a dump. |
| `docker-compose.yml` | Service stack incl. resource limits (mem/cpu). |
| `.env.example` | Self-hosting reference configuration. |

---

## Backups (`backup.sh`)

Dumps the database inside the running postgres container (`pg_dump -Fc`,
custom format) to `$BACKUP_DIR/gewerber_backend_<YYYYMMDD>_<HHMMSS>.dump`,
verifies the archive with the container's own `pg_restore --list`, then
prunes dumps older than `$KEEP_DAYS` days (default 14).

```bash
bash deploy/backup.sh prod          # or: test
# overrides:
DEPLOY_DIR=... BACKUP_DIR=... KEEP_DAYS=30 bash deploy/backup.sh prod
```

Cron examples (VPS, `crontab -e`) — also in the script header:

```cron
# Daily backup at 02:30, keep 14 days
30 2 * * * /opt/gewerber/deploy/backup.sh prod >> "$HOME/gewerber/backups/prod/backup.log" 2>&1

# Tighter RPO: every 6 hours (file names carry timestamps, no overwrites)
30 2,8,14,20 * * * /opt/gewerber/deploy/backup.sh prod >> "$HOME/gewerber/backups/prod/backup.log" 2>&1
```

Notes:

- Redis is treated as a **cache** and is **not backed up** (see the
  [Redis](#redis) section below for what it holds and why persistence is
  off).
- Backups land on the VPS filesystem by default. Ship them off-box (S3,
  restic, borg, ...) — a backup on the same disk as the database is not a
  disaster-recovery copy.

## Restore (`restore.sh`)

```bash
bash deploy/restore.sh ~/gewerber/backups/prod/gewerber_backend_20260823_023001.dump prod
bash deploy/restore.sh <dump> prod --yes   # skip the confirmation prompt
```

The script verifies the archive first, stops the API server container,
restores with `--clean --if-exists --no-owner`, restarts the server and prints
follow-up steps. It is destructive: everything currently in the target
database is replaced by the dump's contents.

### Restore runbook

**Targets**

- **RPO ≤ 24 h** with the daily cron (≤ 6 h with the every-6-hours schedule).
  Anything tighter needs WAL archiving/PITR — out of scope here.
- **RTO ≈ 15–30 min**: verification (~2 min) + restore (minutes, size-bound)
  + server start incl. migration check (~2 min) + smoke tests. Practice the
  runbook on staging (`test` env) before you need it.

**Order of actions**

1. Declare the incident; stop traffic at Traefik if the corruption is
   application-visible (pause writes).
2. Take a safety dump of the *broken* current state first
   (`bash deploy/backup.sh prod`) — restores have gone wrong before.
3. Pick the newest intact dump: check `backup.log`, verify each candidate
   with `restore.sh <dump> prod` (it aborts before touching anything if the
   archive is invalid — answer anything but `restore` at the prompt).
4. Run the full restore (script stops/starts the API server itself).
5. Watch startup: `docker compose logs -f server`. If the dump predates the
   latest migrations they re-apply automatically
   (`SERVERPOD_APPLY_MIGRATIONS=true`). If migrations fail, stop and fix
   manually — do not loop-restart.
6. Flush Redis if stale cached data is plausible:
   `docker compose exec redis redis-cli -a "$REDIS_PASSWORD" FLUSHDB`.
7. Smoke tests against `api.gewerber.de`: login, business list, invoice list,
   PDF generation. Verify data currency in SQL:
   `SELECT max("time") FROM serverpod_session_log;`
8. Re-enable traffic, write down timeline + root cause.

---

## Resource limits

`docker-compose.yml` sets `deploy.resources.limits` on all three services
(honored by plain `docker compose up`, not only Swarm):

| Service | Memory limit | CPU limit | Default reservation |
|---|---|---|---|
| server | 1g | 1.0 | 256m |
| postgres | 512m | 0.50 | 256m |
| redis | 256m | 0.25 | 64m |

Override per environment via `.env` (all variables are listed commented in
`.env.example`, e.g. `SERVER_MEM_LIMIT=2g`). Sizing rule of thumb: give
PostgreSQL headroom above the working set; watch `docker stats` after
changing limits — a throttled database shows up as latency long before it
shows up as errors.

## Log retention (Serverpod session logs)

With `sessionLogs.persistentEnabled: true` (currently set in
`config/development.yaml`, `config/staging.yaml` and
`config/production.yaml`) Serverpod persists one row per session/request into
PostgreSQL:

- `serverpod_session_log` — one row per session (endpoint/method, duration,
  error, stackTrace),
- `serverpod_query_log` / `serverpod_message_log` — child rows linked via
  `sessionLogId`.

Without cleanup these tables grow unboundedly (they are written on every API
call), slow Insights down and inflate backups.

**Serverpod 4 now cleans up automatically**: since `config/production.yaml`
and `config/staging.yaml` set `sessionLogs.retentionPeriod: 30d` with
`cleanupInterval: 1h`, the server prunes session logs older than 30 days
every hour on its own. The SQL/cron recipe below is kept as a fallback (e.g.
for older self-hosted deployments without the explicit retention settings)
and as a dev tool for ad-hoc pruning.

**Option A — turn persistence off** (console-only logging): set
`sessionLogs.persistentEnabled: false` in the relevant
`gewerber_backend_server/config/<runmode>.yaml`. You lose the Insights
history but stop the growth entirely. Reasonable for staging.

**Option B — keep persistence, prune regularly** (fallback for deployments
without the explicit retention settings, e.g. older self-hosted ones):
delete sessions older than N days (30 is a sensible default); child tables
are cleaned first, parent second:

```sql
BEGIN;
DELETE FROM serverpod_query_log
 WHERE "sessionLogId" IN (
   SELECT "id" FROM serverpod_session_log WHERE "time" < now() - interval '30 days'
 );
DELETE FROM serverpod_message_log
 WHERE "sessionLogId" IN (
   SELECT "id" FROM serverpod_session_log WHERE "time" < now() - interval '30 days'
 );
DELETE FROM serverpod_session_log WHERE "time" < now() - interval '30 days';
COMMIT;
VACUUM ANALYZE serverpod_session_log;
```

(`serverpod_*` log tables are module-managed; do not add FKs or triggers to
them.) Run it from the VPS, e.g. weekly via cron:

```cron
# Prune Serverpod logs older than 30 days, Sundays 04:15
15 4 * * 0 docker compose -f "$HOME/gewerber/backend/prod/docker-compose.yml" \
  -p gewerber-backend-prod exec -T postgres \
  psql -U postgres -d gewerber_backend \
  -c "DELETE FROM serverpod_query_log WHERE \"sessionLogId\" IN (SELECT \"id\" FROM serverpod_session_log WHERE \"time\" < now() - interval '30 days'); DELETE FROM serverpod_message_log WHERE \"sessionLogId\" IN (SELECT \"id\" FROM serverpod_session_log WHERE \"time\" < now() - interval '30 days'); DELETE FROM serverpod_session_log WHERE \"time\" < now() - interval '30 days';"
```

(Add `VACUUM ANALYZE ...` statements as needed; autovacuum usually keeps up.)

---

## Redis

The stack ships a `redis` service per environment (`deploy/docker-compose.yml`),
wired into the server via the `redis:` section of
`config/production.yaml` / `config/staging.yaml` (password from
`passwords.yaml`, generated by `deploy.sh`). Local development and tests run
**without** Redis (no `redis:` section in `development.yaml` / `test.yaml`) —
which is the first hint that it is optional today.

### What Serverpod uses Redis for

| Feature | Backend | Needs Redis? |
|---|---|---|
| `session.caches.local` / `localPrio` | in-process memory | no |
| `session.caches.global` (shared L2 cache) | Redis-backed | **yes** |
| MessageCentral (`session.messages`) — pub/sub between server instances, streams | Redis pub/sub | **yes** |
| Future calls (recurring invoice jobs) | PostgreSQL table | no |
| Auth sessions / JWT keys | PostgreSQL (serverpod_auth tables) | no |
| Session/request logs | PostgreSQL (`serverpod_*` log tables) | no |

### What this project actually uses

Audited 2026-08: application code uses **none** of the Redis-backed features.

- No `session.caches` usage anywhere in `gewerber_backend_server/lib/src`.
- The `EventBus` wrapper around MessageCentral (`core/events/`) was removed
  in the 2026-09 audit (registered in DI but never used — see TODO
  «Техдолг»); MessageCentral itself stays available via `session.messages`.
- Background jobs are FutureCalls stored in PostgreSQL; auth state lives in
  PostgreSQL.

Redis is provisioned as **headroom for scaling**: the moment a second server
replica appears, the global cache and cross-instance messaging need a shared
broker. With one replica it is idle capacity (~30 MB RSS under an empty
workload).

### Persistence decision: OFF (no RDB, no AOF)

`docker-compose.yml` starts Redis with `--save "" --appendonly no`.

Rationale:

1. Everything durable lives in PostgreSQL — invoices, audit trail, future
   call schedules, sessions. Redis holds only rebuildable cache/pub-sub
   state; losing its contents is invisible to correctness.
2. A cache that survives restarts is a liability, not a feature: stale cache
   entries would outlive schema changes. Cold-start repopulation cost is
   irrelevant while the cache is empty anyway.
3. RDB snapshots would spend the (small) memory/CPU budget on writing data
   we have decided not to keep, and AOF would add fsync latency for the same
   nothing.
   4. Backups deliberately exclude Redis (see [Backups](#backups-backupsh)) —
   persisting to disk would create a false sense of a second data copy.

If the project ever moves real state into Redis (e.g. distributed locks for
future calls across replicas, rate limiting windows that must survive
restarts), revisit this decision and add Redis to the backup story in the
same change.

### When Redis is needed vs when it can be dropped

Keep it (current default) when any of the following becomes true:

- more than one API-server replica behind Traefik (shared cache + messaging),
- code starts using `session.caches.global`,
- WebSocket/stream features fan out across instances (Этап 3 roadmap items).

It can be dropped today (single-replica OSS/self-hosted deployments):

1. remove the `redis` service from `deploy/docker-compose.yml`,
2. remove the `redis:` section from `config/<runmode>.yaml`
   (and the `redis` password from `passwords.yaml` / `.secrets`),
3. restart; the server falls back to local caches and logs which features
   are degraded.

Conversely, if you scale to multiple replicas, also plan sticky sessions for
WebSockets in Traefik and distributed locks for FutureCalls — see Этап 3 in
the project TODO.
