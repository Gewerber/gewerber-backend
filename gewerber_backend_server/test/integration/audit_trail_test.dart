@TestOn('vm')
@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/di/service_locator.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/application/mark_overdue_invoices_use_case.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/application/process_recurring_invoices_use_case.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Audit-trail hardening:
/// - guidance progress writes (markCompleted/dismissTip) are audited,
/// - recurring materialization is audited per created clone (system event),
/// - the overdue job is audited per affected business with `businessId`,
/// - audit entries of user mutations are written in the same transaction as
///   the change — a rolled-back mutation leaves no entry behind.
void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given audited system and guidance events', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder authenticatedSession;
    late Session rawSession;
    late int businessId;

    setUp(() async {
      authenticatedSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          testUserId,
          {},
        ),
      );
      rawSession = sessionBuilder.build();
      final business = await endpoints.business.create(
        authenticatedSession,
        CreateBusinessRequest(name: 'Audit Gewerbe'),
      );
      businessId = business.id!;
    });

    Future<List<AuditEntry>> entries(String action) => AuditEntry.db.find(
      rawSession,
      where: (t) => t.action.equals(action),
    );

    group('guidance progress writes', () {
      test('when marking completed then an audit entry is written', () async {
        await endpoints.guidance.markCompleted(
          authenticatedSession,
          'onboarding/business-profile',
        );

        final logged = await entries('guidance.markCompleted');
        expect(logged, hasLength(1));
        expect(logged.single.entityType, 'UserGuidanceProgress');
        expect(logged.single.entityId, 'onboarding/business-profile');
        // User-scoped action without tenant context: only the user id is set.
        expect(logged.single.userId, isNotNull);
        expect(logged.single.businessId, isNull);
      });

      test('when dismissing a tip then an audit entry is written', () async {
        await endpoints.guidance.dismissTip(
          authenticatedSession,
          'invoicing.kleinunternehmer',
        );

        final logged = await entries('guidance.dismissTip');
        expect(logged, hasLength(1));
        expect(logged.single.entityId, 'tip:invoicing.kleinunternehmer');
        expect(logged.single.userId, isNotNull);
      });
    });

    group('recurring materialization job', () {
      test(
        'when a clone is created then it is audited for the business',
        () async {
          await endpoints.invoice.create(
            authenticatedSession,
            CreateInvoiceRequest(
              issueDate: DateTime(2026, 7, 1),
              nextRecurrenceDate: DateTime(2026, 8, 1),
              recurrenceInterval: RecurrenceInterval.monthly,
              items: [
                InvoiceItemRequest(
                  description: 'Miete',
                  quantity: 1,
                  unitPriceCents: 50000,
                ),
              ],
            ),
            businessId: businessId,
          );

          final created = await getIt<ProcessRecurringInvoicesUseCase>().call(
            rawSession,
            now: DateTime(2026, 8, 2),
          );
          expect(created, 1);

          final invoices = await endpoints.invoice.list(
            authenticatedSession,
            businessId: businessId,
          );
          final clone = invoices.firstWhere((i) => i.number != '2026-0001');

          final logged = await entries('invoice.recurringMaterialized');
          expect(logged, hasLength(1));
          // System event: attributed to the owning business, no user.
          expect(logged.single.businessId, businessId);
          expect(logged.single.userId, isNull);
          expect(logged.single.entityId, '${clone.id}');
          expect(
            logged.single.changes?['sourceInvoiceId'],
            isNot(clone.id.toString()),
          );
        },
      );
    });

    group('overdue job', () {
      test(
        'when invoices are marked overdue then each affected business is '
        'audited with its id',
        () async {
          final secondBusiness = await endpoints.business.create(
            authenticatedSession,
            CreateBusinessRequest(name: 'Zweitgewerbe Audit'),
          );

          Future<Invoice> seedRawInvoice(
            int targetBusinessId,
            String number,
          ) => Invoice.db.insertRow(
            rawSession,
            Invoice(
              businessId: targetBusinessId,
              number: number,
              status: InvoiceStatus.sent,
              issueDate: DateTime(2026, 7, 15),
              dueDate: DateTime(2026, 8, 1),
            ),
          );

          await seedRawInvoice(businessId, 'AUD-A-001');
          await seedRawInvoice(secondBusiness.id!, 'AUD-B-001');
          // A business without candidates must not be audited.
          await endpoints.customer.create(
            authenticatedSession,
            CreateCustomerRequest(name: 'Kunde ohne Rechnungen'),
            businessId: businessId,
          );

          final total = await getIt<MarkOverdueInvoicesUseCase>().call(
            rawSession,
            now: DateTime(2026, 8, 20),
          );
          expect(total, 2);

          final logged = await entries('invoice.markOverdue');
          expect(logged, hasLength(2));
          expect(
            logged.map((e) => e.businessId).toSet(),
            {businessId, secondBusiness.id},
          );
          expect(logged.every((e) => e.userId == null), isTrue);
          expect(
            logged.every((e) => e.changes?['count'] == '1'),
            isTrue,
          );
        },
      );
    });

    group('transactional audit', () {
      test(
        'when a mutation rolls back then no audit entry is left behind',
        () async {
          final customer = await endpoints.customer.create(
            authenticatedSession,
            CreateCustomerRequest(name: 'Rollback Kunde'),
            businessId: businessId,
          );
          final invoice = await endpoints.invoice.create(
            authenticatedSession,
            CreateInvoiceRequest(
              customerId: customer.id,
              items: [
                InvoiceItemRequest(
                  description: 'A',
                  quantity: 1,
                  unitPriceCents: 10000,
                ),
              ],
            ),
            businessId: businessId,
          );

          // Overpayment is rejected inside the transaction — the audit
          // entry must roll back with it.
          await expectLater(
            () => endpoints.payment.record(
              authenticatedSession,
              RecordPaymentRequest(
                invoiceId: invoice.id!,
                amountCents: invoice.totalCents + 1,
              ),
              businessId: businessId,
            ),
            throwsA(isA<ValidationException>()),
          );

          final logged = await entries('payment.record');
          expect(logged, isEmpty);
        },
      );

      test('when a payment succeeds then its audit entry exists', () async {
        final customer = await endpoints.customer.create(
          authenticatedSession,
          CreateCustomerRequest(name: 'Commit Kunde'),
          businessId: businessId,
        );
        final invoice = await endpoints.invoice.create(
          authenticatedSession,
          CreateInvoiceRequest(
            customerId: customer.id,
            items: [
              InvoiceItemRequest(
                description: 'A',
                quantity: 1,
                unitPriceCents: 10000,
              ),
            ],
          ),
          businessId: businessId,
        );

        await endpoints.payment.record(
          authenticatedSession,
          RecordPaymentRequest(
            invoiceId: invoice.id!,
            amountCents: invoice.totalCents,
          ),
          businessId: businessId,
        );

        final logged = await entries('payment.record');
        expect(logged, hasLength(1));
        expect(logged.single.businessId, businessId);
      });
    });
  });
}
