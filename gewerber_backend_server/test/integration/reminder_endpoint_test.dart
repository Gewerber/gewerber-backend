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

  withServerpod('Given ReminderEndpoint', (sessionBuilder, endpoints) {
    late TestSessionBuilder authenticatedSession;
    late int businessId;
    late Customer customer;

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
      customer = await endpoints.customer.create(
        authenticatedSession,
        CreateCustomerRequest(name: 'ACME GmbH', email: 'billing@acme.de'),
        businessId: businessId,
      );
    });

    Future<Invoice> createSentInvoice({Customer? forCustomer}) async {
      final invoice = await endpoints.invoice.create(
        authenticatedSession,
        CreateInvoiceRequest(
          customerId: (forCustomer ?? customer).id,
          issueDate: DateTime(2026, 8, 1),
          dueDate: DateTime(2026, 8, 15),
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
      return endpoints.invoice.markSent(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
    }

    test('when sending a reminder then it is recorded with level 1', () async {
      final invoice = await createSentInvoice();

      final reminder = await endpoints.reminder.send(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );

      expect(reminder.id, isNotNull);
      expect(reminder.invoiceId, invoice.id);
      expect(reminder.level, 1);

      final fetched = await endpoints.invoice.get(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(fetched.dunningLevel, 1);
    });

    test('when sending repeatedly then levels increment', () async {
      final invoice = await createSentInvoice();

      await endpoints.reminder.send(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      final second = await endpoints.reminder.send(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(second.level, 2);

      final list = await endpoints.reminder.list(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(list.length, 2);
      expect(list.map((r) => r.level).toList(), [1, 2]);

      final fetched = await endpoints.invoice.get(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(fetched.dunningLevel, 2);
    });

    test('when invoice is draft then ConflictException', () async {
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

      await expectLater(
        () => endpoints.reminder.send(
          authenticatedSession,
          invoice.id!,
          businessId: businessId,
        ),
        throwsA(isA<ConflictException>()),
      );
    });

    test('when invoice is paid then ConflictException', () async {
      final invoice = await createSentInvoice();
      await endpoints.payment.record(
        authenticatedSession,
        RecordPaymentRequest(
          invoiceId: invoice.id!,
          amountCents: invoice.totalCents,
        ),
        businessId: businessId,
      );

      await expectLater(
        () => endpoints.reminder.send(
          authenticatedSession,
          invoice.id!,
          businessId: businessId,
        ),
        throwsA(isA<ConflictException>()),
      );
    });

    test('when customer has no email then ValidationException', () async {
      final noEmailCustomer = await endpoints.customer.create(
        authenticatedSession,
        CreateCustomerRequest(name: 'Ohne E-Mail'),
        businessId: businessId,
      );
      final invoice = await createSentInvoice(forCustomer: noEmailCustomer);

      await expectLater(
        () => endpoints.reminder.send(
          authenticatedSession,
          invoice.id!,
          businessId: businessId,
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('when other tenant lists reminders then NotFoundException', () async {
      final invoice = await createSentInvoice();

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

      await expectLater(
        () => endpoints.reminder.list(
          otherSession,
          invoice.id!,
          businessId: otherBusiness.id,
        ),
        throwsA(isA<NotFoundException>()),
      );
    });
  });
}
