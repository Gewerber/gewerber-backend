BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "invitation" ADD COLUMN "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP;

--
-- MIGRATION VERSION FOR gewerber_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gewerber_backend', '20260904161325953', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260904161325953', "timestamp" = now();

--
-- MIGRATION VERSION FOR gewerber_backend_commercial
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gewerber_backend_commercial', '20260814083449413', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260814083449413', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260824182354731', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182354731', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260824182405944', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182405944', "timestamp" = now();


COMMIT;
