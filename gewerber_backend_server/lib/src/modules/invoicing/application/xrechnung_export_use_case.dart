import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../../business/domain/business_gateway.dart';
import '../../business/domain/business_settings_gateway.dart';
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
    this._businessSettings,
  );

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final InvoiceItemGateway _items;
  final CustomerGateway _customers;
  final BusinessGateway _businesses;
  final BusinessSettingsGateway _businessSettings;

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
    final settings = await _businessSettings.findByBusinessId(
      session,
      tenant.businessId,
    );

    final original = invoice.originalInvoiceId == null
        ? null
        : await _invoices.findById(session, invoice.originalInvoiceId!);
    if (invoice.originalInvoiceId != null &&
        (original == null || original.businessId != tenant.businessId)) {
      throw ConflictException(
        message:
            'Credit note ${invoice.number} references an original invoice that '
            'no longer exists.',
      );
    }

    // Fail fast rather than emitting XML the official KoSIT validator would
    // reject: BR-DE-1 (payment account / BG-16), BR-DE-2 (seller contact /
    // BG-6), BR-DE-15 (buyer reference / BT-10), BR-8/BR-9 (seller address /
    // BG-5), BR-CO-25 (due date or payment terms / BT-9) and PEPPOL-EN16931-
    // R020/R010 (seller/buyer electronic address / BT-34/BT-49) are
    // mandatory for the target profile. Report every gap at once so the user
    // can fix them in a single pass.
    final missing = <String>[];
    if (customer == null) {
      missing
        ..add('buyer e-mail')
        ..add('buyer reference');
    } else {
      if (!_hasValue(customer.email)) {
        missing.add('buyer e-mail');
      }
      if (!_hasValue(customer.buyerReference)) {
        missing.add('buyer reference');
      }
    }
    if (!_hasValue(business.email)) {
      missing.add('seller e-mail');
    }
    // BG-6 needs at least one of phone/e-mail; only flag the phone when
    // neither is present (a missing e-mail is already flagged for R020).
    if (!_hasValue(business.phone) && !_hasValue(business.email)) {
      missing.add('seller phone');
    }
    final address = business.address;
    if (address == null ||
        !_hasValue(address.street) ||
        !_hasValue(address.city)) {
      missing.add('seller address');
    }
    if (!_hasValue(settings?.iban)) {
      missing.add('seller IBAN');
    }
    if (invoice.dueDate == null && invoice.paymentTermsDays <= 0) {
      missing.add('invoice due date or payment terms');
    }
    if (missing.isNotEmpty) {
      throw ValidationException(
        message:
            'XRechnung export requires: seller e-mail, seller phone, '
            'seller address, seller IBAN, buyer e-mail, buyer reference, '
            'invoice due date. Missing: ${missing.join(', ')}.',
      );
    }

    return const XrechnungSerializer().serialize(
      invoice: invoice,
      items: items,
      business: business,
      customer: customer,
      settings: settings,
      originalInvoiceNumber: original?.number,
    );
  }

  static bool _hasValue(String? value) =>
      value != null && value.trim().isNotEmpty;
}
