BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "business_settings" ADD COLUMN "iban" text;
ALTER TABLE "business_settings" ADD COLUMN "bic" text;
ALTER TABLE "business_settings" ADD COLUMN "accountHolder" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "customer" ADD COLUMN "buyerReference" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "serverpod_auth_core_profile" DROP CONSTRAINT IF EXISTS "serverpod_auth_core_profile_fk_1";
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_1"
    FOREIGN KEY("imageId")
    REFERENCES "serverpod_auth_core_profile_image"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    DEFERRABLE INITIALLY DEFERRED;

--
-- MIGRATION VERSION FOR gewerber_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gewerber_backend', '20260928071125207', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260928071125207', "timestamp" = now();

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
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();


COMMIT;
