@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/audit/audit_service.dart';
import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/di/service_locator.dart';
import 'package:gewerber_backend_server/src/core/mail/email_template.dart';
import 'package:gewerber_backend_server/src/core/mail/mail_service.dart';
import 'package:gewerber_backend_server/src/core/tenant/tenant_resolver.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/business/domain/business_gateway.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/application/send_payment_reminder_use_case.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/customer_gateway.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/invoice_gateway.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/reminder_gateway.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// A [MailService] that always reports a failed delivery, regardless of SMTP
/// configuration.
class _FailingMailService implements MailService {
  @override
  Future<MailSendStatus> sendVerificationCode(
    Session session, {
    required String email,
    required String verificationCode,
    required EmailTemplate template,
  }) async {
    return MailSendStatus.failed;
  }

  @override
  Future<MailSendStatus> sendPaymentReminder(
    Session session, {
    required String toEmail,
    required String customerName,
    required String businessName,
    required String invoiceNumber,
    required int level,
    required String formattedAmount,
    required DateTime dueDate,
  }) async {
    return MailSendStatus.failed;
  }
}

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const otherUserId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given ReminderEndpoint', (sessionBuilder, endpoints) {
    late TestSessionBuilder authenticatedSession;
    late Session rawSession;
    late int businessId;
    late Customer customer;

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
      // No SMTP host configured in tests → loggedOnly, which counts as sent.
      expect(reminder.sent, isTrue);

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
      expect(second.sent, isTrue);

      final list = await endpoints.reminder.list(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(list.length, 2);
      expect(list.map((r) => r.level).toList(), [1, 2]);
      expect(list.map((r) => r.sent), everyElement(isTrue));

      final fetched = await endpoints.invoice.get(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(fetched.dunningLevel, 2);
    });

    test(
      'when mail delivery fails then reminder is unsent and dunning level is '
      'not bumped',
      () async {
        final invoice = await createSentInvoice();

        // Override MailService inside a DI scope; the base registrations are
        // untouched, so other tests in this suite are not affected. The use
        // case is a cached singleton that captured the real MailService at
        // first resolution, so it is re-wired inside the scope as well.
        getIt.pushNewScope();
        getIt.registerSingleton<MailService>(_FailingMailService());
        getIt.registerSingleton<SendPaymentReminderUseCase>(
          SendPaymentReminderUseCase(
            getIt<TenantResolver>(),
            getIt<InvoiceGateway>(),
            getIt<CustomerGateway>(),
            getIt<BusinessGateway>(),
            getIt<ReminderGateway>(),
            getIt<MailService>(),
            getIt<AuditService>(),
          ),
        );
        try {
          final reminder = await endpoints.reminder.send(
            authenticatedSession,
            invoice.id!,
            businessId: businessId,
          );

          // The reminder is still recorded, but marked as not sent and the
          // dunning level is not advanced.
          expect(reminder.id, isNotNull);
          expect(reminder.level, 1);
          expect(reminder.sent, isFalse);

          final fetched = await endpoints.invoice.get(
            authenticatedSession,
            invoice.id!,
            businessId: businessId,
          );
          expect(fetched.dunningLevel, 0);

          final auditEntries = await AuditEntry.db.find(
            rawSession,
            where: (t) => t.action.equals('reminder.send'),
          );
          expect(auditEntries, hasLength(1));
          expect(auditEntries.single.changes, {
            'dunningLevel': '1',
            'sent': 'false',
          });
        } finally {
          await getIt.popScope();
        }
      },
    );

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
