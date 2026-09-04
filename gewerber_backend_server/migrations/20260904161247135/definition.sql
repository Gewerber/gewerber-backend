BEGIN;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- Class AccountingTransaction as table accounting_transaction
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
-- Class AdminUser as table admin_user
--
CREATE TABLE "admin_user" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "role" text NOT NULL DEFAULT 'moderator'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdBy" uuid
);

-- Indexes
CREATE UNIQUE INDEX "admin_user_user_unique_idx" ON "admin_user" USING btree ("userId");

--
-- Class AuditEntry as table audit_entry
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
-- Class Business as table business
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
    "currency" text NOT NULL DEFAULT 'eur'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

--
-- Class BusinessSettings as table business_settings
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
-- Class Customer as table customer
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
-- Class Document as table document
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
-- Class GuidanceTipOverride as table guidance_tip_override
--
CREATE TABLE "guidance_tip_override" (
    "id" bigserial PRIMARY KEY,
    "topic" text NOT NULL,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "guidance_tip_override_topic_unique_idx" ON "guidance_tip_override" USING btree ("topic");

--
-- Class Invitation as table invitation
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
-- Class Invoice as table invoice
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
CREATE INDEX "invoice_business_status_due_idx" ON "invoice" USING btree ("businessId", "status", "dueDate");

--
-- Class InvoiceItem as table invoice_item
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
-- Class InvoiceTemplate as table invoice_template
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
-- Class Membership as table membership
--
CREATE TABLE "membership" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid,
    "businessId" bigint NOT NULL,
    "role" text NOT NULL DEFAULT 'member'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "membership_user_business_unique_idx" ON "membership" USING btree ("userId", "businessId");
CREATE INDEX "membership_business_idx" ON "membership" USING btree ("businessId");

--
-- Class Sequence as table number_sequence
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
-- Class PaymentRecord as table payment_record
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
-- Class Project as table project
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
-- Class Reminder as table reminder
--
CREATE TABLE "reminder" (
    "id" bigserial PRIMARY KEY,
    "invoiceId" bigint NOT NULL,
    "level" bigint NOT NULL,
    "sent" boolean NOT NULL DEFAULT false,
    "sentAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "reminder_invoice_idx" ON "reminder" USING btree ("invoiceId");

--
-- Class Task as table task
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
-- Class TimeEntry as table time_entry
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
CREATE UNIQUE INDEX "time_entry_business_running_idx" ON "time_entry" USING btree ("businessId", "stoppedAt") NULLS NOT DISTINCT;

--
-- Class UserGuidanceProgress as table user_guidance_progress
--
CREATE TABLE "user_guidance_progress" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid,
    "itemKey" text NOT NULL,
    "completedAt" timestamp without time zone,
    "dismissedAt" timestamp without time zone,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "user_guidance_progress_unique_idx" ON "user_guidance_progress" USING btree ("userId", "itemKey");

--
-- Class UserProfile as table user_profile
--
CREATE TABLE "user_profile" (
    "id" bigserial PRIMARY KEY,
    "userId" uuid NOT NULL,
    "displayName" text,
    "locale" text NOT NULL DEFAULT 'de'::text,
    "timeZone" text,
    "themeMode" text NOT NULL DEFAULT 'system'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deletedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "user_profile_user_unique_idx" ON "user_profile" USING btree ("userId");

--
-- Class WaitlistEntry as table commercial_waitlist_entry
--
CREATE TABLE "commercial_waitlist_entry" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "locale" text NOT NULL DEFAULT 'de'::text,
    "source" text NOT NULL DEFAULT 'website'::text,
    "referrer" text,
    "utmSource" text,
    "utmMedium" text,
    "utmCampaign" text,
    "businessType" text,
    "status" text NOT NULL DEFAULT 'pending'::text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "invitedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "commercial_waitlist_entry__email__unique_idx" ON "commercial_waitlist_entry" USING btree ("email");

--
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL,
    "contentType" text,
    "cacheControl" text,
    "contentDisposition" text,
    "contentEncoding" text,
    "customMetadata" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectDownloadEntry as table serverpod_cloud_storage_direct_download
--
CREATE TABLE "serverpod_cloud_storage_direct_download" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL,
    "downloadFileName" text,
    "contentType" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_download_auth_key" ON "serverpod_cloud_storage_direct_download" USING btree ("authKey");
CREATE INDEX "serverpod_cloud_storage_direct_download_expiration" ON "serverpod_cloud_storage_direct_download" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL,
    "maxFileSize" bigint NOT NULL DEFAULT 10485760,
    "contentLength" bigint,
    "preventOverwrite" boolean NOT NULL DEFAULT false,
    "contentType" text,
    "cacheControl" text,
    "contentDisposition" text,
    "contentEncoding" text,
    "customMetadata" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text,
    "scheduling" json
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class FutureCallClaimEntry as table serverpod_future_call_claim
--
CREATE TABLE "serverpod_future_call_claim" (
    "id" bigserial PRIMARY KEY,
    "futureCallId" bigint,
    "lastHeartbeatTime" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "future_call_unique_idx" ON "serverpod_future_call_claim" USING btree ("futureCallId");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId", "order");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_message_log_sessionLogId_idx" ON "serverpod_message_log" USING btree ("sessionLogId", "order");

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId", "order");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "userId" text,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_time_idx" ON "serverpod_session_log" USING btree ("time");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class RefreshToken as table serverpod_auth_core_jwt_refresh_token
--
CREATE TABLE "serverpod_auth_core_jwt_refresh_token" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "extraClaims" text,
    "method" text NOT NULL,
    "fixedSecret" bytea NOT NULL,
    "rotatingSecretHash" text NOT NULL,
    "lastUpdatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "serverpod_auth_core_jwt_refresh_token_last_updated_at" ON "serverpod_auth_core_jwt_refresh_token" USING btree ("lastUpdatedAt");

--
-- Class UserProfile as table serverpod_auth_core_profile
--
CREATE TABLE "serverpod_auth_core_profile" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "imageId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_profile_user_profile_email_auth_user_id" ON "serverpod_auth_core_profile" USING btree ("authUserId");

--
-- Class UserProfileImage as table serverpod_auth_core_profile_image
--
CREATE TABLE "serverpod_auth_core_profile_image" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userProfileId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "url" text NOT NULL
);

--
-- Class ServerSideSession as table serverpod_auth_core_session
--
CREATE TABLE "serverpod_auth_core_session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUsedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone,
    "expireAfterUnusedFor" bigint,
    "sessionKeyHash" bytea NOT NULL,
    "sessionKeySalt" bytea NOT NULL,
    "method" text NOT NULL
);

--
-- Class AuthUser as table serverpod_auth_core_user
--
CREATE TABLE "serverpod_auth_core_user" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

--
-- Class AnonymousAccount as table serverpod_auth_idp_anonymous_account
--
CREATE TABLE "serverpod_auth_idp_anonymous_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- Class AppleAccount as table serverpod_auth_idp_apple_account
--
CREATE TABLE "serverpod_auth_idp_apple_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userIdentifier" text NOT NULL,
    "refreshToken" text NOT NULL,
    "refreshTokenRequestedWithBundleIdentifier" boolean NOT NULL,
    "lastRefreshedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text,
    "isEmailVerified" boolean,
    "isPrivateEmail" boolean,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_apple_account_identifier" ON "serverpod_auth_idp_apple_account" USING btree ("userIdentifier");

--
-- Class EmailAccount as table serverpod_auth_idp_email_account
--
CREATE TABLE "serverpod_auth_idp_email_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_email" ON "serverpod_auth_idp_email_account" USING btree ("email");

--
-- Class EmailAccountPasswordResetRequest as table serverpod_auth_idp_email_account_password_reset_request
--
CREATE TABLE "serverpod_auth_idp_email_account_password_reset_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "emailAccountId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "challengeId" uuid NOT NULL,
    "setPasswordChallengeId" uuid
);

--
-- Class EmailAccountRequest as table serverpod_auth_idp_email_account_request
--
CREATE TABLE "serverpod_auth_idp_email_account_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" text NOT NULL,
    "challengeId" uuid NOT NULL,
    "createAccountChallengeId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_request_email" ON "serverpod_auth_idp_email_account_request" USING btree ("email");

--
-- Class FacebookAccount as table serverpod_auth_idp_facebook_account
--
CREATE TABLE "serverpod_auth_idp_facebook_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "fullName" text,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_facebook_account_user_identifier" ON "serverpod_auth_idp_facebook_account" USING btree ("userIdentifier");

--
-- Class FirebaseAccount as table serverpod_auth_idp_firebase_account
--
CREATE TABLE "serverpod_auth_idp_firebase_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text,
    "phone" text,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_firebase_account_user_identifier" ON "serverpod_auth_idp_firebase_account" USING btree ("userIdentifier");

--
-- Class GitHubAccount as table serverpod_auth_idp_github_account
--
CREATE TABLE "serverpod_auth_idp_github_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_github_account_user_identifier" ON "serverpod_auth_idp_github_account" USING btree ("userIdentifier");

--
-- Class GoogleAccount as table serverpod_auth_idp_google_account
--
CREATE TABLE "serverpod_auth_idp_google_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_google_account_user_identifier" ON "serverpod_auth_idp_google_account" USING btree ("userIdentifier");

--
-- Class MicrosoftAccount as table serverpod_auth_idp_microsoft_account
--
CREATE TABLE "serverpod_auth_idp_microsoft_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_microsoft_account_user_identifier" ON "serverpod_auth_idp_microsoft_account" USING btree ("userIdentifier");

--
-- Class PasskeyAccount as table serverpod_auth_idp_passkey_account
--
CREATE TABLE "serverpod_auth_idp_passkey_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "keyId" bytea NOT NULL,
    "keyIdBase64" text NOT NULL,
    "clientDataJSON" bytea NOT NULL,
    "attestationObject" bytea NOT NULL,
    "originalChallenge" bytea NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_passkey_account_key_id_base64" ON "serverpod_auth_idp_passkey_account" USING btree ("keyIdBase64");

--
-- Class PasskeyChallenge as table serverpod_auth_idp_passkey_challenge
--
CREATE TABLE "serverpod_auth_idp_passkey_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "challenge" bytea NOT NULL
);

