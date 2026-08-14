BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "customer" (
    "id" bigserial PRIMARY KEY,
    "businessId" bigint NOT NULL,
    "status" text NOT NULL DEFAULT 'active'::text,
    "name" text NOT NULL,
    "companyName" text,
    "vatId" text,
    "email" text,
    "phone" text,
    "address" json,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "customer_business_idx" ON "customer" USING btree ("businessId", "status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "invoice" (
    "id" bigserial PRIMARY KEY,
    "businessId" bigint NOT NULL,
    "number" text NOT NULL,
    "type" text NOT NULL DEFAULT 'invoice'::text,
    "status" text NOT NULL DEFAULT 'draft'::text,
    "customerId" bigint,
    "issueDate" timestamp without time zone NOT NULL,
    "dueDate" timestamp without time zone,
    "serviceDateFrom" timestamp without time zone,
    "serviceDateTo" timestamp without time zone,
    "locale" text NOT NULL DEFAULT 'de'::text,
    "currency" text NOT NULL DEFAULT 'eur'::text,
    "subtotalCents" bigint NOT NULL DEFAULT 0,
    "vatTotalCents" bigint NOT NULL DEFAULT 0,
    "totalCents" bigint NOT NULL DEFAULT 0,
    "paymentTermsDays" bigint NOT NULL DEFAULT 14,
    "dunningLevel" bigint NOT NULL DEFAULT 0,
    "notes" text,
    "templateId" bigint,
    "pdfDocumentId" bigint,
    "recurrenceInterval" text,
    "nextRecurrenceDate" timestamp without time zone,
    "recurrenceEndDate" timestamp without time zone,
    "recurrenceMaxOccurrences" bigint,
    "recurrenceOccurrencesCreated" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "invoice_business_number_unique_idx" ON "invoice" USING btree ("businessId", "number");
CREATE INDEX "invoice_business_issue_idx" ON "invoice" USING btree ("businessId", "issueDate");
CREATE INDEX "invoice_customer_idx" ON "invoice" USING btree ("customerId");
CREATE INDEX "invoice_recurrence_idx" ON "invoice" USING btree ("businessId", "nextRecurrenceDate");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "invoice_item" (
    "id" bigserial PRIMARY KEY,
    "invoiceId" bigint NOT NULL,
    "position" bigint NOT NULL,
    "description" text NOT NULL,
    "quantity" double precision NOT NULL DEFAULT 1,
    "unit" text NOT NULL DEFAULT 'hour'::text,
    "unitPriceCents" bigint NOT NULL DEFAULT 0,
    "vatRate" text NOT NULL DEFAULT 'standard'::text,
    "lineTotalCents" bigint NOT NULL DEFAULT 0
);

-- Indexes
CREATE INDEX "invoice_item_invoice_idx" ON "invoice_item" USING btree ("invoiceId", "position");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "invoice_template" (
    "id" bigserial PRIMARY KEY,
    "businessId" bigint NOT NULL,
    "name" text NOT NULL,
    "isDefault" boolean NOT NULL DEFAULT false,
    "headerText" text,
    "footerText" text,
    "logoDocumentId" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "invoice_template_business_idx" ON "invoice_template" USING btree ("businessId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "payment_record" (
    "id" bigserial PRIMARY KEY,
    "invoiceId" bigint NOT NULL,
    "paidAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "amountCents" bigint NOT NULL,
    "method" text NOT NULL DEFAULT 'bankTransfer'::text,
    "reference" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "payment_record_invoice_idx" ON "payment_record" USING btree ("invoiceId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "reminder" (
    "id" bigserial PRIMARY KEY,
    "invoiceId" bigint NOT NULL,
    "level" bigint NOT NULL,
    "sentAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "reminder_invoice_idx" ON "reminder" USING btree ("invoiceId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "customer"
    ADD CONSTRAINT "customer_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "invoice"
    ADD CONSTRAINT "invoice_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "invoice"
    ADD CONSTRAINT "invoice_fk_1"
    FOREIGN KEY("customerId")
    REFERENCES "customer"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "invoice"
    ADD CONSTRAINT "invoice_fk_2"
    FOREIGN KEY("templateId")
    REFERENCES "invoice_template"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "invoice"
    ADD CONSTRAINT "invoice_fk_3"
    FOREIGN KEY("pdfDocumentId")
    REFERENCES "document"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "invoice_item"
    ADD CONSTRAINT "invoice_item_fk_0"
    FOREIGN KEY("invoiceId")
    REFERENCES "invoice"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "invoice_template"
    ADD CONSTRAINT "invoice_template_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "invoice_template"
    ADD CONSTRAINT "invoice_template_fk_1"
    FOREIGN KEY("logoDocumentId")
    REFERENCES "document"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "payment_record"
    ADD CONSTRAINT "payment_record_fk_0"
    FOREIGN KEY("invoiceId")
    REFERENCES "invoice"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "reminder"
    ADD CONSTRAINT "reminder_fk_0"
    FOREIGN KEY("invoiceId")
    REFERENCES "invoice"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR gewerber_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gewerber_backend', '20260814065459008', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260814065459008', "timestamp" = now();

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
