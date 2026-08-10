BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "audit_entry" (
    "id" bigserial PRIMARY KEY,
    "businessId" bigint,
    "userId" uuid,
    "action" text NOT NULL,
    "entityType" text NOT NULL,
    "entityId" text,
    "changes" json,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "audit_entry_business_idx" ON "audit_entry" USING btree ("businessId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "business" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "legalForm" text NOT NULL DEFAULT 'einzelunternehmen'::text,
    "isKleinunternehmer" boolean NOT NULL DEFAULT false,
    "vatId" text,
    "taxNumber" text,
    "email" text,
    "phone" text,
    "address" json,
    "locale" text NOT NULL DEFAULT 'de'::text,
    "currency" text NOT NULL DEFAULT 'EUR'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "membership" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "businessId" bigint NOT NULL,
    "role" text NOT NULL DEFAULT 'member'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "membership_user_business_unique_idx" ON "membership" USING btree ("userId", "businessId");
CREATE INDEX "membership_business_idx" ON "membership" USING btree ("businessId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "membership"
    ADD CONSTRAINT "membership_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR gewerber_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gewerber_backend', '20260810125218695', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260810125218695', "timestamp" = now();

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
