import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/mail/mail_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../../business/domain/business_gateway.dart';
import '../domain/customer_gateway.dart';
import '../domain/invoice_gateway.dart';
import '../domain/money_formatter.dart';
import '../domain/reminder_gateway.dart';

/// Sends a payment reminder for a sent/partially paid/overdue invoice.
///
/// The reminder level is derived from the number of reminders already sent
/// for the invoice and is mirrored to `invoice.dunningLevel`. If SMTP is not
/// configured the reminder is still recorded (useful for local development).
@singleton
class SendPaymentReminderUseCase {
  SendPaymentReminderUseCase(
    this._tenantResolver,
    this._invoices,
    this._customers,
    this._businesses,
    this._reminders,
    this._mail,
    this._audit,
  );

  static const _remindableStatuses = {
    InvoiceStatus.sent,
    InvoiceStatus.partiallyPaid,
    InvoiceStatus.overdue,
  };

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final CustomerGateway _customers;
  final BusinessGateway _businesses;
  final ReminderGateway _reminders;
  final MailService _mail;
  final AuditService _audit;

  Future<Reminder> call(
    Session session,
    int invoiceId, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final invoice = await _invoices.findById(session, invoiceId);
    if (invoice == null || invoice.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'Invoice',
        entityId: '$invoiceId',
      );
    }
    if (!_remindableStatuses.contains(invoice.status)) {
      throw ConflictException(
        message:
            'Reminders can only be sent for sent, partially paid or overdue '
            'invoices.',
      );
    }

    final customer = invoice.customerId == null
        ? null
        : await _customers.findById(session, invoice.customerId!);
    final email = customer?.email?.trim();
    if (email == null || email.isEmpty) {
      throw ValidationException(
        message: 'The customer has no email address.',
        field: 'customerId',
      );
    }

    final existing = await _reminders.findByInvoiceId(session, invoiceId);
    final level = existing.length + 1;

    final business = await _businesses.findById(session, tenant.businessId);
    if (business == null) {
      throw NotFoundException(
        entityType: 'Business',
        entityId: '${tenant.businessId}',
      );
    }

    final reminder = await _reminders.create(
      session,
      Reminder(invoiceId: invoiceId, level: level),
    );

    await _invoices.update(
      session,
      invoice.copyWith(dunningLevel: level),
    );

    await _mail.sendPaymentReminder(
      session,
      toEmail: email,
      customerName: customer!.companyName ?? customer.name,
      businessName: business.name,
      invoiceNumber: invoice.number,
      level: level,
      formattedAmount: MoneyFormatter.formatCents(
        invoice.totalCents,
        invoice.currency,
      ),
      dueDate: invoice.dueDate ?? invoice.issueDate,
    );

    await _audit.log(
      session,
      action: 'reminder.send',
      entityType: 'Invoice',
      entityId: '$invoiceId',
      changes: {'dunningLevel': '$level'},
      tenant: tenant,
    );
    return reminder;
  }
}
