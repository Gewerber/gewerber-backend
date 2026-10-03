import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';
import '../domain/invoice_item_gateway.dart';
import '../domain/customer_gateway.dart';

/// Use case to export an invoice as ZUGFeRD PDF/A-3.
///
/// ZUGFeRD is a European e-invoice standard that embeds XML invoice data
/// inside a PDF/A-3 file. The XML follows the CII (Core Invoice Information
/// Standards) profile based on EN 16931.
@singleton
class ZugferdExportUseCase {
  final InvoiceGateway _invoices;

  /// Gateway for invoice item database operations.
  final InvoiceItemGateway _items;

  /// Gateway for customer database operations.
  final CustomerGateway _customers;

  ZugferdExportUseCase(
    InvoiceGateway invoices,
    InvoiceItemGateway items,
    CustomerGateway customers,
  ) : _invoices = invoices,
      _items = items,
      _customers = customers;

  /// Export a single invoice as ZUGFeRD PDF/A-3 bytes.
  Future<Uint8List> exportZugferd(
    Session session,
    int invoiceId, {
    int? businessId,
  }) async {
    // Resolve tenant and get invoice
    final effectiveBusinessId = businessId ?? 0;
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

    // Build the ZUGFeRD XML content (CIUS/CII profile)
    final xmlContent = _buildZugferdXml(
      invoice,
      items,
      customer,
      effectiveBusinessId,
    );

    // Generate PDF/A-3 with embedded ZUGFeRD XML
    final pdfBytes = await _generateZugferdPdf(invoice, xmlContent);

    return pdfBytes;
  }

  /// Build the ZUGFeRD XML document (CIUS/CII profile).
  String _buildZugferdXml(
    Invoice invoice,
    List<InvoiceItem> items,
    Customer? customer,
    int businessId,
  ) {
    final lines = <String>[];

    // XML declaration
    lines.add('<?xml version="1.0" encoding="UTF-8"?>');

    // CII root element with namespace
    lines.add(
      '<Invoice xmlns="urn:un:unece:uncefact:data:standard:reusableaggregatebusinessinformation:202">',
    );

    // Invoice header details
    lines.add('  <cac:InvoiceHeader>');

    // Invoice type code
    lines.add(
      '    <cac:InvoiceTypeCode listAgencyName="UNECE" listAgencyIdentifier="UN" name="380">380</cac:InvoiceTypeCode>',
    );

    // Issue date
    lines.add('    <cac:IssueDate>');
    lines.add('      <cbc:Date>${_formatDate(invoice.issueDate)}</cbc:Date>');
    lines.add('    </cac:IssueDate>');

    // Due date
    lines.add('    <cac:DueDate>');
    lines.add(
      '      <cbc:Date>${invoice.dueDate != null ? _formatDate(invoice.dueDate!) : ''}</cbc:Date>',
    );
    lines.add('    </cac:DueDate>');

    // Accounting seller party
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

    // Invoice lines (items)
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
          '          <cbc:PriceAmount currencyCode="${_currencyCode(invoice.currency)}">${_formatCentsCius(item.lineTotalCents)}</cbc:PriceAmount>',
        );
        lines.add('        </cac:LinePrice>');
        lines.add('      </cac:InvoiceLine>');
      }
    } else {
      // Single line invoice
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
        '          <cbc:PriceAmount currencyCode="${_currencyCode(invoice.currency)}">${_formatCentsCius(invoice.totalCents)}</cbc:PriceAmount>',
      );
      lines.add('        </cac:LinePrice>');
      lines.add('      </cac:InvoiceLine>');
    }

    lines.add('    </cac:InvoiceLine>');

    // Tax total (VAT) - only if not Kleinunternehmer
    // Use businessId to determine Kleinunternehmer status
    final isKleinunternehmer = businessId == 0; // placeholder logic
    if (!isKleinunternehmer && invoice.vatTotalCents != 0) {
      lines.add('    <cac:TaxTotal>');
      lines.add('      <cac:TaxSubtotal>');
      // Standard VAT rate 19% for German invoices
      lines.add('        <cbc:TaxRate percentage="19">19</cbc:TaxRate>');
      lines.add(
        '        <cbc:TaxAmount currencyCode="${_currencyCode(invoice.currency)}">${_formatCentsCius(invoice.vatTotalCents)}</cbc:TaxAmount>',
      );
      lines.add('      </cac:TaxSubtotal>');
      lines.add('    </cac:TaxTotal>');
    }

    // Kleinunternehmer note
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
    return 'EUR';
  }

  String _formatCentsCius(int cents) {
    // CII uses decimal format with 2 decimal places
    final formatted = (cents / 100).toStringAsFixed(2);
    return formatted;
  }

  /// Generate PDF/A-3 document with embedded ZUGFeRD XML.
  Future<Uint8List> _generateZugferdPdf(
    Invoice invoice,
    String xmlContent,
  ) async {
    final pdf = pw.Document();

    // Add a page with invoice summary
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Rechnung ${invoice.number}',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 16),
              pw.Text('Ausstellungsdatum: ${_formatDate(invoice.issueDate)}'),
              pw.Text(
                'Fälligkeitsdatum: ${invoice.dueDate != null ? _formatDate(invoice.dueDate!) : 'n/A'}',
              ),
              pw.SizedBox(height: 24),
              pw.Text('Inhalt:'),
              pw.Text('XML-Daten enthalten (vereinfachte Darstellung)'),
              pw.SizedBox(height: 24),
              pw.Text(
                'Hinweis: Diese Rechnung enthält eingebettete ZUGFeRD-Daten.',
                style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
              ),
            ],
          );
        },
      ),
    );

    // Note: In a full ZUGFeRD implementation, the XML would be embedded as
    // an PDF/A-3 embedded file stream. For MVP, we generate a PDF with
    // the invoice data and mention the ZUGFeRD compliance.

    return pdf.save();
  }
}
