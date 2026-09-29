import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/i18n/country_names.dart';
import '../../../core/i18n/locale_format.dart';
import '../../../core/i18n/locale_resolver.dart';
import '../../../core/i18n/message_catalog.dart';
import '../../../core/i18n/messages.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_pdf_generator.dart';
import '../domain/money_formatter.dart';
import '../domain/tax_rule_engine.dart';
import 'invoice_pdf_font.dart';

/// Renders an invoice PDF whose labels follow the invoice's own locale.
///
/// ## Locale
///
/// Every visible label is resolved through [MessageCatalog] in the locale
/// returned by [LocaleResolver.forInvoice], i.e. the `locale` snapshotted on
/// the `Invoice` record at issue time, with the `Business` locale as the
/// fallback for records that predate it. Because the document language is a
/// property of the stored invoice rather than of the request or the current
/// user, re-rendering the same invoice always produces the same document.
///
/// ## Font
///
/// The built-in Helvetica fonts (WinAnsi encoding, U+0000–U+00FF only) stay
/// the base fonts, so existing Latin text keeps its current appearance and
/// metrics. A vendored Roboto (Apache-2.0, `assets/fonts/Roboto-Regular.ttf`)
/// is registered as a Unicode `fontFallback` in the document theme: glyphs
/// outside WinAnsi — the euro sign `€` (U+20AC), the en dash `–` (U+2013),
/// Cyrillic and Turkish — are drawn from Roboto per glyph instead of failing
/// (issue #70). The path can be overridden with the
/// `GEWERBER_INVOICE_FONT_PATH` environment variable. When the font cannot be
/// loaded the document is built without a theme, reproducing the old
/// Helvetica-only behaviour on a misconfigured deployment.
///
/// ## Legal wording
///
/// A number of labels here (`Rechnungsnummer`, `Rechnungsdatum`, `Fällig am`,
/// the §19 UStG note) may be prescribed wording on a German domestic invoice
/// and therefore possibly non-translatable. If legal review says so, the
/// affected keys must be pinned to the German string in every catalog — see the
/// note in `core/i18n/messages_de.dart` and issue #57.
@Singleton(as: InvoicePdfGenerator)
class PdfInvoiceGenerator implements InvoicePdfGenerator {
  PdfInvoiceGenerator(this._messages);

  final MessageCatalog _messages;

  static const _baseStyleFontSize = 9.0;

  /// The vendored Unicode fallback font, read from disk at most once.
  ///
  /// [InvoicePdfFont.load] never throws and returns `null` when the font file
  /// is missing or unreadable; [_unicodeFallbackLoaded] makes `null` a
  /// permanent outcome for this generator instead of re-reading the file (and
  /// re-warning on `stderr`) for every invoice.
  pw.Font? _unicodeFallback;
  bool _unicodeFallbackLoaded = false;

