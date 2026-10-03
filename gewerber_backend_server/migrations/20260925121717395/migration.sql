BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "invoice" DROP CONSTRAINT IF EXISTS "invoice_fk_2";
ALTER TABLE "invoice" DROP CONSTRAINT IF EXISTS "invoice_fk_3";
ALTER TABLE "invoice" ADD COLUMN "originalInvoiceId" bigint;
CREATE INDEX "invoice_original_invoice_idx" ON "invoice" USING btree ("originalInvoiceId");
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "invoice"
    ADD CONSTRAINT "invoice_fk_4"
    FOREIGN KEY("pdfDocumentId")
    REFERENCES "document"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "invoice"
    ADD CONSTRAINT "invoice_fk_2"
    FOREIGN KEY("originalInvoiceId")
    REFERENCES "invoice"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "invoice"
    ADD CONSTRAINT "invoice_fk_3"
    FOREIGN KEY("templateId")
    REFERENCES "invoice_template"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR gewerber_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gewerber_backend', '20260925121717395', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260925121717395', "timestamp" = now();

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
    VALUES ('serverpod_auth_idp', '20260910193913364-string-rate-limit-keys', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910193913364-string-rate-limit-keys', "timestamp" = now();


COMMIT;
