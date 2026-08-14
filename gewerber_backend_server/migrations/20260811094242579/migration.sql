BEGIN;

--
-- ACTION ALTER TABLE
--
-- Currency became an enum serialized byName (lowercase 'eur').
-- Normalize existing values instead of dropping the column (data safe).
UPDATE "business"
SET "currency" = lower("currency")
WHERE "currency" IS DISTINCT FROM lower("currency");

ALTER TABLE "business" ALTER COLUMN "currency" SET DEFAULT 'eur'::text;

-- Address.country became the Country enum (ISO alpha-3, byName).
-- The address is stored as embedded json; normalize the legacy alpha-2 default.
UPDATE "business"
SET "address" = jsonb_set("address"::jsonb, '{country}', '"deu"', false)::json
WHERE "address" IS NOT NULL AND "address" ->> 'country' = 'DE';

--
-- MIGRATION VERSION FOR gewerber_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gewerber_backend', '20260811094242579', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260811094242579', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260416151914983-insights-perf', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260416151914983-insights-perf', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260417182309198', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260417182309198', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260417182253191', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260417182253191', "timestamp" = now();


COMMIT;
