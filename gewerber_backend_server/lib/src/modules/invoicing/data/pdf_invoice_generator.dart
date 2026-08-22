import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../generated/protocol.dart';
import '../domain/invoice_pdf_generator.dart';
import '../domain/money_formatter.dart';
import '../domain/tax_rule_engine.dart';

/// Renders an invoice PDF with a German §14 UStG compliant layout.
///
/// Uses the built-in Helvetica font (WinAnsi encoding), which covers the
/// German umlauts and the euro sign without embedding external font files.
@Singleton(as: InvoicePdfGenerator)
class PdfInvoiceGenerator implements InvoicePdfGenerator {
  const PdfInvoiceGenerator();

  static const _baseStyleFontSize = 9.0;

  @override
  Future<Uint8List> generate(InvoicePdfData data) async {
    final document = pw.Document(
      author: data.business.name,
      title: 'Rechnung ${data.invoice.number}',
      subject: 'Invoice ${data.invoice.number}',
      creator: 'Gewerber',
    );

    document.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(48, 40, 48, 40),
        build: (context) => [
          _header(data),
          pw.SizedBox(height: 16),
          _recipientAndMeta(data),
          pw.SizedBox(height: 20),
          _title(data),
          pw.SizedBox(height: 12),
          _itemsTable(data),
          pw.SizedBox(height: 12),
          _totals(data),
          pw.SizedBox(height: 16),
          _taxNotice(data),
          pw.SizedBox(height: 12),
          _notes(data),
        ],
        footer: (context) =>
            _footer(data, context.pageNumber, context.pagesCount),
      ),
    );

    return document.save();
  }

  pw.Widget _header(InvoicePdfData data) {
    final business = data.business;
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                business.name,
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 4),
              if (business.address != null) ..._addressLines(business.address!),
            ],
          ),
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            if (business.vatId != null && business.vatId!.isNotEmpty)
              _kv('USt-IdNr.', business.vatId!),
            if (business.taxNumber != null && business.taxNumber!.isNotEmpty)
              _kv('Steuernummer', business.taxNumber!),
            if (business.email != null && business.email!.isNotEmpty)
              _kv('E-Mail', business.email!),
            if (business.phone != null && business.phone!.isNotEmpty)
              _kv('Telefon', business.phone!),
          ],
        ),
      ],
    );
  }

  List<pw.Widget> _addressLines(Address address) {
    return [
      pw.Text(address.street, style: _small()),
      pw.Text('${address.zip} ${address.city}', style: _small()),
      pw.Text(_countryName(address.country), style: _small()),
    ];
  }

  pw.Widget _recipientAndMeta(InvoicePdfData data) {
    final customer = data.customer;
    final invoice = data.invoice;
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Rechnungsempfänger', style: _label()),
              pw.SizedBox(height: 4),
              if (customer == null)
                pw.Text('–', style: _base())
              else ...[
                pw.Text(
                  customer.companyName ?? customer.name,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                if (customer.companyName != null)
                  pw.Text(customer.name, style: _base()),
                if (customer.address != null)
                  ..._addressLines(customer.address!),
                if (customer.vatId != null && customer.vatId!.isNotEmpty)
                  pw.SizedBox(height: 4),
                if (customer.vatId != null && customer.vatId!.isNotEmpty)
                  _kv('USt-IdNr.', customer.vatId!),
              ],
            ],
          ),
        ),
        pw.SizedBox(width: 24),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _kv('Rechnungsnummer', invoice.number),
            _kv('Rechnungsdatum', _formatDate(invoice.issueDate)),
            if (invoice.dueDate != null)
              _kv('Fällig am', _formatDate(invoice.dueDate!)),
            if (invoice.serviceDateFrom != null)
              _kv(
                'Leistungszeitraum',
                invoice.serviceDateTo != null
                    ? '${_formatDate(invoice.serviceDateFrom!)} – '
                          '${_formatDate(invoice.serviceDateTo!)}'
                    : _formatDate(invoice.serviceDateFrom!),
              ),
          ],
        ),
      ],
    );
  }

  pw.Widget _title(InvoicePdfData data) {
    final headerText = data.template?.headerText;
    final title = (headerText != null && headerText.trim().isNotEmpty)
        ? headerText.trim()
        : 'Rechnung';
    return pw.Text(
      title,
      style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
    );
  }

  pw.Widget _itemsTable(InvoicePdfData data) {
    final header = [
      'Pos.',
      'Leistung',
      'Menge',
      'Einheit',
      'Einzelpreis',
      'USt.',
      'Gesamt',
    ];
    final rows = data.items
        .map(
          (item) => [
            '${item.position}',
            item.description,
            _formatQuantity(item.quantity),
            _unitName(item.unit),
            _formatCents(item.unitPriceCents, data.invoice.currency),
            _vatLabel(item.vatRate),
            _formatCents(item.lineTotalCents, data.invoice.currency),
          ],
        )
        .toList();

    return pw.TableHelper.fromTextArray(
      headers: header,
      data: rows,
      border: pw.TableBorder.all(color: PdfColors.grey, width: 0.5),
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        fontSize: _baseStyleFontSize,
      ),
      headerAlignment: pw.Alignment.centerLeft,
      cellStyle: pw.TextStyle(fontSize: _baseStyleFontSize),
      cellAlignment: pw.Alignment.topLeft,
      cellAlignments: {
        0: pw.Alignment.center,
        2: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.center,
        6: pw.Alignment.centerRight,
      },
      headerAlignments: {
        0: pw.Alignment.center,
        2: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.center,
        6: pw.Alignment.centerRight,
      },
      columnWidths: {
        0: const pw.FlexColumnWidth(0.6),
        1: const pw.FlexColumnWidth(3.2),
        2: const pw.FlexColumnWidth(0.8),
        3: const pw.FlexColumnWidth(0.9),
        4: const pw.FlexColumnWidth(1.2),
        5: const pw.FlexColumnWidth(0.7),
        6: const pw.FlexColumnWidth(1.2),
      },
      tableWidth: pw.TableWidth.max,
    );
  }

  pw.Widget _totals(InvoicePdfData data) {
    final invoice = data.invoice;
    final currency = invoice.currency;
    final isKleinunternehmer = data.business.isKleinunternehmer;

    final rows = <List<String>>[
      [
        'Zwischensumme (netto)',
        _formatCents(invoice.subtotalCents, currency),
      ],
    ];

    if (!isKleinunternehmer && invoice.vatTotalCents != 0) {
      rows.add([
        'Umsatzsteuer',
        _formatCents(invoice.vatTotalCents, currency),
      ]);
    }

    final table = pw.TableHelper.fromTextArray(
      data: rows,
      border: pw.TableBorder.all(color: PdfColors.grey, width: 0.5),
      cellStyle: pw.TextStyle(fontSize: _baseStyleFontSize),
      cellAlignments: {1: pw.Alignment.centerRight},
      columnWidths: {
        0: const pw.FlexColumnWidth(3),
        1: const pw.FlexColumnWidth(1.2),
      },
      tableWidth: pw.TableWidth.max,
    );

    final grandTotal = pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey200,
        border: pw.Border.all(color: PdfColors.grey, width: 0.5),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            'Gesamtbetrag',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: _baseStyleFontSize + 1,
            ),
          ),
          pw.Text(
            _formatCents(invoice.totalCents, currency),
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: _baseStyleFontSize + 1,
            ),
          ),
        ],
      ),
    );

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [table, pw.SizedBox(height: 6), grandTotal],
    );
  }

  pw.Widget _taxNotice(InvoicePdfData data) {
    final notice = _taxNoticeText(data);
    if (notice == null) return pw.SizedBox();
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey, width: 0.5),
      ),
      child: pw.Text(notice, style: _small()),
    );
  }

  String? _taxNoticeText(InvoicePdfData data) {
    if (data.business.isKleinunternehmer) {
      return 'Gemäß § 19 UStG wird keine Umsatzsteuer berechnet.';
    }
    final rates = data.items.map((i) => i.vatRate).toSet();
    if (rates.contains(VatRate.reverseCharge)) {
      return 'Steuerschuldnerschaft des Leistungsempfängers (Reverse Charge). '
          'Die Umsatzsteuer geht auf den Leistungsempfänger über.';
    }
    return null;
  }

  pw.Widget _notes(InvoicePdfData data) {
    final invoice = data.invoice;
    final footerText = data.template?.footerText;
    final blocks = <pw.Widget>[];

    if (invoice.notes != null && invoice.notes!.trim().isNotEmpty) {
      blocks.add(
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Anmerkungen', style: _label()),
            pw.SizedBox(height: 2),
            pw.Text(invoice.notes!.trim(), style: _base()),
          ],
        ),
      );
    }

    blocks.add(
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Zahlungsbedingungen', style: _label()),
          pw.SizedBox(height: 2),
          pw.Text(
            'Zahlbar innerhalb von ${invoice.paymentTermsDays} Tagen '
            'nach Rechnungsdatum ohne Abzug.',
            style: _base(),
          ),
        ],
      ),
    );

    if (footerText != null && footerText.trim().isNotEmpty) {
      blocks.add(pw.Text(footerText.trim(), style: _small()));
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < blocks.length; i++) ...[
          if (i > 0) pw.SizedBox(height: 10),
          blocks[i],
        ],
      ],
    );
  }

  pw.Widget _footer(InvoicePdfData data, int pageNumber, int pagesCount) {
    final business = data.business;
    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 8),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          top: pw.BorderSide(color: PdfColors.grey, width: 0.5),
        ),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            '${business.name} · Rechnung ${data.invoice.number}',
            style: pw.TextStyle(fontSize: 7, color: PdfColors.grey700),
          ),
          pw.Text(
            'Seite $pageNumber von $pagesCount',
            style: pw.TextStyle(fontSize: 7, color: PdfColors.grey700),
          ),
        ],
      ),
    );
  }

  pw.Widget _kv(String key, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2),
      child: pw.Row(
        children: [
          pw.SizedBox(
            width: 96,
            child: pw.Text(key, style: _label()),
          ),
          pw.Text(value, style: _base()),
        ],
      ),
    );
  }

  pw.TextStyle _base() => pw.TextStyle(fontSize: _baseStyleFontSize);

  pw.TextStyle _small() => pw.TextStyle(fontSize: 8, color: PdfColors.grey800);

  pw.TextStyle _label() => pw.TextStyle(fontSize: 8, color: PdfColors.grey700);

  String _vatLabel(VatRate rate) {
    return switch (rate) {
      VatRate.standard => '${TaxRuleEngine.standardPercent} %',
      VatRate.reduced => '${TaxRuleEngine.reducedPercent} %',
      VatRate.zero => '0 %',
      VatRate.none => '–',
      VatRate.reverseCharge => 'RC',
    };
  }

  String _unitName(InvoiceItemUnit unit) {
    return switch (unit) {
      InvoiceItemUnit.piece => 'Stk.',
      InvoiceItemUnit.hour => 'Std.',
      InvoiceItemUnit.day => 'Tag',
      InvoiceItemUnit.month => 'Monat',
      InvoiceItemUnit.project => 'Projekt',
      InvoiceItemUnit.other => 'Sonst.',
    };
  }

  String _countryName(Country country) {
    return switch (country) {
      Country.deu => 'Deutschland',
      Country.aut => 'Österreich',
      Country.bel => 'Belgien',
      Country.bgr => 'Bulgarien',
      Country.hrv => 'Kroatien',
      Country.cyp => 'Zypern',
      Country.cze => 'Tschechien',
      Country.dnk => 'Dänemark',
      Country.est => 'Estland',
      Country.fin => 'Finnland',
      Country.fra => 'Frankreich',
      Country.grc => 'Griechenland',
      Country.hun => 'Ungarn',
      Country.irl => 'Irland',
      Country.ita => 'Italien',
      Country.lva => 'Lettland',
      Country.ltu => 'Litauen',
      Country.lux => 'Luxemburg',
      Country.mlt => 'Malta',
      Country.nld => 'Niederlande',
      Country.pol => 'Polen',
      Country.prt => 'Portugal',
      Country.rou => 'Rumänien',
      Country.svk => 'Slowakei',
      Country.svn => 'Slowenien',
      Country.esp => 'Spanien',
      Country.swe => 'Schweden',
      Country.che => 'Schweiz',
      Country.gbr => 'Vereinigtes Königreich',
      Country.usa => 'USA',
      _ => country.name,
    };
  }

  String _formatDate(DateTime dateTime) {
    final d = dateTime.toLocal();
    final day = d.day.toString().padLeft(2, '0');
    final month = d.month.toString().padLeft(2, '0');
    return '$day.$month.${d.year}';
  }

  String _formatQuantity(double quantity) {
    if (quantity == quantity.truncateToDouble()) {
      return quantity.truncate().toString();
    }
    return quantity.toStringAsFixed(2).replaceAll('.', ',');
  }

  String _formatCents(int cents, Currency currency) =>
      MoneyFormatter.formatCents(cents, currency);
}
