import 'package:test/test.dart';

import '../../tool/commercial_migration_overlay.dart';

void main() {
  group('makeIdempotent', () {
    test('rewrites CREATE TABLE, index and ADD COLUMN', () {
      const sql = '''
BEGIN;

CREATE TABLE "commercial_plan" (
    "id" bigserial PRIMARY KEY
);

CREATE UNIQUE INDEX "commercial_plan__code__unique_idx" ON "commercial_plan" USING btree ("code");

ALTER TABLE "commercial_plan" ADD COLUMN "note" text;

COMMIT;
''';

      final result = makeIdempotent(
        sql,
        requiredTablePrefix: 'commercial_',
      );

      expect(result, contains('CREATE TABLE IF NOT EXISTS "commercial_plan"'));
      expect(
        result,
        contains(
          'CREATE UNIQUE INDEX IF NOT EXISTS '
          '"commercial_plan__code__unique_idx" ON "commercial_plan"',
        ),
      );
      expect(
        result,
        contains(
          'ALTER TABLE "commercial_plan" ADD COLUMN IF NOT EXISTS "note"',
        ),
      );
    });

    test('guards a multi-line ADD CONSTRAINT with a DROP CONSTRAINT', () {
      const sql = '''
BEGIN;

ALTER TABLE ONLY "commercial_subscription"
    ADD CONSTRAINT "commercial_subscription_fk_0"
    FOREIGN KEY("planId")
    REFERENCES "commercial_plan"("id");

COMMIT;
''';

      final result = makeIdempotent(
        sql,
        requiredTablePrefix: 'commercial_',
      );

      expect(
        result,
        contains(
          'ALTER TABLE ONLY "commercial_subscription" DROP CONSTRAINT IF EXISTS '
          '"commercial_subscription_fk_0";',
        ),
      );
      expect(result, contains('ADD CONSTRAINT "commercial_subscription_fk_0"'));
    });

    test('leaves version bookkeeping and function bodies alone', () {
      const sql = '''
BEGIN;

create or replace function gen_random_uuid_v7()
returns uuid
as \$\$
begin
  return gen_random_uuid();
end
\$\$
language plpgsql
volatile;

INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('gewerber_backend', '20260101000000000', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260101000000000';

COMMIT;
''';

      final result = makeIdempotent(
        sql,
        requiredTablePrefix: 'commercial_',
      );

      expect(result, sql);
    });

    test('rejects a table outside the module namespace', () {
      const sql = 'CREATE TABLE "invoice" ("id" bigserial PRIMARY KEY);';

      expect(
        () => makeIdempotent(sql, requiredTablePrefix: 'commercial_'),
        throwsA(
          isA<OverlaySqlException>().having(
            (error) => error.message,
            'message',
            contains('outside the "commercial_" module namespace'),
          ),
        ),
      );
    });

    test('rejects unsupported statements instead of guessing', () {
      const sql = 'ALTER TABLE "commercial_plan" RENAME TO "commercial_tier";';

      expect(
        () => makeIdempotent(sql, requiredTablePrefix: 'commercial_'),
        throwsA(isA<OverlaySqlException>()),
      );
    });

    test('rejects an unsupported multi-line ALTER TABLE form', () {
      const sql = '''
ALTER TABLE ONLY "commercial_plan"
    ALTER COLUMN "priceMonthlyMinor" TYPE numeric;
''';

      expect(
        () => makeIdempotent(sql, requiredTablePrefix: 'commercial_'),
        throwsA(isA<OverlaySqlException>()),
      );
    });

    test('keeps DROP CONSTRAINT and DROP TABLE idempotent', () {
      const sql = '''
BEGIN;

DROP TABLE "commercial_plan";
DROP INDEX "commercial_plan__code__unique_idx";

COMMIT;
''';

      final result = makeIdempotent(
        sql,
        requiredTablePrefix: 'commercial_',
      );

      expect(result, contains('DROP TABLE IF EXISTS "commercial_plan"'));
      expect(
        result,
        contains('DROP INDEX IF EXISTS "commercial_plan__code__unique_idx"'),
      );
    });
  });
}
