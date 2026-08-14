import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';

@singleton
class DeleteInvoiceUseCase {
  DeleteInvoiceUseCase(this._tenantResolver, this._invoices, this._audit);

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final AuditService _audit;

  Future<void> call(
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
    if (invoice.status == InvoiceStatus.sent ||
        invoice.status == InvoiceStatus.paid) {
      throw ConflictException(
        message: 'Cannot delete a sent or paid invoice.',
      );
    }

    await _invoices.delete(session, invoice);
    await _audit.log(
      session,
      action: 'invoice.delete',
      entityType: 'Invoice',
      entityId: '$invoiceId',
      tenant: tenant,
    );
  }
}
