import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';

/// Loads a single recurring schedule of the current tenant.
///
/// A schedule exists while the source invoice carries a
/// [Invoice.recurrenceInterval] — including finished schedules whose
/// `nextRecurrenceDate` was cleared after the last materialization.
@singleton
class GetRecurringScheduleUseCase {
  GetRecurringScheduleUseCase(this._tenantResolver, this._invoices);

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;

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
    return invoice;
  }
}
