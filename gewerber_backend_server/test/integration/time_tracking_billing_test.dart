@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const userAId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const userBId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given time entries invoicing', (sessionBuilder, endpoints) {
    late TestSessionBuilder authenticatedSession;
    late int businessId;
    late Project project;
    late Task task;

    setUp(() async {
      authenticatedSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userAId,
          {},
        ),
      );
      final business = await endpoints.business.create(
        authenticatedSession,
        CreateBusinessRequest(name: 'Mein Gewerbe'),
      );
      businessId = business.id!;

      final customer = await endpoints.customer.create(
        authenticatedSession,
        CreateCustomerRequest(name: 'ACME GmbH'),
        businessId: businessId,
      );
      project = await endpoints.project.create(
        authenticatedSession,
        CreateProjectRequest(
          name: 'Webseite',
          hourlyRateCents: 10000,
          customerId: customer.id,
        ),
        businessId: businessId,
      );
      task = await endpoints.task.create(
        authenticatedSession,
        CreateTaskRequest(
          projectId: project.id!,
          name: 'Design',
          hourlyRateCents: 12000,
        ),
        businessId: businessId,
      );
    });

    test('when invoicing entries then a draft invoice is created', () async {
      await endpoints.timeEntry.create(
        authenticatedSession,
        CreateTimeEntryRequest(
          projectId: project.id,
          taskId: task.id,
          startedAt: DateTime(2026, 8, 3, 9),
          durationMinutes: 90,
        ),
        businessId: businessId,
      );
      await endpoints.timeEntry.create(
        authenticatedSession,
        CreateTimeEntryRequest(
          projectId: project.id,
          startedAt: DateTime(2026, 8, 4, 9),
          durationMinutes: 30,
        ),
        businessId: businessId,
      );

      final invoice = await endpoints.timeEntry.createInvoice(
        authenticatedSession,
        CreateTimeEntriesInvoiceRequest(projectId: project.id!),
        businessId: businessId,
      );

      expect(invoice.status, InvoiceStatus.draft);
      expect(invoice.customerId, isNotNull);

      final items = await endpoints.invoice.getItems(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(items.length, 2);

      final designItem = items.firstWhere(
        (i) => i.description.contains('Design'),
      );
      // 90 min at 120,00 EUR/h -> 1.5 h * 12000 cents = 18000
      expect(designItem.quantity, 1.5);
      expect(designItem.unitPriceCents, 12000);
      expect(designItem.lineTotalCents, 18000);

      final projectItem = items.firstWhere(
        (i) => !i.description.contains('Design'),
      );
      // 30 min at project rate 100,00 EUR/h -> 0.5 h * 10000 = 5000
      expect(projectItem.quantity, 0.5);
      expect(projectItem.unitPriceCents, 10000);
      expect(projectItem.lineTotalCents, 5000);

      // Entries are marked invoiced: a second call has nothing to bill.
      await expectLater(
        () => endpoints.timeEntry.createInvoice(
          authenticatedSession,
          CreateTimeEntriesInvoiceRequest(projectId: project.id!),
          businessId: businessId,
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('when no rate is configured then ValidationException', () async {
      final noRateProject = await endpoints.project.create(
        authenticatedSession,
        CreateProjectRequest(name: 'Ohne Satz'),
        businessId: businessId,
      );
      await endpoints.timeEntry.create(
        authenticatedSession,
        CreateTimeEntryRequest(
          projectId: noRateProject.id,
          startedAt: DateTime(2026, 8, 3),
          durationMinutes: 60,
        ),
        businessId: businessId,
      );

      await expectLater(
        () => endpoints.timeEntry.createInvoice(
          authenticatedSession,
          CreateTimeEntriesInvoiceRequest(projectId: noRateProject.id!),
          businessId: businessId,
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('when invoiced then entries cannot be deleted', () async {
      final entry = await endpoints.timeEntry.create(
        authenticatedSession,
        CreateTimeEntryRequest(
          projectId: project.id,
          startedAt: DateTime(2026, 8, 3),
          durationMinutes: 60,
        ),
        businessId: businessId,
      );

      await endpoints.timeEntry.createInvoice(
        authenticatedSession,
        CreateTimeEntriesInvoiceRequest(projectId: project.id!),
        businessId: businessId,
      );

      await expectLater(
        () => endpoints.timeEntry.delete(
          authenticatedSession,
          entry.id!,
          businessId: businessId,
        ),
        throwsA(isA<ConflictException>()),
      );
    });

    test(
      'when invoicing multiple entries then all are marked in one batch',
      () async {
        final entryIds = <int>[];
        for (var i = 0; i < 3; i++) {
          final entry = await endpoints.timeEntry.create(
            authenticatedSession,
            CreateTimeEntryRequest(
              projectId: project.id,
              taskId: task.id,
              startedAt: DateTime(2026, 8, 3 + i, 9),
              durationMinutes: 60,
            ),
            businessId: businessId,
          );
          entryIds.add(entry.id!);
        }

        await endpoints.timeEntry.createInvoice(
          authenticatedSession,
          CreateTimeEntriesInvoiceRequest(projectId: project.id!),
          businessId: businessId,
        );

        // Every entry was updated by the single batched statement.
        final entries = await TimeEntry.db.find(
          authenticatedSession.build(),
          where: (t) => t.id.inSet(entryIds.toSet()),
        );
        expect(entries.map((e) => e.id), unorderedEquals(entryIds));
        expect(entries.map((e) => e.invoicedAt), everyElement(isNotNull));
        // One shared timestamp proves a single UPDATE wrote them all.
        expect(entries.map((e) => e.invoicedAt!.toUtc()).toSet().length, 1);
      },
    );

    test('when B accesses projects of A then isolation applies', () async {
      final sessionB = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userBId,
          {},
        ),
      );
      final businessB = await endpoints.business.create(
        sessionB,
        CreateBusinessRequest(name: 'Gewerbe B'),
      );

      await expectLater(
        () => endpoints.project.get(
          sessionB,
          project.id!,
          businessId: businessB.id,
        ),
        throwsA(isA<NotFoundException>()),
      );

      final list = await endpoints.project.list(
        sessionB,
        businessId: businessB.id,
      );
      expect(list, isEmpty);
    });
  });

  withServerpod(
    'Given per-entry time entries invoicing',
    (sessionBuilder, endpoints) {
      late TestSessionBuilder authenticatedSession;
      late TestSessionBuilder otherSession;
      late int businessId;
      late Project project;
      late Task task;

      setUp(() async {
        authenticatedSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            userAId,
            {},
          ),
        );
        otherSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            userBId,
            {},
          ),
        );
        final business = await endpoints.business.create(
          authenticatedSession,
          CreateBusinessRequest(name: 'Mein Gewerbe'),
        );
        businessId = business.id!;

        final customer = await endpoints.customer.create(
          authenticatedSession,
          CreateCustomerRequest(name: 'ACME GmbH'),
          businessId: businessId,
        );
        project = await endpoints.project.create(
          authenticatedSession,
          CreateProjectRequest(
            name: 'Webseite',
            hourlyRateCents: 10000,
            customerId: customer.id,
          ),
          businessId: businessId,
        );
        task = await endpoints.task.create(
          authenticatedSession,
          CreateTaskRequest(
            projectId: project.id!,
            name: 'Design',
            hourlyRateCents: 12000,
          ),
          businessId: businessId,
        );
      });

      Future<TimeEntry> seedEntry({
        required DateTime startedAt,
        bool billable = true,
        int? taskId,
      }) {
        return endpoints.timeEntry.create(
          authenticatedSession,
          CreateTimeEntryRequest(
            projectId: project.id,
            taskId: taskId,
            startedAt: startedAt,
            durationMinutes: 60,
            billable: billable,
          ),
          businessId: businessId,
        );
      }

      test(
        'when billing selected entries then only those end up on the '
        'invoice',
        () async {
          final first = await seedEntry(
            startedAt: DateTime(2026, 8, 3, 9),
            taskId: task.id,
          );
          final second = await seedEntry(
            startedAt: DateTime(2026, 8, 4, 9),
          );
          final third = await seedEntry(
            startedAt: DateTime(2026, 8, 5, 9),
          );

          final invoice = await endpoints.timeEntry.createInvoice(
            authenticatedSession,
            CreateTimeEntriesInvoiceRequest(
              projectId: project.id!,
              timeEntryIds: [first.id!, third.id!],
            ),
            businessId: businessId,
          );

          // Two items: the selected entries are grouped by task — `first`
          // carries the Design task, `third` falls back to the project
          // rate. The unselected `second` is not billed at all.
          final items = await endpoints.invoice.getItems(
            authenticatedSession,
            invoice.id!,
            businessId: businessId,
          );
          expect(items, hasLength(2));

          final designItem = items.singleWhere(
            (i) => i.description.contains('Design'),
          );
          // 60 min at 120,00 EUR/h -> 1 h * 12000 cents.
          expect(designItem.quantity, 1);
          expect(designItem.lineTotalCents, 12000);

          final projectItem = items.singleWhere(
            (i) => !i.description.contains('Design'),
          );
          // 60 min at project rate 100,00 EUR/h.
          expect(projectItem.quantity, 1);
          expect(projectItem.lineTotalCents, 10000);

          final seededIds = <int>{first.id!, second.id!, third.id!};
          final stored = await TimeEntry.db.find(
            authenticatedSession.build(),
            where: (t) => t.id.inSet(seededIds),
          );
          final byId = {for (final e in stored) e.id: e};
          expect(byId[first.id!]!.invoicedAt, isNotNull);
          expect(byId[third.id!]!.invoicedAt, isNotNull);
          // The unselected entry stays billable.
          expect(byId[second.id!]!.invoicedAt, isNull);
        },
      );

      test(
        'when mixing per-entry and period mode then both work independently',
        () async {
          final first = await seedEntry(
            startedAt: DateTime(2026, 8, 3, 9),
          );
          await seedEntry(startedAt: DateTime(2026, 8, 4, 9));

          // Per-entry call bills exactly one entry ...
          await endpoints.timeEntry.createInvoice(
            authenticatedSession,
            CreateTimeEntriesInvoiceRequest(
              projectId: project.id!,
              timeEntryIds: [first.id!],
            ),
            businessId: businessId,
          );

          // ... while the legacy period call still bills the remainder.
          final invoice = await endpoints.timeEntry.createInvoice(
            authenticatedSession,
            CreateTimeEntriesInvoiceRequest(projectId: project.id!),
            businessId: businessId,
          );
          final items = await endpoints.invoice.getItems(
            authenticatedSession,
            invoice.id!,
            businessId: businessId,
          );
          expect(items, hasLength(1));
          expect(items.single.quantity, 1); // 60 min -> 1 h
        },
      );

      test(
        'when another tenant\'s entry is selected then it is rejected',
        () async {
          final foreignEntry = await seedEntry(
            startedAt: DateTime(2026, 8, 3, 9),
          );

          final businessB = await endpoints.business.create(
            otherSession,
            CreateBusinessRequest(name: 'Gewerbe B'),
          );
          final customerB = await endpoints.customer.create(
            otherSession,
            CreateCustomerRequest(name: 'Kunde B'),
            businessId: businessB.id!,
          );
          final projectB = await endpoints.project.create(
            otherSession,
            CreateProjectRequest(
              name: 'Projekt B',
              hourlyRateCents: 10000,
              customerId: customerB.id,
            ),
            businessId: businessB.id,
          );

          await expectLater(
            () => endpoints.timeEntry.createInvoice(
              otherSession,
              CreateTimeEntriesInvoiceRequest(
                projectId: projectB.id!,
                timeEntryIds: [foreignEntry.id!, 999999],
              ),
              businessId: businessB.id,
            ),
            throwsA(
              isA<ValidationException>()
                  .having((e) => e.field, 'field', 'timeEntryIds')
                  .having(
                    (e) => e.message,
                    'message',
                    allOf(
                      contains('${foreignEntry.id}'),
                      contains('another business'),
                      contains('999999'),
                    ),
                  ),
            ),
          );
        },
      );

      test(
        'when an already invoiced entry is selected again then it is '
        'rejected',
        () async {
          final entry = await seedEntry(
            startedAt: DateTime(2026, 8, 3, 9),
          );
          await endpoints.timeEntry.createInvoice(
            authenticatedSession,
            CreateTimeEntriesInvoiceRequest(
              projectId: project.id!,
              timeEntryIds: [entry.id!],
            ),
            businessId: businessId,
          );

          await expectLater(
            () => endpoints.timeEntry.createInvoice(
              authenticatedSession,
              CreateTimeEntriesInvoiceRequest(
                projectId: project.id!,
                timeEntryIds: [entry.id!],
              ),
              businessId: businessId,
            ),
            throwsA(
              isA<ValidationException>()
                  .having((e) => e.field, 'field', 'timeEntryIds')
                  .having(
                    (e) => e.message,
                    'message',
                    contains('already invoiced'),
                  ),
            ),
          );
        },
      );
    },
  );
}
