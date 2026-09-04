BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "invitation" (
    "id" bigserial PRIMARY KEY,
    "businessId" bigint NOT NULL,
    "email" text NOT NULL,
    "role" text NOT NULL DEFAULT 'member'::text,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "invitedByUserId" uuid,
    "tokenHash" text NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "acceptedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "invitation_business_idx" ON "invitation" USING btree ("businessId");
CREATE UNIQUE INDEX "invitation_business_email_unique_idx" ON "invitation" USING btree ("businessId", "email");
CREATE UNIQUE INDEX "invitation_token_hash_unique_idx" ON "invitation" USING btree ("tokenHash");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "invitation"
    ADD CONSTRAINT "invitation_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR gewerber_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gewerber_backend', '20260904161247135', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260904161247135', "timestamp" = now();

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
