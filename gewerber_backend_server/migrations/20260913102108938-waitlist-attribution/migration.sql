BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "commercial_waitlist_entry" ADD COLUMN "utmTerm" text;
ALTER TABLE "commercial_waitlist_entry" ADD COLUMN "utmContent" text;
ALTER TABLE "commercial_waitlist_entry" ADD COLUMN "gclid" text;
ALTER TABLE "commercial_waitlist_entry" ADD COLUMN "fbclid" text;
ALTER TABLE "commercial_waitlist_entry" ADD COLUMN "landingPage" text;

--
-- MIGRATION VERSION FOR gewerber_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gewerber_backend', '20260913102108938-waitlist-attribution', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260913102108938-waitlist-attribution', "timestamp" = now();

--
-- MIGRATION VERSION FOR gewerber_backend_commercial
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gewerber_backend_commercial', '20260911152358295', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260911152358295', "timestamp" = now();

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
