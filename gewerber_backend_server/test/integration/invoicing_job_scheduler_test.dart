@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/future_calls.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/jobs/invoicing_job_scheduler.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod(
    'Given the invoicing job scheduler',
    (sessionBuilder, endpoints) {
      Future<int> countScheduledJobs(String identifier) async {
        final session = sessionBuilder.build();
        try {
          final result = await session.db.unsafeQuery(
            'SELECT COUNT(*) FROM serverpod_future_call '
            'WHERE "identifier"=\'$identifier\'',
          );
          return (result.first.first as int);
        } finally {
          await session.close();
        }
      }

      test('when ensured then both jobs are scheduled once', () async {
        expect(
          await countScheduledJobs(
            InvoicingJobScheduler.recurringInvoicesIdentifier,
          ),
          0,
        );
        expect(
          await countScheduledJobs(InvoicingJobScheduler.markOverdueIdentifier),
          0,
        );

        await const InvoicingJobScheduler().ensureScheduled(FutureCalls());

        expect(
          await countScheduledJobs(
            InvoicingJobScheduler.recurringInvoicesIdentifier,
          ),
          1,
        );
        expect(
          await countScheduledJobs(InvoicingJobScheduler.markOverdueIdentifier),
          1,
        );
      });

      test('when ensured repeatedly then no duplicates accumulate', () async {
        const scheduler = InvoicingJobScheduler();
        await scheduler.ensureScheduled(FutureCalls());
        await scheduler.ensureScheduled(FutureCalls());
        await scheduler.ensureScheduled(FutureCalls());

        expect(
          await countScheduledJobs(
            InvoicingJobScheduler.recurringInvoicesIdentifier,
          ),
          1,
        );
        expect(
          await countScheduledJobs(InvoicingJobScheduler.markOverdueIdentifier),
          1,
        );
      });
    },
  );
}
