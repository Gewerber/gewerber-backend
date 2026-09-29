import 'dart:convert';

import 'package:gewerber_backend_server/src/core/i18n/locale_message_catalog.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/data/pdf_invoice_generator.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/invoice_pdf_generator.dart';
import 'package:test/test.dart';

/// Builds a minimal but complete [InvoicePdfData] fixture.
///
/// The PDF generator is a pure function of its input — no session, no database
/// — so the whole rendering path is unit-testable here and does not need the
/// integration Postgres. That matters because the `invoice_pdf_test.dart`
/// integration suite can only run in CI.
InvoicePdfData _data({
  Locale invoiceLocale = Locale.de,
  Locale businessLocale = Locale.de,
  InvoiceType type = InvoiceType.invoice,
  Country customerCountry = Country.deu,
}) {
  return InvoicePdfData(
    business: Business(
      id: 1,
      name: 'Mein Gewerbe',
      vatId: 'DE123456789',
      email: 'kontakt@example.de',
      address: Address(
        street: 'Musterstr. 1',
        zip: '10115',
        city: 'Berlin',
        country: Country.deu,
      ),
      locale: businessLocale,
    ),
    invoice: Invoice(
      id: 1,
      businessId: 1,
      number: '2026-001',
      type: type,
      issueDate: DateTime.utc(2026, 8, 20),
      dueDate: DateTime.utc(2026, 9, 3),
      locale: invoiceLocale,
      notes: 'Vielen Dank für Ihren Auftrag.',
      paymentTermsDays: 14,
    ),
    items: [
      InvoiceItem(
        id: 1,
        invoiceId: 1,
        position: 1,
        description: 'Beratung',
        quantity: 10,
        unit: InvoiceItemUnit.hour,
        unitPriceCents: 10000,
        vatRate: VatRate.standard,
        lineTotalCents: 100000,
      ),
    ],
    customer: Customer(
      id: 1,
      businessId: 1,
      name: 'ACME GmbH',
      companyName: 'ACME GmbH',
      vatId: 'DE987654321',
      address: Address(
        street: 'Kundenweg 2',
        zip: '80331',
        city: 'München',
        country: customerCountry,
      ),
    ),
  );
}

Future<String> _render(InvoicePdfData data) async {
  final bytes = await PdfInvoiceGenerator(
    const LocaleMessageCatalog(),
  ).generate(data);
  return utf8.decode(bytes, allowMalformed: true);
}

void main() {
  group('document language', () {
    test('renders the invoice locale', () async {
      // The document /Title metadata carries the localized document label, which
      // makes it assertable without inflating the compressed content streams.
      final pdf = await _render(_data(invoiceLocale: Locale.de));
      expect(pdf, contains('Rechnung 2026-001'));
    });

    test('renders English for an English invoice', () async {
      final pdf = await _render(_data(invoiceLocale: Locale.en));
      expect(pdf, contains('Invoice 2026-001'));
      expect(pdf, isNot(contains('Rechnung 2026-001')));
    });

    test('renders a credit note with the credit note label', () async {
      final pdf = await _render(
        _data(type: InvoiceType.creditNote, invoiceLocale: Locale.de),
      );
      expect(pdf, contains('Gutschrift 2026-001'));
    });

    test('prefers the invoice locale over the business locale', () async {
      // A document keeps the language it was issued in, even after the
      // business display language changes.
      final pdf = await _render(
        _data(invoiceLocale: Locale.de, businessLocale: Locale.en),
      );
      expect(pdf, contains('Rechnung 2026-001'));
    });

    test('de and en renderings of the same invoice differ', () async {
      // Guards that the locale actually reaches the renderer rather than being
      // resolved and then ignored.
      final de = await _render(_data(invoiceLocale: Locale.de));
      final en = await _render(_data(invoiceLocale: Locale.en));
      expect(de, isNot(en));
    });
  });

  group('font fallback wiring', () {
    test('the rendered PDF embeds the Unicode fallback font', () async {
      // Regression guard for issue #70 at the *wiring* level:
      // invoice_pdf_font_test.dart proves the vendored TTF has the glyphs,
      // this proves the generator actually registers it. The EUR fixture
      // renders `€` through MoneyFormatter.formatCents — a codepoint the
      // built-in Helvetica (WinAnsi, U+0000–U+00FF) cannot draw — so only
      // the document theme's `fontFallback` can put Roboto into the
      // output. The pdf package writes the font dictionary and descriptor
      // as plain (uncompressed) indirect objects — verified empirically,
      // no /ObjStm is emitted — so the subset name `Roboto-Regular`
      // (Type0 /BaseFont and CIDFont /FontName) and the /FontFile2 stream
      // holding the embedded TTF program are reliably locatable in the
      // raw bytes. Drop the `theme:` argument from pw.Document in
      // PdfInvoiceGenerator.generate and every one of these expectations
      // fails — that is the point.
      //
      // No skip guard on purpose: when assets/fonts/Roboto-Regular.ttf is
      // missing, InvoicePdfFont.load() yields null, the document is built
      // without the fallback and this test fails loudly — the desired
      // canary for a broken deployment.
      final pdf = await _render(_data());
      expect(
        pdf,
        contains('Roboto-Regular'),
        reason:
            'the € in the amounts must be drawn from the vendored '
            'fallback font, which requires the theme wiring',
      );
      expect(
        pdf,
        contains('/FontFile2'),
        reason:
            'the fallback TTF program must actually be embedded, not '
            'just named (built-in fonts are never /FontFile2-embedded)',
      );
    });
  });

  group('locales without a translated catalog', () {
    test('an ru invoice still renders German instead of failing', () async {
      // ru is a valid persisted Locale with no catalog yet. It must resolve to
      // the German catalog and produce a document, exactly as it did before
      // i18n — not throw, and not emit unrenderable Cyrillic.
      final pdf = await _render(_data(invoiceLocale: Locale.ru));
      expect(pdf, contains('Rechnung 2026-001'));
    });

    test('a tr invoice still renders German instead of failing', () async {
      final pdf = await _render(_data(invoiceLocale: Locale.tr));
      expect(pdf, contains('Rechnung 2026-001'));
    });

    test(
      'a ru invoice with an English business renders German, not English',
      () async {
        final pdf = await _render(
          _data(invoiceLocale: Locale.ru, businessLocale: Locale.en),
        );
        expect(pdf, contains('Rechnung 2026-001'));
        expect(pdf, isNot(contains('Invoice 2026-001')));
      },
    );
  });

  group('country names', () {
    test('renders for every country without exhausting the mapping', () async {
      // Guards the exhaustive switch at runtime: a new Country value that
      // reached the generator unmapped would render its raw enum code on the
      // invoice, and a missing catalog entry would fail the render outright.
      for (final country in Country.values) {
        final pdf = await _render(_data(customerCountry: country));
        expect(pdf, startsWith('%PDF-'), reason: 'country ${country.name}');
      }
    });
  });
}
