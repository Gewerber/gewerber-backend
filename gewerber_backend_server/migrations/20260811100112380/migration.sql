BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "business_settings" (
    "id" bigserial PRIMARY KEY,
    "businessId" bigint NOT NULL,
    "paymentTermsDays" bigint NOT NULL DEFAULT 14,
    "invoiceNumberPrefix" text,
    "invoiceNumberIncludeYear" boolean NOT NULL DEFAULT true,
    "invoiceNumberMinDigits" bigint NOT NULL DEFAULT 4,
    "roundingMode" text NOT NULL DEFAULT 'none'::text,
    "roundingGranularityMinutes" bigint NOT NULL DEFAULT 1,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "business_settings_business_unique_idx" ON "business_settings" USING btree ("businessId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "document" (
    "id" bigserial PRIMARY KEY,
    "businessId" bigint NOT NULL,
    "kind" text NOT NULL DEFAULT 'attachment'::text,
    "fileName" text NOT NULL,
    "mimeType" text,
    "sizeBytes" bigint,
    "storageLocation" text NOT NULL DEFAULT 'private'::text,
    "storagePath" text NOT NULL,
    "relatedEntityType" text,
    "relatedEntityId" text,
    "uploadedById" uuid,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "document_business_idx" ON "document" USING btree ("businessId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "number_sequence" (
    "id" bigserial PRIMARY KEY,
    "businessId" bigint NOT NULL,
    "key" text NOT NULL,
    "year" bigint NOT NULL,
    "lastValue" bigint NOT NULL DEFAULT 0,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "number_sequence_business_key_year_unique_idx" ON "number_sequence" USING btree ("businessId", "key", "year");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_profile" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "displayName" text,
    "locale" text NOT NULL DEFAULT 'de'::text,
    "timeZone" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "user_profile_user_unique_idx" ON "user_profile" USING btree ("userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "business_settings"
    ADD CONSTRAINT "business_settings_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "document"
    ADD CONSTRAINT "document_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "number_sequence"
    ADD CONSTRAINT "number_sequence_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR gewerber_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gewerber_backend', '20260811100112380', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260811100112380', "timestamp" = now();

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
