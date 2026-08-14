import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';
import '../domain/invoice_item_gateway.dart';

@singleton
class GetInvoiceUseCase {
  GetInvoiceUseCase(this._tenantResolver, this._invoices, this._items);

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final InvoiceItemGateway _items;

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
    return invoice;
  }

  Future<List<InvoiceItem>> items(
    Session session,
    int invoiceId, {
    int? businessId,
  }) async {
    await call(session, invoiceId, businessId: businessId);
    return _items.findByInvoiceId(session, invoiceId);
  }
}