  @override
  Future<Uint8List> generate(InvoicePdfData data) async {
    final locale = _localeOf(data);
    final documentLabel = _documentLabel(data, locale);

    final document = pw.Document(
      author: data.business.name,
      title: '$documentLabel ${data.invoice.number}',
      subject: '$documentLabel ${data.invoice.number}',
      creator: 'Gewerber',
      // `null` when the fallback font is unavailable: the document is then
      // built with the pdf package's default theme, exactly as before the
      // fallback was wired in.
      theme: _themeWithFontFallback(),
    );

    document.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(48, 40, 48, 40),
        build: (context) => [
          _header(data, locale),
          pw.SizedBox(height: 16),
          _recipientAndMeta(data, locale),
          pw.SizedBox(height: 20),
          _title(data, locale),
          pw.SizedBox(height: 12),
          _itemsTable(data, locale),
          pw.SizedBox(height: 12),
          _totals(data, locale),
          pw.SizedBox(height: 16),
          _taxNotice(data, locale),
          pw.SizedBox(height: 12),
          _notes(data, locale),
        ],
        footer: (context) =>
            _footer(data, locale, context.pageNumber, context.pagesCount),
      ),
    );

    return document.save();
  }

  /// The document's own language: the locale stored on the invoice, falling
  /// back to the business, then to the catalog fallback locale.
  ///
  /// A locale is only used if the catalog actually has content for it. `ru`
  /// and `tr` are valid, persisted locales, but have no catalog yet, so they
  /// resolve to [fallbackLocale] and render German — exactly what the
  /// generator produced for every user before issue #57. Gating on
  /// `translatedLocales` rather than on the enum is what keeps this a no-op
  /// instead of a new failure for those two locales.
  ///
  /// Since issue #70 the font is no longer a constraint: the Unicode fallback
  /// registered by [_themeWithFontFallback] is glyph-renderable for Cyrillic
  /// and Turkish, so `ru` and `tr` can render as soon as issue #57 adds their
  /// message catalogs; until then they keep rendering German through the
  /// fallback locale.
  Locale _localeOf(InvoicePdfData data) {
    final resolved = LocaleResolver.forInvoice(
      invoice: data.invoice.locale,
      business: data.business.locale,
    );
    return _messages.translatedLocales.contains(resolved)
        ? resolved
        : fallbackLocale;
  }

  /// The document theme: built-in Helvetica plus a per-glyph Unicode fallback.
  ///
  /// Returns `null` — leaving the pdf package's default Helvetica-only theme
  /// in effect — when [InvoicePdfFont] cannot be loaded, so a misconfigured
  /// deployment keeps generating invoices exactly as before issue #70 instead
  /// of failing. Otherwise the vendored Roboto is registered as
  /// `fontFallback` only: `base` stays unset, so all existing Latin text
  /// keeps its current font, appearance and layout, while `€`, `–` and
  /// Cyrillic/Turkish glyphs are drawn from Roboto.
  pw.ThemeData? _themeWithFontFallback() {
    final font = _unicodeFallbackFont();
    return font == null ? null : pw.ThemeData.withFont(fontFallback: [font]);
  }

  /// Loads the fallback font at most once per generator instance.
  ///
  /// The production generator is a `@Singleton`, so the font file is read
  /// from disk a single time per process.
  pw.Font? _unicodeFallbackFont() {
    if (!_unicodeFallbackLoaded) {
      _unicodeFallbackLoaded = true;
      _unicodeFallback = InvoicePdfFont.load();
    }
    return _unicodeFallback;
  }

  bool _isCreditNote(InvoicePdfData data) =>
      data.invoice.type == InvoiceType.creditNote;

  String _documentLabel(InvoicePdfData data, Locale locale) =>
      _isCreditNote(
        data,
      )
      ? _messages.text(Messages.pdfDocumentCreditNote, locale: locale)
      : _messages.text(Messages.pdfDocumentInvoice, locale: locale);

  pw.Widget _header(InvoicePdfData data, Locale locale) {
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
              if (business.address != null)
                ..._addressLines(business.address!, locale),
            ],
          ),
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            if (business.vatId != null && business.vatId!.isNotEmpty)
              _kv(
                _messages.text(Messages.pdfFieldVatId, locale: locale),
                business.vatId!,
              ),
            if (business.taxNumber != null && business.taxNumber!.isNotEmpty)
              _kv(
                _messages.text(Messages.pdfFieldTaxNumber, locale: locale),
                business.taxNumber!,
              ),
            if (business.email != null && business.email!.isNotEmpty)
              _kv(
                _messages.text(Messages.pdfFieldEmail, locale: locale),
                business.email!,
              ),
            if (business.phone != null && business.phone!.isNotEmpty)
              _kv(
                _messages.text(Messages.pdfFieldPhone, locale: locale),
                business.phone!,
              ),
          ],
        ),
      ],
    );
  }

  List<pw.Widget> _addressLines(Address address, Locale locale) {
    return [
      pw.Text(address.street, style: _small()),
      pw.Text('${address.zip} ${address.city}', style: _small()),
      pw.Text(_countryName(address.country, locale), style: _small()),
    ];
  }

  pw.Widget _recipientAndMeta(InvoicePdfData data, Locale locale) {
    final customer = data.customer;
    final invoice = data.invoice;
    final isCreditNote = _isCreditNote(data);
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                isCreditNote
                    ? _messages.text(
                        Messages.pdfFieldCreditNoteRecipient,
                        locale: locale,
                      )
                    : _messages.text(
                        Messages.pdfFieldInvoiceRecipient,
                        locale: locale,
                      ),
                style: _label(),
              ),
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
                  ..._addressLines(customer.address!, locale),
                if (customer.vatId != null && customer.vatId!.isNotEmpty)
                  pw.SizedBox(height: 4),
                if (customer.vatId != null && customer.vatId!.isNotEmpty)
                  _kv(
                    _messages.text(
                      Messages.pdfFieldCustomerVatId,
                      locale: locale,
                    ),
                    customer.vatId!,
                  ),
              ],
            ],
          ),
        ),
        pw.SizedBox(width: 24),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _kv(
              isCreditNote
                  ? _messages.text(
                      Messages.pdfFieldCreditNoteNumber,
                      locale: locale,
                    )
                  : _messages.text(
                      Messages.pdfFieldInvoiceNumber,
                      locale: locale,
                    ),
              invoice.number,
            ),
            _kv(
              isCreditNote
                  ? _messages.text(
                      Messages.pdfFieldCreditNoteDate,
                      locale: locale,
                    )
                  : _messages.text(
                      Messages.pdfFieldInvoiceDate,
                      locale: locale,
                    ),
              _formatDate(invoice.issueDate, locale),
            ),
            if (data.originalInvoiceNumber != null)
              _kv(
                _messages.text(
                  Messages.pdfFieldCancelledInvoice,
                  locale: locale,
                ),
                data.originalInvoiceNumber!,
              ),
            if (!isCreditNote && invoice.dueDate != null)
              _kv(
                _messages.text(Messages.pdfFieldDueDate, locale: locale),
                _formatDate(invoice.dueDate!, locale),
              ),
            if (invoice.serviceDateFrom != null)
              _kv(
                _messages.text(Messages.pdfFieldServicePeriod, locale: locale),
                invoice.serviceDateTo != null
                    ? '${_formatDate(invoice.serviceDateFrom!, locale)} – '
                          '${_formatDate(invoice.serviceDateTo!, locale)}'
                    : _formatDate(invoice.serviceDateFrom!, locale),
              ),
          ],
        ),
      ],
    );
  }

  pw.Widget _title(InvoicePdfData data, Locale locale) {
    if (_isCreditNote(data)) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            _messages.text(
              Messages.pdfDocumentCancellationNotice,
              locale: locale,
            ),
            style: pw.TextStyle(
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          if (data.originalInvoiceNumber != null) ...[
            pw.SizedBox(height: 3),
            pw.Text(
              _messages.text(
                Messages.pdfDocumentCorrectionNote,
                locale: locale,
                args: {'number': data.originalInvoiceNumber},
              ),
              style: _base(),
            ),
          ],
        ],
      );
    }

    final headerText = data.template?.headerText;
    final title = (headerText != null && headerText.trim().isNotEmpty)
        ? headerText.trim()
        : _messages.text(Messages.pdfDocumentInvoice, locale: locale);
    return pw.Text(
      title,
      style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
    );
  }

  pw.Widget _itemsTable(InvoicePdfData data, Locale locale) {
    final header = [
      _messages.text(Messages.pdfTablePosition, locale: locale),
      _messages.text(Messages.pdfTableDescription, locale: locale),
      _messages.text(Messages.pdfTableQuantity, locale: locale),
      _messages.text(Messages.pdfTableUnit, locale: locale),
      _messages.text(Messages.pdfTableUnitPrice, locale: locale),
      _messages.text(Messages.pdfTableVatRate, locale: locale),
      _messages.text(Messages.pdfTableLineTotal, locale: locale),
    ];
    final rows = data.items
        .map(
          (item) => [
            '${item.position}',
            item.description,
            _formatQuantity(item.quantity, locale),
            _unitName(item.unit, locale),
            _formatCents(item.unitPriceCents, data.invoice.currency, locale),
            _vatLabel(item.vatRate),
            _formatCents(item.lineTotalCents, data.invoice.currency, locale),
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

  pw.Widget _totals(InvoicePdfData data, Locale locale) {
    final invoice = data.invoice;
    final currency = invoice.currency;
    // A credit note must display the original's stored VAT. The business's
    // current §19 status is deliberately ignored for credits so a change
    // after issuance cannot rewrite the reversal document.
    final isKleinunternehmer =
        !_isCreditNote(data) && data.business.isKleinunternehmer;

    final rows = <List<String>>[
      [
        _messages.text(Messages.pdfTotalNetSubtotal, locale: locale),
        _formatCents(invoice.subtotalCents, currency, locale),
      ],
    ];

    if (!isKleinunternehmer && invoice.vatTotalCents != 0) {
      rows.add([
        _messages.text(Messages.pdfTotalVat, locale: locale),
        _formatCents(invoice.vatTotalCents, currency, locale),
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
            _messages.text(Messages.pdfTotalGrandTotal, locale: locale),
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: _baseStyleFontSize + 1,
            ),
          ),
          pw.Text(
            _formatCents(invoice.totalCents, currency, locale),
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

  pw.Widget _taxNotice(InvoicePdfData data, Locale locale) {
    final notice = _taxNoticeText(data, locale);
    if (notice == null) return pw.SizedBox();
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey, width: 0.5),
      ),
      child: pw.Text(notice, style: _small()),
    );
  }

  String? _taxNoticeText(InvoicePdfData data, Locale locale) {
    if (!_isCreditNote(data) && data.business.isKleinunternehmer) {
      return _messages.text(
        Messages.pdfNoteKleinunternehmer,
        locale: locale,
      );
    }
    final rates = data.items.map((i) => i.vatRate).toSet();
    if (rates.contains(VatRate.reverseCharge)) {
      return _messages.text(Messages.pdfNoteReverseCharge, locale: locale);
    }
    return null;
  }

  pw.Widget _notes(InvoicePdfData data, Locale locale) {
    final invoice = data.invoice;
    final footerText = data.template?.footerText;
    final blocks = <pw.Widget>[];

    if (invoice.notes != null && invoice.notes!.trim().isNotEmpty) {
      blocks.add(
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              _messages.text(Messages.pdfSectionNotes, locale: locale),
              style: _label(),
            ),
            pw.SizedBox(height: 2),
            pw.Text(invoice.notes!.trim(), style: _base()),
          ],
        ),
      );
    }

    if (_isCreditNote(data)) {
      blocks.add(
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              _messages.text(Messages.pdfSectionOffset, locale: locale),
              style: _label(),
            ),
            pw.SizedBox(height: 2),
            pw.Text(
              _messages.text(Messages.pdfTextOffsetExplanation, locale: locale),
              style: _base(),
            ),
          ],
        ),
      );
    } else {
      blocks.add(
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              _messages.text(Messages.pdfSectionPaymentTerms, locale: locale),
              style: _label(),
            ),
            pw.SizedBox(height: 2),
            pw.Text(
              _messages.text(
                Messages.pdfTextPaymentTerms,
                locale: locale,
                args: {'days': invoice.paymentTermsDays},
              ),
              style: _base(),
            ),
          ],
        ),
      );
    }

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

  pw.Widget _footer(
    InvoicePdfData data,
    Locale locale,
    int pageNumber,
    int pagesCount,
  ) {
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
            '${business.name} · ${_documentLabel(data, locale)} '
            '${data.invoice.number}',
            style: pw.TextStyle(fontSize: 7, color: PdfColors.grey700),
          ),
          pw.Text(
            _messages.text(
              Messages.pdfFooterPage,
              locale: locale,
              args: {'page': pageNumber, 'pages': pagesCount},
            ),
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

  /// VAT rate column.
  ///
  /// `RC` and `–` are notation rather than prose and stay as-is in every
  /// locale; the reverse-charge explanation is carried by the tax notice block,
  /// which is translated. The German spacing of `19 %` is kept deliberately —
  /// it is typographic, not a translation, and not worth a per-locale branch.
  String _vatLabel(VatRate rate) {
    return switch (rate) {
      VatRate.standard => '${TaxRuleEngine.standardPercent} %',
      VatRate.reduced => '${TaxRuleEngine.reducedPercent} %',
      VatRate.zero => '0 %',
      VatRate.none => '–',
      VatRate.reverseCharge => 'RC',
    };
  }

  String _unitName(InvoiceItemUnit unit, Locale locale) {
    final key = switch (unit) {
      InvoiceItemUnit.piece => Messages.pdfUnitPiece,
      InvoiceItemUnit.hour => Messages.pdfUnitHour,
      InvoiceItemUnit.day => Messages.pdfUnitDay,
      InvoiceItemUnit.month => Messages.pdfUnitMonth,
      InvoiceItemUnit.project => Messages.pdfUnitProject,
      InvoiceItemUnit.other => Messages.pdfUnitOther,
    };
    return _messages.text(key, locale: locale);
  }

  String _countryName(Country country, Locale locale) =>
      _messages.text(countryKey(country), locale: locale);

  String _formatDate(DateTime dateTime, Locale locale) =>
      LocaleFormat.date(dateTime, locale: locale);

  String _formatQuantity(double quantity, Locale locale) =>
      LocaleFormat.quantity(quantity, locale: locale);

  String _formatCents(int cents, Currency currency, Locale locale) =>
      MoneyFormatter.formatCents(cents, currency, locale: locale);
}
