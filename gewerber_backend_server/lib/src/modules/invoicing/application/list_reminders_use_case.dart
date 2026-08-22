import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';
import '../domain/reminder_gateway.dart';

@singleton
class ListRemindersUseCase {
  ListRemindersUseCase(
    this._tenantResolver,
    this._invoices,
    this._reminders,
  );

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final ReminderGateway _reminders;

  Future<List<Reminder>> call(
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
    return _reminders.findByInvoiceId(session, invoiceId);
  }
}
