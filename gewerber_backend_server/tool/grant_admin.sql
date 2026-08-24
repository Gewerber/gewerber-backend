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
--   # local development (docker compose service `postgres`, port 8090)
--   psql "postgres://postgres:<password>@localhost:8090/gewerber_backend" \
--       -v email="'you@example.com'" -v role="'admin'" \
--       -f gewerber_backend_server/tool/grant_admin.sql
--
--   # production (deploy/docker-compose.yml service `postgres`)
--   docker compose -f deploy/docker-compose.yml exec postgres \
--     psql -U postgres -d gewerber_backend \
--     -v email="'you@example.com'" -v role="'admin'" \
--     -f - < gewerber_backend_server/tool/grant_admin.sql
--
-- Variables:
--   :email — the login email of an already registered user (required).
--   :role  — 'admin' or 'moderator' (optional, default 'moderator').
--
-- Notes:
--   * The user must have completed registration (an entry must exist in
--     `serverpod_auth_idp_email_account`). Find the userId by email — no
--     need to copy UUIDs by hand.
--   * Re-running the script promotes/demotes an existing allowlist entry
--     (upsert on userId). Setting role='moderator' is the supported way to
--     step an account down from 'admin'.
--   * Every change is recorded in the audit trail (`audit_entry`) with
--     action 'admin.roleGranted' / 'admin.roleChanged' and actor NULL
--     (out-of-band change).

DO $$
DECLARE
    target_user_id uuid;
    effective_role text := COALESCE(:role, 'moderator');
    existing_role  text;
BEGIN
    IF effective_role NOT IN ('moderator', 'admin') THEN
        RAISE EXCEPTION 'Invalid role %, use ''moderator'' or ''admin''',
            effective_role;
    END IF;

    SELECT "authUserId" INTO target_user_id
    FROM serverpod_auth_idp_email_account
    WHERE email = lower(:email);

    IF target_user_id IS NULL THEN
        RAISE EXCEPTION 'No registered user with email %', :email;
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
        jsonb_build_object('from', COALESCE(existing_role, '<none>'), 'to', effective_role)::text,
        now()
    );

    RAISE NOTICE 'Role of % (%) is now %', :email, target_user_id, effective_role;
END $$;
