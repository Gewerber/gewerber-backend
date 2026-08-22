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

  withServerpod(
    'Given time entries invoicing',
    (sessionBuilder, endpoints) {
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
    },
  );
}
