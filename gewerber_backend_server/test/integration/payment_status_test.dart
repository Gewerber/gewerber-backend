@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const otherUserId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given PaymentEndpoint status', (sessionBuilder, endpoints) {
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
              description: 'A',
              quantity: 1,
              unitPriceCents: 10000,
            ),
          ],
        ),
        businessId: businessId,
      );
    });

    test('when no payments then remaining equals total', () async {
      final status = await endpoints.payment.status(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );

      expect(status.isPaid, false);
      expect(status.paidTotalCents, 0);
      expect(status.remainingCents, invoice.totalCents);
      expect(status.payments, isEmpty);
    });

    test('when partial payment then remaining is total minus paid', () async {
      await endpoints.payment.record(
        authenticatedSession,
        RecordPaymentRequest(
          invoiceId: invoice.id!,
          amountCents: 4000,
          method: PaymentMethod.bankTransfer,
        ),
        businessId: businessId,
      );

      final status = await endpoints.payment.status(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );

      expect(status.paidTotalCents, 4000);
      expect(status.remainingCents, invoice.totalCents - 4000);
      expect(status.isPaid, false);
      expect(status.payments.length, 1);
    });

    test('when full payment then remaining is zero and isPaid', () async {
      await endpoints.payment.record(
        authenticatedSession,
        RecordPaymentRequest(
          invoiceId: invoice.id!,
          amountCents: invoice.totalCents,
          method: PaymentMethod.bankTransfer,
        ),
        businessId: businessId,
      );

      final status = await endpoints.payment.status(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );

      expect(status.paidTotalCents, invoice.totalCents);
      expect(status.remainingCents, 0);
      expect(status.isPaid, true);
    });

    test('when overpayment then ValidationException', () async {
      await expectLater(
        () => endpoints.payment.record(
          authenticatedSession,
          RecordPaymentRequest(
            invoiceId: invoice.id!,
            amountCents: invoice.totalCents + 5000,
            method: PaymentMethod.bankTransfer,
          ),
          businessId: businessId,
        ),
        throwsA(isA<ValidationException>()),
      );

      // The rejected payment must not be persisted and the invoice status
      // must stay untouched.
      final status = await endpoints.payment.status(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(status.paidTotalCents, 0);
      expect(status.payments, isEmpty);
      final fetched = await endpoints.invoice.get(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(fetched.status, InvoiceStatus.draft);
    });

    test('when invoice does not exist then NotFoundException', () async {
      await expectLater(
        () => endpoints.payment.status(
          authenticatedSession,
          999999,
          businessId: businessId,
        ),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('when other tenant requests status then NotFoundException', () async {
      final otherSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          otherUserId,
          {},
        ),
      );
      final otherBusiness = await endpoints.business.create(
        otherSession,
        CreateBusinessRequest(name: 'Anderes Gewerbe'),
      );

      // B is a member of their own business, but the invoice belongs to A.
      await expectLater(
        () => endpoints.payment.status(
          otherSession,
          invoice.id!,
          businessId: otherBusiness.id,
        ),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('when passing a foreign businessId then ForbiddenException', () async {
      final otherSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          otherUserId,
          {},
        ),
      );
      await endpoints.business.create(
        otherSession,
        CreateBusinessRequest(name: 'Anderes Gewerbe'),
      );

      // B is not a member of A's business at all.
      await expectLater(
        () => endpoints.payment.status(
          otherSession,
          invoice.id!,
          businessId: businessId,
        ),
        throwsA(isA<ForbiddenException>()),
      );
    });

    test('when recording negative payment then ValidationException', () async {
      await expectLater(
        () => endpoints.payment.record(
          authenticatedSession,
          RecordPaymentRequest(invoiceId: invoice.id!, amountCents: -100),
          businessId: businessId,
        ),
        throwsA(isA<ValidationException>()),
      );
    });
  });
}
