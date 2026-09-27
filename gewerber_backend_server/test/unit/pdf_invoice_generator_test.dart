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
