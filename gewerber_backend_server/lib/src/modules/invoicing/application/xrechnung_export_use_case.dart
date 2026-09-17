import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';
import '../domain/invoice_item_gateway.dart';
import '../domain/customer_gateway.dart';

/// Use case to export an invoice as XRechnung XML.
///
/// XRechnung is the German e-invoice standard (EN 16931 compliant).
/// See: https://www.bbs.bund.de/EN/Topics/EInvoice/XRechnung/
@singleton
class XrechnungExportUseCase {
  /// The tenant resolver for multi-tenancy support.
  final TenantResolver _tenantResolver;

  /// Gateway for invoice database operations.
  final InvoiceGateway _invoices;

  /// Gateway for invoice item database operations.
  final InvoiceItemGateway _items;

  /// Gateway for customer database operations.
  final CustomerGateway _customers;

  XrechnungExportUseCase(
    TenantResolver tenantResolver,
    InvoiceGateway invoices,
    InvoiceItemGateway items,
    CustomerGateway customers,
  ) : _tenantResolver = tenantResolver,
      _invoices = invoices,
      _items = items,
      _customers = customers;

  /// Export a single invoice as XRechnung XML string.
  Future<String> exportXrechnung(
    Session session,
    int invoiceId, {
    int? businessId,
  }) async {
    // Use businessId from path or resolve tenant
    final effectiveBusinessId =
        businessId ??
        (await _tenantResolver.resolve(
          session,
          businessId: null,
        )).businessId;
    final invoice = await _invoices.findById(session, invoiceId);
    if (invoice == null) {
      throw Exception('Invoice not found: $invoiceId');
    }

    // Load invoice items
    final items = await _items.findByInvoiceIds(session, [invoiceId]);

    // Load customer
    Customer? customer;
    if (invoice.customerId != null) {
      customer = await _customers.findById(session, invoice.customerId!);
    }

    return _buildXrechnungXml(invoice, items, effectiveBusinessId, customer);
  }

