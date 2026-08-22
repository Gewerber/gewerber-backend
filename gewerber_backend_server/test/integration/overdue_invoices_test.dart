@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/di/service_locator.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/application/mark_overdue_invoices_use_case.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given overdue invoices', (sessionBuilder, endpoints) {
    late TestSessionBuilder authenticatedSession;
    late int businessId;
    final pastDue = DateTime(2026, 8, 1);
    final futureDue = DateTime(2026, 9, 30);
    final reference = DateTime(2026, 8, 20);

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
    });

    Future<Invoice> createInvoice({
      DateTime? dueDate,
      bool sent = false,
      bool paid = false,
    }) async {
      final invoice = await endpoints.invoice.create(
        authenticatedSession,
        CreateInvoiceRequest(
          issueDate: DateTime(2026, 7, 15),
          dueDate: dueDate,
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

      var current = invoice;
      if (sent || paid) {
        current = await endpoints.invoice.markSent(
          authenticatedSession,
          invoice.id!,
          businessId: businessId,
        );
      }
      if (paid) {
        await endpoints.payment.record(
          authenticatedSession,
          RecordPaymentRequest(
            invoiceId: invoice.id!,
            amountCents: invoice.totalCents,
          ),
          businessId: businessId,
        );
      }
      return current;
    }

    test(
      'when sent invoice is past due then it is marked overdue',
      () async {
        final invoice = await createInvoice(dueDate: pastDue, sent: true);

        final updated = await getIt<MarkOverdueInvoicesUseCase>().call(
          authenticatedSession.build(),
          now: reference,
        );
        expect(updated, 1);

        final fetched = await endpoints.invoice.get(
          authenticatedSession,
          invoice.id!,
          businessId: businessId,
        );
        expect(fetched.status, InvoiceStatus.overdue);
      },
    );

    test('when draft invoice is past due then it stays draft', () async {
      final invoice = await createInvoice(dueDate: pastDue);

      await getIt<MarkOverdueInvoicesUseCase>().call(
        authenticatedSession.build(),
        now: reference,
      );

      final fetched = await endpoints.invoice.get(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(fetched.status, InvoiceStatus.draft);
    });

    test('when due date is in the future then it stays sent', () async {
      final invoice = await createInvoice(dueDate: futureDue, sent: true);

      await getIt<MarkOverdueInvoicesUseCase>().call(
        authenticatedSession.build(),
        now: reference,
      );

      final fetched = await endpoints.invoice.get(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(fetched.status, InvoiceStatus.sent);
    });

    test('when paid invoice is past due then it stays paid', () async {
      final invoice = await createInvoice(dueDate: pastDue, paid: true);

      await getIt<MarkOverdueInvoicesUseCase>().call(
        authenticatedSession.build(),
        now: reference,
      );

      final fetched = await endpoints.invoice.get(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(fetched.status, InvoiceStatus.paid);
    });

    test('when sent invoice has no due date then it stays sent', () async {
      final invoice = await createInvoice(sent: true);

      await getIt<MarkOverdueInvoicesUseCase>().call(
        authenticatedSession.build(),
        now: reference,
      );

      final fetched = await endpoints.invoice.get(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(fetched.status, InvoiceStatus.sent);
    });

    test(
      'when partially paid invoice is past due then it becomes overdue',
      () async {
        final invoice = await createInvoice(dueDate: pastDue, sent: true);
        await endpoints.payment.record(
          authenticatedSession,
          RecordPaymentRequest(invoiceId: invoice.id!, amountCents: 1000),
          businessId: businessId,
        );

        await getIt<MarkOverdueInvoicesUseCase>().call(
          authenticatedSession.build(),
          now: reference,
        );

        final fetched = await endpoints.invoice.get(
          authenticatedSession,
          invoice.id!,
          businessId: businessId,
        );
        expect(fetched.status, InvoiceStatus.overdue);
      },
    );
  });
}
