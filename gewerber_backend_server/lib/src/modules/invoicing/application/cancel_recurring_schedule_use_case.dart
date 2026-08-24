import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';

/// Cancels a recurring schedule by clearing all recurrence fields of its
/// source invoice. Already materialized invoices are kept (GoBD).
@singleton
class CancelRecurringScheduleUseCase {
  CancelRecurringScheduleUseCase(
    this._tenantResolver,
    this._invoices,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final AuditService _audit;

  Future<Invoice> call(
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
        entityType: 'RecurringSchedule',
        entityId: '$invoiceId',
      );
    }
    if (invoice.recurrenceInterval == null) {
      throw NotFoundException(
        entityType: 'RecurringSchedule',
        entityId: '$invoiceId',
      );
    }

    final updated = await _invoices.update(
      session,
      invoice.copyWith(
        recurrenceInterval: null,
        nextRecurrenceDate: null,
        recurrenceEndDate: null,
        recurrenceMaxOccurrences: null,
        recurrenceOccurrencesCreated: 0,
      ),
    );

    await _audit.log(
      session,
      action: 'recurringSchedule.cancel',
      entityType: 'RecurringSchedule',
      entityId: '${updated.id}',
      changes: {'number': updated.number},
      tenant: tenant,
    );
    return updated;
  }
}
