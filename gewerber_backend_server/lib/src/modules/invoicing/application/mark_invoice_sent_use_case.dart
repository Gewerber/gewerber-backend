import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';

@singleton
class MarkInvoiceSentUseCase {
  MarkInvoiceSentUseCase(this._tenantResolver, this._invoices, this._audit);

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
        entityType: 'Invoice',
        entityId: '$invoiceId',
      );
    }
    if (invoice.status != InvoiceStatus.draft) {
      throw ConflictException(
        message: 'Only draft invoices can be marked as sent.',
      );
    }

    final updated = await _invoices.update(
      session,
      invoice.copyWith(status: InvoiceStatus.sent),
    );
    await _audit.log(
      session,
      action: 'invoice.markSent',
      entityType: 'Invoice',
      entityId: '${updated.id}',
      changes: {'status': InvoiceStatus.sent.name},
      tenant: tenant,
    );
    return updated;
  }
}