import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/invoice_credit_note_mapper.dart';
import 'package:test/test.dart';

void main() {
  Invoice original() => Invoice(
    id: 7,
    businessId: 1,
    number: 'RE-2026-0007',
    type: InvoiceType.invoice,
    status: InvoiceStatus.sent,
    customerId: 3,
    issueDate: DateTime(2026, 7, 1),
    dueDate: DateTime(2026, 7, 15),
    serviceDateFrom: DateTime(2026, 6, 1),
    serviceDateTo: DateTime(2026, 6, 30),
    locale: Locale.de,
    currency: Currency.eur,
    subtotalCents: 15000,
    vatTotalCents: 2850,
    totalCents: 17850,
    paymentTermsDays: 14,
    notes: 'Original notes',
    templateId: 9,
  );

  List<InvoiceItem> originalItems() => [
    InvoiceItem(
      invoiceId: 7,
      position: 0,
      description: 'Beratung',
      quantity: 2,
      unit: InvoiceItemUnit.hour,
      unitPriceCents: 5000,
      vatRate: VatRate.standard,
      lineTotalCents: 10000,
    ),
    InvoiceItem(
      invoiceId: 7,
      position: 1,
      description: 'Lektorat',
      quantity: 1,
      unit: InvoiceItemUnit.piece,
      unitPriceCents: 5000,
      vatRate: VatRate.reduced,
      lineTotalCents: 5000,
    ),
  ];

  test('draft reverses stored totals exactly and keeps the original link', () {
    final credit = InvoiceCreditNoteMapper.draft(
      original: original(),
      number: 'RE-2026-0008',
      issueDate: DateTime(2026, 8, 1),
      reason: '  Doppelte Berechnung  ',
    );

    expect(credit.type, InvoiceType.creditNote);
    expect(credit.status, InvoiceStatus.draft);
    expect(credit.originalInvoiceId, 7);
    expect(credit.customerId, 3);
    expect(credit.number, 'RE-2026-0008');
    expect(credit.subtotalCents, -15000);
    expect(credit.vatTotalCents, -2850);
    expect(credit.totalCents, -17850);
    expect(credit.paymentTermsDays, 0);
    expect(credit.dueDate, isNull);
    expect(credit.recurrenceInterval, isNull);
    expect(credit.pdfDocumentId, isNull);
    expect(credit.templateId, 9);
    expect(credit.serviceDateFrom, DateTime(2026, 6, 1));
    expect(credit.serviceDateTo, DateTime(2026, 6, 30));
    expect(credit.notes, 'Doppelte Berechnung');
  });

  test('items preserve description, unit, quantity and VAT rate', () {
    final items = InvoiceCreditNoteMapper.items(
      originalItems: originalItems(),
      invoiceId: 8,
    );

    expect(items, hasLength(2));
    expect(items[0].invoiceId, 8);
    expect(items[0].position, 0);
    expect(items[0].description, 'Beratung');
    expect(items[0].quantity, 2);
    expect(items[0].unit, InvoiceItemUnit.hour);
    expect(items[0].unitPriceCents, -5000);
    expect(items[0].lineTotalCents, -10000);
    expect(items[0].vatRate, VatRate.standard);
    expect(items[1].vatRate, VatRate.reduced);
    expect(items[1].lineTotalCents, -5000);
  });

  test(
    'reversal is exact even when the current business is Kleinunternehmer',
    () {
      // The mapper has no access to the business/tax engine at all: it reverses
      // the persisted VAT of the original regardless of today's §19 status.
      final credit = InvoiceCreditNoteMapper.draft(
        original: original(),
        number: 'RE-2026-0009',
        issueDate: DateTime(2026, 8, 2),
      );

      expect(credit.vatTotalCents, -2850);
    },
  );

  test('rejects a malformed original with already negative totals', () {
    final malformed = original().copyWith(subtotalCents: -1);

    expect(
      () => InvoiceCreditNoteMapper.draft(
        original: malformed,
        number: 'RE-2026-0010',
        issueDate: DateTime(2026, 8, 3),
      ),
      throwsA(isA<ConflictException>()),
    );
  });

  test('rejects malformed negative line values', () {
    final items = originalItems();
    items[0] = items[0].copyWith(lineTotalCents: -100);

    expect(
      () => InvoiceCreditNoteMapper.items(
        originalItems: items,
        invoiceId: 8,
      ),
      throwsA(isA<ConflictException>()),
    );
  });
}