--
-- Class RateLimitedRequestAttempt as table serverpod_auth_idp_rate_limited_request_attempt
--
CREATE TABLE "serverpod_auth_idp_rate_limited_request_attempt" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "domain" text NOT NULL,
    "source" text NOT NULL,
    "nonce" text NOT NULL,
    "ipAddress" text,
    "attemptedAt" timestamp without time zone NOT NULL,
    "extraData" json
);

-- Indexes
CREATE INDEX "serverpod_auth_idp_rate_limited_request_attempt_composite" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("domain", "source", "nonce", "attemptedAt");

--
-- Class SecretChallenge as table serverpod_auth_idp_secret_challenge
--
CREATE TABLE "serverpod_auth_idp_secret_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "challengeCodeHash" text NOT NULL
);

--
-- Foreign relations for "accounting_transaction" table
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
-- Foreign relations for "business_settings" table
--
ALTER TABLE ONLY "business_settings"
    ADD CONSTRAINT "business_settings_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "customer" table
--
ALTER TABLE ONLY "customer"
    ADD CONSTRAINT "customer_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "document" table
--
ALTER TABLE ONLY "document"
    ADD CONSTRAINT "document_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "invitation" table
--
ALTER TABLE ONLY "invitation"
    ADD CONSTRAINT "invitation_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "invoice" table
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
-- Foreign relations for "invoice_item" table
--
ALTER TABLE ONLY "invoice_item"
    ADD CONSTRAINT "invoice_item_fk_0"
    FOREIGN KEY("invoiceId")
    REFERENCES "invoice"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "invoice_template" table
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
-- Foreign relations for "membership" table
--
ALTER TABLE ONLY "membership"
    ADD CONSTRAINT "membership_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "number_sequence" table
