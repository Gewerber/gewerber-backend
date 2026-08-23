BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "membership" ALTER COLUMN "userId" DROP NOT NULL;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "user_guidance_progress" ALTER COLUMN "userId" DROP NOT NULL;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "user_profile" ADD COLUMN "deletedAt" timestamp without time zone;

--
-- MIGRATION VERSION FOR gewerber_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gewerber_backend', '20260822122132369', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260822122132369', "timestamp" = now();

--
-- MIGRATION VERSION FOR gewerber_commercial
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gewerber_commercial', '20260814083449413', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260814083449413', "timestamp" = now();

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
