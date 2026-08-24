@TestOn('vm')
@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/pagination/list_limits.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Seeds [count] rows of every entity that has a tenant-scoped list endpoint,
/// using direct batch inserts (one statement per table) to keep the test fast.
Future<void> _seed(Session session, int businessId, Project project) async {
  const count = maxListLimit + 10; // 210 > cap

  await Customer.db.insert(session, [
    for (var i = 0; i < count; i++)
      Customer(businessId: businessId, name: 'Kunde $i'),
  ]);

  await Invoice.db.insert(session, [
    for (var i = 0; i < count; i++)
      Invoice(
        businessId: businessId,
        number: 'CAP-${i.toString().padLeft(4, '0')}',
        issueDate: DateTime(2026, 1, 1).add(Duration(days: i)),
      ),
  ]);

  await InvoiceTemplate.db.insert(session, [
    for (var i = 0; i < count; i++)
      InvoiceTemplate(businessId: businessId, name: 'Vorlage $i'),
  ]);

  await Project.db.insert(session, [
    for (var i = 0; i < count; i++)
      Project(businessId: businessId, name: 'Projekt $i'),
  ]);

  await Document.db.insert(session, [
    for (var i = 0; i < count; i++)
      Document(
        businessId: businessId,
        fileName: 'file-$i.pdf',
        storagePath: 'private/cap/file-$i.pdf',
      ),
  ]);

  await AccountingTransaction.db.insert(session, [
    for (var i = 0; i < count; i++)
      AccountingTransaction(
        businessId: businessId,
        type: TransactionType.income,
        category: TransactionCategory.salesRevenue,
        occurredAt: DateTime(2026, 1, 1).add(Duration(days: i)),
        amountCents: i * 100,
      ),
  ]);

  // Tasks and time entries hang off the shared project. The running-timer
  // unique index `(businessId, stoppedAt) NULLS NOT DISTINCT` requires
  // distinct `stoppedAt` values.
  final tasks = await Task.db.insert(session, [
    for (var i = 0; i < count; i++)
      Task(
        businessId: businessId,
        projectId: project.id!,
        name: 'Aufgabe $i',
      ),
  ]);

  await TimeEntry.db.insert(session, [
    for (var i = 0; i < count; i++)
      TimeEntry(
        businessId: businessId,
        projectId: project.id,
        taskId: tasks[i].id,
        startedAt: DateTime(2026, 1, 1, 8).add(Duration(minutes: i)),
        stoppedAt: DateTime(2026, 1, 1, 9).add(Duration(minutes: i)),
        durationMinutes: 60,
      ),
  ]);
}

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given list endpoints with seeded rows', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder authenticatedSession;
    late Session session;
    late int businessId;

    setUp(() async {
      authenticatedSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          testUserId,
          {},
        ),
      );
      session = authenticatedSession.build();
      final business = await endpoints.business.create(
        authenticatedSession,
        CreateBusinessRequest(name: 'Cap Gewerbe'),
      );
      businessId = business.id!;
      final project = await endpoints.project.create(
        authenticatedSession,
        CreateProjectRequest(name: 'Cap Projekt'),
        businessId: businessId,
      );
      await _seed(session, businessId, project);
    });

    test(
      'when asking for more than the cap then at most $maxListLimit rows are returned',
      () async {
        expect(
          (await endpoints.customer.list(
            authenticatedSession,
            limit: 500,
            businessId: businessId,
          )).length,
          maxListLimit,
        );
        expect(
          (await endpoints.invoice.list(
            authenticatedSession,
            limit: 500,
            businessId: businessId,
          )).length,
          maxListLimit,
        );
        expect(
          (await endpoints.invoiceTemplate.list(
            authenticatedSession,
            limit: 500,
            businessId: businessId,
          )).length,
          maxListLimit,
        );
        expect(
          (await endpoints.project.list(
            authenticatedSession,
            limit: 500,
            businessId: businessId,
          )).length,
          maxListLimit,
        );
        expect(
          (await endpoints.task.list(
            authenticatedSession,
            limit: 500,
            businessId: businessId,
          )).length,
          maxListLimit,
        );
        expect(
          (await endpoints.timeEntry.list(
            authenticatedSession,
            limit: 500,
            businessId: businessId,
          )).length,
          maxListLimit,
        );
        expect(
          (await endpoints.document.list(
            authenticatedSession,
            limit: 500,
            businessId: businessId,
          )).length,
          maxListLimit,
        );
        expect(
          (await endpoints.accounting.list(
            authenticatedSession,
            limit: 500,
            businessId: businessId,
          )).length,
          maxListLimit,
        );

        // Sanity: the cap actually truncated a larger result set.
        expect(await Customer.db.count(session), maxListLimit + 10);
      },
    );

    test(
      'when omitting the limit then the default page size is used',
      () async {
        expect(
          (await endpoints.customer.list(
            authenticatedSession,
            businessId: businessId,
          )).length,
          defaultListLimit,
        );
        expect(
          (await endpoints.timeEntry.list(
            authenticatedSession,
            businessId: businessId,
          )).length,
          defaultListLimit,
        );
      },
    );
  });
}
