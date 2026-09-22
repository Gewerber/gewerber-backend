import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../../business/domain/business_gateway.dart';
import '../domain/customer_gateway.dart';
import '../domain/invoice_gateway.dart';
import '../domain/invoice_item_gateway.dart';
import '../domain/xrechnung_serializer.dart';

/// Exports a single invoice as an XRechnung XML document (EN 16931 / CII).
@singleton
class XrechnungExportUseCase {
  XrechnungExportUseCase(
    this._tenantResolver,
    this._invoices,
    this._items,
    this._customers,
    this._businesses,
  );

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final InvoiceItemGateway _items;
  final CustomerGateway _customers;
  final BusinessGateway _businesses;

  /// Export the invoice [invoiceId] as an XRechnung XML string.
  Future<String> exportXrechnung(
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
      throw NotFoundException(entityType: 'Invoice', entityId: '$invoiceId');
    }

    final items = await _items.findByInvoiceId(session, invoiceId);
    final customer = invoice.customerId == null
        ? null
        : await _customers.findById(session, invoice.customerId!);
    final business = await _businesses.findById(session, tenant.businessId);
    if (business == null) {
      throw NotFoundException(
        entityType: 'Business',
        entityId: '${tenant.businessId}',
      );
    }

    return const XrechnungSerializer().serialize(
      invoice: invoice,
      items: items,
      business: business,
      customer: customer,
    );
  }
}
