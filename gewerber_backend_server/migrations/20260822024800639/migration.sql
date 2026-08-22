BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "accounting_transaction" (
    "id" bigserial PRIMARY KEY,
    "businessId" bigint NOT NULL,
    "type" text NOT NULL,
    "category" text NOT NULL,
    "description" text,
    "occurredAt" timestamp without time zone NOT NULL,
    "amountCents" bigint NOT NULL,
    "receiptDocumentId" bigint,
    "relatedInvoiceId" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "accounting_transaction_business_idx" ON "accounting_transaction" USING btree ("businessId", "occurredAt");
CREATE INDEX "accounting_transaction_category_idx" ON "accounting_transaction" USING btree ("businessId", "category");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "accounting_transaction"
    ADD CONSTRAINT "accounting_transaction_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "accounting_transaction"
    ADD CONSTRAINT "accounting_transaction_fk_1"
    FOREIGN KEY("receiptDocumentId")
    REFERENCES "document"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "accounting_transaction"
    ADD CONSTRAINT "accounting_transaction_fk_2"
    FOREIGN KEY("relatedInvoiceId")
    REFERENCES "invoice"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR gewerber_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gewerber_backend', '20260822024800639', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260822024800639', "timestamp" = now();

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
