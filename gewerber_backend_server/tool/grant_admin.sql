-- grant_admin.sql — bootstrap the first global administrator.
--
-- The admin API (endpoints `adminStats`, `adminUsers`, `adminBusinesses`,
-- `adminInvoices`, `adminAudit`, `adminGuidance`) authorizes every call
-- against the `admin_user` allowlist table. Because only admins can manage
-- admins through the API, the very first role must be granted out of band —
-- this script.
--
-- Usage (adjust connection settings to your environment):
--
--   # local development (gewerber_backend_server/docker-compose.yaml,
--   # service `postgres`, port 8090)
--   psql "postgres://postgres:<password>@localhost:8090/gewerber_backend" \
--       -v email=you@example.com -v role=admin \
--       -f gewerber_backend_server/tool/grant_admin.sql
--
--   # production (deploy/docker-compose.yml service `postgres`)
--   docker compose -f deploy/docker-compose.yml exec postgres \
--     psql -U postgres -d gewerber_backend \
--     -v email=you@example.com -v role=admin \
--     -f - < gewerber_backend_server/tool/grant_admin.sql
--
-- Variables (plain psql variables, passed on the command line):
--   email — login email of an already registered user (required).
--   role  — 'admin' or 'moderator' (optional, default 'moderator').
--
--   Omit `-v role=...` entirely to get the default. Omitting `-v email`
--   fails cleanly with an exception. Values may be written with or without
--   embedded single quotes: both `-v role=admin` and the older spelling
--   `-v role="'admin'"` work (surrounding quotes are stripped by the
--   script). Do NOT quote like `-v "role=admin"`.
--
-- Implementation note:
--   psql does NOT interpolate :variables inside the dollar-quoted body of
--   `DO $$ ... $$` — the body reaches the server verbatim and a literal
--   ":role" causes `ERROR: syntax error at or near ":"`. The parameters are
--   therefore passed via session-level custom GUCs, set OUTSIDE the DO block
--   (where psql interpolation works) with set_config(), and read back inside
--   the block with current_setting().
--
-- Notes:
--   * The user must have completed registration (an entry must exist in
--     `serverpod_auth_idp_email_account`). Find the userId by lower(email) —
--     no need to copy UUIDs by hand.
--   * Re-running the script promotes/demotes an existing allowlist entry
--     (upsert on userId). Setting role='moderator' is the supported way to
--     step an account down from 'admin'.
--   * Every change is recorded in the audit trail (`audit_entry`) with
--     action 'admin.roleGranted' / 'admin.roleChanged' and actor NULL
--     (out-of-band change).
--   * ON_ERROR_STOP makes psql exit non-zero on failure (unknown email,
--     invalid role), so this is safe to call from scripts/CI.

\set ON_ERROR_STOP on

-- Pass parameters via custom GUCs because psql variable interpolation does
-- not happen inside the dollar-quoted DO body below. The \if :{?var} guards
-- matter: psql leaves references to UNDEFINED variables untouched in the
-- query text (it does not substitute NULL), which would surface as a
-- confusing `syntax error at or near ":"` on the server.
--
-- btrim(..., '''') strips optional surrounding single quotes so that both
-- `-v role=admin` and the legacy `-v role="'admin'"` spellings work.
-- An omitted email ends up as an empty setting and fails with a clear
-- exception inside the DO block; an omitted or empty role selects the
-- documented default 'moderator' there.

\if :{?email}
SELECT set_config('gewerber.grant_email', btrim(:'email', ''''), false);
\else
SELECT set_config('gewerber.grant_email', '', false);
\endif

\if :{?role}
SELECT set_config('gewerber.grant_role', btrim(:'role', ''''), false);
\else
SELECT set_config('gewerber.grant_role', '', false);
\endif

DO $$
DECLARE
    target_user_id uuid;
    existing_role  text;
    -- missing_ok=true keeps `role` genuinely optional: unset (or empty)
    -- yields NULL, which COALESCE turns into the documented default.
    effective_role text :=
        COALESCE(NULLIF(current_setting('gewerber.grant_role', true), ''), 'moderator');
    v_email        text := lower(current_setting('gewerber.grant_email', true));
BEGIN
    IF v_email IS NULL OR v_email = '' THEN
        RAISE EXCEPTION 'Missing email, pass -v email=<address> to psql';
    END IF;

    IF effective_role IS NULL OR effective_role NOT IN ('moderator', 'admin') THEN
        RAISE EXCEPTION 'Invalid role %, use ''moderator'' or ''admin''',
            effective_role;
    END IF;

    SELECT "authUserId" INTO target_user_id
    FROM serverpod_auth_idp_email_account
    WHERE email = v_email;

    IF target_user_id IS NULL THEN
        RAISE EXCEPTION 'No registered user with email %', v_email;
    END IF;

    SELECT role INTO existing_role FROM admin_user WHERE "userId" = target_user_id;

    INSERT INTO admin_user ("userId", role, "createdBy")
    VALUES (target_user_id, effective_role, NULL)
    ON CONFLICT ("userId") DO UPDATE SET role = EXCLUDED.role;

    INSERT INTO audit_entry ("userId", action, "entityType", "entityId", changes, "createdAt")
    VALUES (
        NULL,
        CASE WHEN existing_role IS NULL THEN 'admin.roleGranted' ELSE 'admin.roleChanged' END,
        'AdminUser',
        target_user_id::text,
        -- The `changes` column is of type json (Serverpod Map<String,String>?),
        -- so build native json here. Casting to text fails with
        -- `column "changes" is of type json but expression is of type text`.
        json_build_object('from', COALESCE(existing_role, '<none>'), 'to', effective_role),
        now()
    );

    RAISE NOTICE 'Role of % (%) is now %', v_email, target_user_id, effective_role;
END $$;
