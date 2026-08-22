BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "project" (
    "id" bigserial PRIMARY KEY,
    "businessId" bigint NOT NULL,
    "name" text NOT NULL,
    "status" text NOT NULL DEFAULT 'active'::text,
    "customerId" bigint,
    "hourlyRateCents" bigint,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "project_business_idx" ON "project" USING btree ("businessId", "status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "task" (
    "id" bigserial PRIMARY KEY,
    "businessId" bigint NOT NULL,
    "projectId" bigint NOT NULL,
    "name" text NOT NULL,
    "status" text NOT NULL DEFAULT 'open'::text,
    "hourlyRateCents" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "task_business_idx" ON "task" USING btree ("businessId", "status");
CREATE INDEX "task_project_idx" ON "task" USING btree ("projectId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "time_entry" (
    "id" bigserial PRIMARY KEY,
    "businessId" bigint NOT NULL,
    "projectId" bigint,
    "taskId" bigint,
    "description" text,
    "startedAt" timestamp without time zone NOT NULL,
    "stoppedAt" timestamp without time zone,
    "durationMinutes" bigint,
    "billable" boolean NOT NULL DEFAULT true,
    "invoicedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "time_entry_business_started_idx" ON "time_entry" USING btree ("businessId", "startedAt");
CREATE INDEX "time_entry_project_idx" ON "time_entry" USING btree ("projectId");
CREATE INDEX "time_entry_task_idx" ON "time_entry" USING btree ("taskId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "project"
    ADD CONSTRAINT "project_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "project"
    ADD CONSTRAINT "project_fk_1"
    FOREIGN KEY("customerId")
    REFERENCES "customer"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "task"
    ADD CONSTRAINT "task_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "task"
    ADD CONSTRAINT "task_fk_1"
    FOREIGN KEY("projectId")
    REFERENCES "project"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "time_entry"
    ADD CONSTRAINT "time_entry_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "time_entry"
    ADD CONSTRAINT "time_entry_fk_1"
    FOREIGN KEY("projectId")
    REFERENCES "project"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "time_entry"
    ADD CONSTRAINT "time_entry_fk_2"
    FOREIGN KEY("taskId")
    REFERENCES "task"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR gewerber_backend
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gewerber_backend', '20260822023736942', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260822023736942', "timestamp" = now();

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
