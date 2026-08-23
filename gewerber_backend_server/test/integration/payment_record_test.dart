@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';

  setUpAll(() async {
    await configureDependencies();
  });

  // Invoice fixture: 100.00 € net at 19 % VAT -> 11900 cents total.
  //
  // Uses `RollbackDatabase.disabled`: the race test intentionally issues two
  // *concurrent* payments, which the harness only allows without transactional
  // rollback. Every test creates its own business and invoice in [setUp], so
  // no state leaks between tests or into other suites.
  withServerpod(
    'Given payment recording with overpayment protection',
    (sessionBuilder, endpoints) {
      late TestSessionBuilder authenticatedSession;
      late int businessId;
      late Invoice invoice;

      setUp(() async {
        authenticatedSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            testUserId,
            {},
          ),
        );
        final business = await endpoints.business.create(
          authenticatedSession,
          CreateBusinessRequest(name: 'Mein Gewerbe'),
        );
        businessId = business.id!;

        invoice = await endpoints.invoice.create(
          authenticatedSession,
          CreateInvoiceRequest(
            items: [
              InvoiceItemRequest(
                description: 'Arbeit',
                quantity: 1,
                unitPriceCents: 10000,
                vatRate: VatRate.standard,
              ),
            ],
          ),
          businessId: businessId,
        );
        expect(invoice.totalCents, 11900);
      });

      Future<Object> attemptRecord(int amountCents) async {
        try {
          return await endpoints.payment.record(
            authenticatedSession,
            RecordPaymentRequest(
              invoiceId: invoice.id!,
              amountCents: amountCents,
            ),
            businessId: businessId,
          );
        } on ValidationException catch (e) {
          return e;
        }
      }

      test(
        'when paying partially then exactly the remainder then paid',
        () async {
          await endpoints.payment.record(
            authenticatedSession,
            RecordPaymentRequest(invoiceId: invoice.id!, amountCents: 1900),
            businessId: businessId,
          );

          var status = await endpoints.payment.status(
            authenticatedSession,
            invoice.id!,
            businessId: businessId,
          );
          expect(status.isPaid, false);
          expect(status.paidTotalCents, 1900);

          await endpoints.payment.record(
            authenticatedSession,
            RecordPaymentRequest(invoiceId: invoice.id!, amountCents: 10000),
            businessId: businessId,
          );

          status = await endpoints.payment.status(
            authenticatedSession,
            invoice.id!,
            businessId: businessId,
          );
          expect(status.isPaid, true);
          expect(status.paidTotalCents, 11900);
          expect(status.remainingCents, 0);
        },
      );

      test(
        'when a payment exceeds the remaining amount then ValidationException',
        () async {
          await endpoints.payment.record(
            authenticatedSession,
            RecordPaymentRequest(invoiceId: invoice.id!, amountCents: 5000),
            businessId: businessId,
          );

          // Remaining is 6900 — recording 7000 must be rejected.
          final result = await attemptRecord(7000);
          expect(result, isA<ValidationException>());

          // The rejected payment must not be persisted.
          final status = await endpoints.payment.status(
            authenticatedSession,
            invoice.id!,
            businessId: businessId,
          );
          expect(status.paidTotalCents, 5000);
          expect(status.payments, hasLength(1));
          expect(status.isPaid, false);
        },
      );

      test(
        'when two payments race then only the fitting one is recorded',
        () async {
          // Each 6000-cent payment alone fits into the 11900 total, but both
          // together overpay it. The FOR UPDATE lock inside the use case
          // serializes them, so the second one must observe the first one's
          // record and be rejected instead of double-counting.
          final results = await Future.wait([
            attemptRecord(6000),
            attemptRecord(6000),
          ]);

          final records = results.whereType<PaymentRecord>().toList();
          final rejections = results.whereType<ValidationException>().toList();
          expect(records, hasLength(1));
          expect(rejections, hasLength(1));

          final status = await endpoints.payment.status(
            authenticatedSession,
            invoice.id!,
            businessId: businessId,
          );
          expect(status.paidTotalCents, 6000);
          expect(status.payments, hasLength(1));
          expect(status.isPaid, false);
        },
      );
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}
