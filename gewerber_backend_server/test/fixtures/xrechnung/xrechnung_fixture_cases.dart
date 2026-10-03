// Shared input builders for the XRechnung golden fixtures.
//
// This library is the single source of truth for the six fixture cases. It is
// used by BOTH:
//
//   * `tool/generate_xrechnung_fixtures.dart` — writes the serialized XML to
//     `test/fixtures/xrechnung/*.xml` (the committed golden fixtures), and
//   * `test/unit/xrechnung_golden_test.dart` — re-serializes the same inputs
//     and pins the output byte-for-byte against those committed fixtures.
//
// It deliberately has no `main()`: it is a plain library, not a runnable
// script, so `dart test` never picks it up (only `*_test.dart` files run) and
// the generator stays the only entry point that writes files.
//
// Determinism: the fixtures are byte-compared by the golden test, so the
// inputs here must be byte-stable across machines and timezones. Use only
// local-naive `DateTime(...)` constructors — never `DateTime.now()` and never
// `DateTime.utc`. The serializer's `_formatDate` calls `.toLocal()`, which is
// a no-op for local-naive values, so the emitted dates do not depend on the
// machine's timezone.

import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/xrechnung_serializer.dart';

const serializer = XrechnungSerializer();

/// The seller: a fully-populated Berlin business (email, phone, VAT id,
/// address — everything BR-DE-2 / BG-6 needs to pass the KoSIT validator).
Business _seller({bool kleinunternehmer = false}) => Business(
  name: 'Acme Gewerbe GmbH',
  isKleinunternehmer: kleinunternehmer,
  vatId: 'DE123456789',
  email: 'kontakt@acme-gewerbe.de',
  phone: '+49 30 1234567',
  address: Address(
    street: 'Hauptstr. 1',
    zip: '10115',
    city: 'Berlin',
    country: Country.deu,
  ),
);

/// Payment settings (BG-16): IBAN, BIC and account holder.
BusinessSettings _settings() => BusinessSettings(
  businessId: 1,
  iban: 'DE02120300000000202051',
  bic: 'BYLADEM1001',
  accountHolder: 'Acme Gewerbe GmbH',
);

/// The buyer: populated with email (BT-49) and buyer reference (BT-10).
Customer _buyer() => Customer(
  businessId: 1,
  name: 'Max Mustermann',
  companyName: 'Mustermann Werkstatt',
  vatId: 'DE987654321',
  email: 'max@mustermann-werkstatt.de',
  buyerReference: '04011000-12345-34',
  address: Address(
    street: 'Musterweg 2',
    zip: '50667',
    city: 'Köln',
    country: Country.deu,
  ),
);

Invoice _invoice({
  InvoiceType type = InvoiceType.invoice,
  int subtotal = 15000,
  int vat = 2850,
}) => Invoice(
  id: 1,
  businessId: 1,
  number: 'RE-2026-0001',
  type: type,
  status: InvoiceStatus.sent,
  customerId: 1,
  issueDate: DateTime(2026, 9, 15, 10, 30),
  dueDate: DateTime(2026, 9, 29),
  currency: Currency.eur,
  subtotalCents: subtotal,
  vatTotalCents: vat,
  totalCents: subtotal + vat,
);

InvoiceItem _item(
  int position,
  String description,
  int unitPrice,
  int lineTotal,
  VatRate rate,
) => InvoiceItem(
  invoiceId: 1,
  position: position,
  description: description,
  quantity: 1,
  unit: InvoiceItemUnit.piece,
  unitPriceCents: unitPrice,
  vatRate: rate,
  lineTotalCents: lineTotal,
);

/// Builds the six golden fixture cases and serializes each with
/// [XrechnungSerializer], keyed by fixture base name (file names are
/// `<key>.xml` under `test/fixtures/xrechnung/`).
///
/// * `standard`         — 19% VAT (BR-15/16/17)
/// * `reduced`          — 7% reduced rate (BR-18/19/20)
/// * `zero`             — zero-rated export to a third country (BR-Z-*)
/// * `reverse_charge`   — VAT shift to the buyer, §13b UStG (BR-AE-*)
/// * `kleinunternehmer` — §19 UStG exemption (BR-DE-19, VATEX-EU-132)
/// * `credit_note`      — Gutschrift, type 381, with original-invoice
///   reference (amounts positive per Peppol BIS 3.0 §5.6.1 / BR-27)
Map<String, String> buildXrechnungFixtures() => {
  'standard': serializer.serialize(
    invoice: _invoice(),
    items: [_item(1, 'Webdesign', 15000, 15000, VatRate.standard)],
    business: _seller(),
    customer: _buyer(),
    settings: _settings(),
  ),
  'reduced': serializer.serialize(
    invoice: _invoice(subtotal: 10000, vat: 700),
    items: [_item(1, 'Lektorat', 10000, 10000, VatRate.reduced)],
    business: _seller(),
    customer: _buyer(),
    settings: _settings(),
  ),
  'zero': serializer.serialize(
    invoice: _invoice(subtotal: 5000, vat: 0),
    items: [_item(1, 'Drittland', 5000, 5000, VatRate.zero)],
    business: _seller(),
    customer: _buyer(),
    settings: _settings(),
  ),
  'reverse_charge': serializer.serialize(
    invoice: _invoice(subtotal: 5000, vat: 0),
    items: [_item(1, 'EU-Leistung', 5000, 5000, VatRate.reverseCharge)],
    business: _seller(),
    customer: _buyer(),
    settings: _settings(),
  ),
  'kleinunternehmer': serializer.serialize(
    invoice: _invoice(subtotal: 10000, vat: 0),
    items: [_item(1, 'Beratung', 10000, 10000, VatRate.standard)],
    business: _seller(kleinunternehmer: true),
    customer: _buyer(),
    settings: _settings(),
  ),
  'credit_note': serializer.serialize(
    invoice: _invoice(
      type: InvoiceType.creditNote,
      subtotal: -15000,
      vat: -2850,
    ),
    items: [_item(1, 'Webdesign', -15000, -15000, VatRate.standard)],
    business: _seller(),
    customer: _buyer(),
    settings: _settings(),
    originalInvoiceNumber: 'RE-2026-0001',
  ),
};