--
ALTER TABLE ONLY "number_sequence"
    ADD CONSTRAINT "number_sequence_fk_0"
    FOREIGN KEY("businessId")
    REFERENCES "business"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "payment_record" table
--
ALTER TABLE ONLY "payment_record"
    ADD CONSTRAINT "payment_record_fk_0"
    FOREIGN KEY("invoiceId")
    REFERENCES "invoice"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "project" table
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
-- Foreign relations for "reminder" table
--
ALTER TABLE ONLY "reminder"
    ADD CONSTRAINT "reminder_fk_0"
    FOREIGN KEY("invoiceId")
    REFERENCES "invoice"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "task" table
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
-- Foreign relations for "time_entry" table
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
-- Foreign relations for "serverpod_future_call_claim" table
--
ALTER TABLE ONLY "serverpod_future_call_claim"
    ADD CONSTRAINT "serverpod_future_call_claim_fk_0"
    FOREIGN KEY("futureCallId")
    REFERENCES "serverpod_future_call"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_jwt_refresh_token" table
--
ALTER TABLE ONLY "serverpod_auth_core_jwt_refresh_token"
    ADD CONSTRAINT "serverpod_auth_core_jwt_refresh_token_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_1"
    FOREIGN KEY("imageId")
    REFERENCES "serverpod_auth_core_profile_image"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile_image" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile_image"
    ADD CONSTRAINT "serverpod_auth_core_profile_image_fk_0"
    FOREIGN KEY("userProfileId")
    REFERENCES "serverpod_auth_core_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_session" table
--
ALTER TABLE ONLY "serverpod_auth_core_session"
    ADD CONSTRAINT "serverpod_auth_core_session_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_anonymous_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_anonymous_account"
    ADD CONSTRAINT "serverpod_auth_idp_anonymous_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_apple_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_apple_account"
    ADD CONSTRAINT "serverpod_auth_idp_apple_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_password_reset_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_0"
    FOREIGN KEY("emailAccountId")
    REFERENCES "serverpod_auth_idp_email_account"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_1"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_2"
    FOREIGN KEY("setPasswordChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_0"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_1"
    FOREIGN KEY("createAccountChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_facebook_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_facebook_account"
    ADD CONSTRAINT "serverpod_auth_idp_facebook_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_firebase_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_firebase_account"
    ADD CONSTRAINT "serverpod_auth_idp_firebase_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_github_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_github_account"
    ADD CONSTRAINT "serverpod_auth_idp_github_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_google_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_google_account"
    ADD CONSTRAINT "serverpod_auth_idp_google_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_microsoft_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_microsoft_account"
    ADD CONSTRAINT "serverpod_auth_idp_microsoft_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_passkey_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_passkey_account"
    ADD CONSTRAINT "serverpod_auth_idp_passkey_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
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