  /// Build the XRechnung XML document for a single invoice.
  String _buildXrechnungXml(
    Invoice invoice,
    List<InvoiceItem> items,
    int businessId,
    Customer? customer,
  ) {
    final lines = <String>[];

    // XML declaration
    lines.add('<?xml version="1.0" encoding="UTF-8"?>');

    // Root element with namespaces
    lines.add(
      '<Invoice xmlns="urn:un:unece:uncefact:data:standard:reusableaggregatebusinessinformation:202"',
    );
    lines.add('  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"');
    lines.add(
      '  schemaLocation="urn:un:unece:uncefact:data:standard:reusableaggregatebusinessinformation:202 xsd/xrechnung-2.0.xsd">',
    );

    // Invoice header
    lines.add('  <cac:InvoiceHeader>');

    // Invoice type code (380 = Invoice)
    lines.add(
      '    <cac:InvoiceTypeCode listAgencyName="UNECE" listAgencyIdentifier="UN" name="380">Invoice</cac:InvoiceTypeCode>',
    );

    // Issue date
    lines.add('    <cac:IssueDate>');
    lines.add('      <cbc:Date>${_formatDate(invoice.issueDate)}</cbc:Date>');
    lines.add('    </cac:IssueDate>');

    // Issue time (optional)
    lines.add('    <cac:IssueTime>');
    lines.add('      <cbc:Time>${_formatTime(invoice.issueDate)}</cbc:Time>');
    lines.add('    </cac:IssueTime>');

    // Due date
    lines.add('    <cac:DueDate>');
    lines.add(
      '      <cbc:Date>${invoice.dueDate != null ? _formatDate(invoice.dueDate!) : ''}</cbc:Date>',
    );
    lines.add('    </cac:DueDate>');

    // Accounting seller party - business name placeholder (use businessId to look up in full impl)
    lines.add('    <cac:AccountingSupplierParty>');
    lines.add('      <cac:Party>');
    lines.add('        <cac:PartyLegalEntity>');
    lines.add('          <cbc:CompanyName>Gewerber GmbH</cbc:CompanyName>');
    lines.add('        </cac:PartyLegalEntity>');
    lines.add('      </cac:Party>');
    lines.add('    </cac:AccountingSupplierParty>');

    // Accounting buyer party
    lines.add('    <cac:AccountingCustomerParty>');
    lines.add('      <cac:Party>');
    if (customer != null) {
      lines.add('        <cac:PartyLegalEntity>');
      lines.add(
        '          <cbc:CompanyName>${_xmlEscape(customer.companyName ?? customer.name)}</cbc:CompanyName>',
      );
      lines.add('        </cac:PartyLegalEntity>');
    } else {
      lines.add(
        '        <cbc:CompanyName>Kunde nicht vorhanden</cbc:CompanyName>',
      );
    }
    lines.add('      </cac:Party>');
    lines.add('    </cac:AccountingCustomerParty>');

    // Invoice line(s)
    lines.add('    <cac:InvoiceLine>');

    if (items.isNotEmpty) {
      for (final item in items) {
        lines.add('      <cac:InvoiceLine>');
        lines.add('        <cbc:ID>${item.position}</cbc:ID>');
        lines.add(
          '        <cac:InvoicedQuantity unitCode="EA">${_formatQuantity(item.quantity)}</cbc:InvoicedQuantity>',
        );
        lines.add('        <cac:LineItemProductService>');
        lines.add(
          '          <cbc:Description>${_xmlEscape(item.description)}</cbc:Description>',
        );
        lines.add('        </cac:LineItemProductService>');
        lines.add('        <cac:LinePrice>');
        lines.add(
          '          <cbc:PriceAmount currencyCode="${_currencyCode(invoice.currency)}">${_formatCentsXrechnung(item.lineTotalCents)}</cbc:PriceAmount>',
        );
        lines.add('        </cac:LinePrice>');
        lines.add('      </cac:InvoiceLine>');
      }
    } else {
      // No items - single line invoice
      lines.add('      <cac:InvoiceLine>');
      lines.add('        <cbc:ID>1</cbc:ID>');
      lines.add(
        '        <cac:InvoicedQuantity unitCode="EA">1</cbc:InvoicedQuantity>',
      );
      lines.add('        <cac:LineItemProductService>');
      lines.add('          <cbc:Description>Rechnung</cbc:Description>');
      lines.add('        </cac:LineItemProductService>');
      lines.add('        <cac:LinePrice>');
      lines.add(
        '          <cbc:PriceAmount currencyCode="${_currencyCode(invoice.currency)}">${_formatCentsXrechnung(invoice.totalCents)}</cbc:PriceAmount>',
      );
      lines.add('        </cac:LinePrice>');
      lines.add('      </cac:InvoiceLine>');
    }

    lines.add('    </cac:InvoiceLine>');

    // Kleinunternehmer note
    // Check if the invoice's business is marked as Kleinunternehmer
    // In MVP: check via businessId marker; in full impl, fetch business entity
    final isKleinunternehmer =
        businessId == 0; // placeholder: businessId=0 means Kleinunternehmer
    if (isKleinunternehmer) {
      lines.add('    <cac:Note>');
      lines.add(
        '      <cbc:Content>Gemäß § 19 UStG wird keine Umsatzsteuer berechnet.</cbc:Content>',
      );
      lines.add('    </cac:Note>');
    }

    lines.add('  </cac:InvoiceHeader>');

    lines.add('</Invoice>');

    return lines.join('\n');
  }

  String _formatDate(DateTime date) {
    final d = date.toLocal();
    return '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
  }

  String _formatTime(DateTime date) {
    final d = date.toLocal();
    return '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}:${d.second.toString().padLeft(2, '0')}';
  }

  String _formatQuantity(double quantity) {
    if (quantity == quantity.truncateToDouble()) {
      return quantity.truncate().toString();
    }
    return quantity.toStringAsFixed(2).replaceAll('.', ',');
  }

  String _xmlEscape(String value) {
    return value
        .replaceAll('&', '&')
        .replaceAll('<', '<')
        .replaceAll('>', '>')
        .replaceAll('"', '"')
        .replaceAll("'", '&apos;');
  }

  String _currencyCode(Currency currency) {
    switch (currency) {
      case Currency.eur:
        return 'EUR';
      default:
        return 'EUR';
    }
  }

  String _formatCentsXrechnung(int cents) {
    // XRechnung uses decimal format with 2 decimal places, period as decimal separator
    // e.g., 1234.56 (not 1.234,56 German style)
    final formatted = (cents / 100).toStringAsFixed(2);
    return formatted;
  }
}
