import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/xrechnung_serializer.dart';
import 'package:test/test.dart';

void main() {
  const serializer = XrechnungSerializer();

  Business seller({bool kleinunternehmer = false}) => Business(
    name: 'Acme Gewerbe GmbH',
    isKleinunternehmer: kleinunternehmer,
    vatId: 'DE123456789',
    address: Address(
      street: 'Hauptstr. 1',
      zip: '10115',
      city: 'Berlin',
      country: Country.deu,
    ),
  );

  Customer buyer() => Customer(
    businessId: 1,
    name: 'Max Mustermann',
    companyName: 'Mustermann Werkstatt',
    vatId: 'DE987654321',
    address: Address(
      street: 'Musterweg 2',
      zip: '50667',
      city: 'Köln',
      country: Country.deu,
    ),
  );

  Invoice invoice({
    InvoiceType type = InvoiceType.invoice,
    bool kleinunternehmer = false,
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
    subtotalCents: kleinunternehmer ? 10000 : 15000,
    vatTotalCents: kleinunternehmer ? 0 : 2250,
    totalCents: kleinunternehmer ? 10000 : 17250,
  );

  List<InvoiceItem> standardItems() => [
    InvoiceItem(
      invoiceId: 1,
      position: 1,
      description: 'Webdesign',
      quantity: 2,
      unit: InvoiceItemUnit.piece,
      unitPriceCents: 5000,
      vatRate: VatRate.standard,
      lineTotalCents: 10000,
    ),
    InvoiceItem(
      invoiceId: 1,
      position: 2,
      description: 'Lektorat',
      quantity: 1,
      unit: InvoiceItemUnit.hour,
      unitPriceCents: 5000,
      vatRate: VatRate.reduced,
      lineTotalCents: 5000,
    ),
  ];

  Invoice creditNote() => Invoice(
    id: 2,
    businessId: 1,
    number: 'RE-2026-0002',
    type: InvoiceType.creditNote,
    status: InvoiceStatus.sent,
    customerId: 1,
    originalInvoiceId: 1,
    issueDate: DateTime(2026, 9, 20),
    currency: Currency.eur,
    subtotalCents: -15000,
    vatTotalCents: -2250,
    totalCents: -17250,
  );

  List<InvoiceItem> creditItems() => [
    InvoiceItem(
      invoiceId: 2,
      position: 1,
      description: 'Webdesign',
      quantity: 2,
      unit: InvoiceItemUnit.piece,
      unitPriceCents: -5000,
      vatRate: VatRate.standard,
      lineTotalCents: -10000,
    ),
    InvoiceItem(
      invoiceId: 2,
      position: 2,
      description: 'Lektorat',
      quantity: 1,
      unit: InvoiceItemUnit.hour,
      unitPriceCents: -5000,
      vatRate: VatRate.reduced,
      lineTotalCents: -5000,
    ),
  ];

  group('document structure', () {
    test('emits the CII root with EN 16931 namespaces and guideline', () {
      final xml = serializer.serialize(
        invoice: invoice(),
        items: standardItems(),
        business: seller(),
        customer: buyer(),
      );

      expect(
        xml,
        contains(
          'xmlns:rsm="urn:un:unece:uncefact:data:standard:CrossIndustryInvoice:100"',
        ),
      );
      expect(
        xml,
        contains(
          'xmlns:ram="urn:un:unece:uncefact:data:standard:ReusableAggregateBusinessInformationEntity:100"',
        ),
      );
      expect(xml, contains('<ram:ID>urn:cen.eu:en16931:2017</ram:ID>'));
    });

    test('uses type code 380 for an invoice and formats the issue date', () {
      final xml = serializer.serialize(
        invoice: invoice(),
        items: standardItems(),
        business: seller(),
        customer: buyer(),
      );

      expect(xml, contains('<ram:TypeCode>380</ram:TypeCode>'));
      expect(
        xml,
        contains(
          '<udt:DateTimeString format="102">20260915</udt:DateTimeString>',
        ),
      );
    });

    test('uses type code 381 for a credit note', () {
      final xml = serializer.serialize(
        invoice: invoice(type: InvoiceType.creditNote),
        items: standardItems(),
        business: seller(),
        customer: buyer(),
      );

      expect(xml, contains('<ram:TypeCode>381</ram:TypeCode>'));
    });

    test('credit note references the original and negates all amounts', () {
      final xml = serializer.serialize(
        invoice: creditNote(),
        items: creditItems(),
        business: seller(),
        customer: buyer(),
        originalInvoiceNumber: 'RE-2026-0001',
      );

      expect(xml, contains('<ram:TypeCode>381</ram:TypeCode>'));
      expect(xml, contains('<ram:InvoiceReferencedDocument>'));
      expect(
        xml,
        contains('<ram:ID>RE-2026-0001</ram:ID>'),
      );
      expect(xml, contains('<ram:ChargeAmount>-50.00</ram:ChargeAmount>'));
      expect(
        xml,
        contains(
          '<ram:BilledQuantity unitCode="C62">2</ram:BilledQuantity>',
        ),
      );
      expect(
        xml,
        contains('<ram:LineTotalAmount>-150.00</ram:LineTotalAmount>'),
      );
      expect(
        xml,
        contains(
          '<ram:TaxTotalAmount currencyID="EUR">-22.50</ram:TaxTotalAmount>',
        ),
      );
      expect(
        xml,
        contains('<ram:GrandTotalAmount>-172.50</ram:GrandTotalAmount>'),
      );
      expect(
        xml,
        contains('<ram:DuePayableAmount>-172.50</ram:DuePayableAmount>'),
      );
    });

    test(
      'credit note keeps stored VAT even if business is now Kleinunternehmer',
      () {
        final xml = serializer.serialize(
          invoice: creditNote(),
          items: creditItems(),
          business: seller(kleinunternehmer: true),
          customer: buyer(),
          originalInvoiceNumber: 'RE-2026-0001',
        );

        expect(xml, contains('<ram:CategoryCode>S</ram:CategoryCode>'));
        expect(
          xml,
          contains(
            '<ram:RateApplicablePercent>19.00</ram:RateApplicablePercent>',
          ),
        );
        expect(xml, isNot(contains('<ram:CategoryCode>E</ram:CategoryCode>')));
      },
    );
  });

  group('trade parties', () {
    test('renders seller and buyer with addresses and VAT ids', () {
      final xml = serializer.serialize(
        invoice: invoice(),
        items: standardItems(),
        business: seller(),
        customer: buyer(),
      );

      expect(xml, contains('<ram:SellerTradeParty>'));
      expect(xml, contains('<ram:Name>Acme Gewerbe GmbH</ram:Name>'));
      expect(xml, contains('<ram:ID schemeID="VA">DE123456789</ram:ID>'));
      expect(xml, contains('<ram:BuyerTradeParty>'));
      expect(xml, contains('<ram:Name>Mustermann Werkstatt</ram:Name>'));
      expect(xml, contains('<ram:PostcodeCode>10115</ram:PostcodeCode>'));
      expect(xml, contains('<ram:CountryID>DE</ram:CountryID>'));
    });
  });

  group('VAT breakdown and totals', () {
    test('produces one tax category per rate and self-consistent totals', () {
      final xml = serializer.serialize(
        invoice: invoice(),
        items: standardItems(),
        business: seller(),
        customer: buyer(),
      );

      // Two rates (19% and 7%) -> two header tax breakdowns.
      expect(
        'S'.allMatches(xml).length,
        greaterThanOrEqualTo(2),
      );
      expect(
        xml,
        contains(
          '<ram:RateApplicablePercent>19.00</ram:RateApplicablePercent>',
        ),
      );
      expect(
        xml,
        contains('<ram:RateApplicablePercent>7.00</ram:RateApplicablePercent>'),
      );

      // 150.00 net + 22.50 VAT = 172.50 gross.
      expect(
        xml,
        contains('<ram:LineTotalAmount>150.00</ram:LineTotalAmount>'),
      );
      expect(
        xml,
        contains('<ram:TaxBasisTotalAmount>150.00</ram:TaxBasisTotalAmount>'),
      );
      expect(
        xml,
        contains(
          '<ram:TaxTotalAmount currencyID="EUR">22.50</ram:TaxTotalAmount>',
        ),
      );
      expect(
        xml,
        contains('<ram:GrandTotalAmount>172.50</ram:GrandTotalAmount>'),
      );
      expect(
        xml,
        contains('<ram:DuePayableAmount>172.50</ram:DuePayableAmount>'),
      );
    });

    test('renders line items with quantities, prices and line totals', () {
      final xml = serializer.serialize(
        invoice: invoice(),
        items: standardItems(),
        business: seller(),
        customer: buyer(),
      );

      expect(xml, contains('<ram:LineID>1</ram:LineID>'));
      expect(xml, contains('<ram:Name>Webdesign</ram:Name>'));
      expect(xml, contains('<ram:ChargeAmount>50.00</ram:ChargeAmount>'));
      expect(
        xml,
        contains('<ram:BilledQuantity unitCode="C62">2</ram:BilledQuantity>'),
      );
    });
  });

  group('Kleinunternehmer §19 UStG', () {
    test('uses category E, zero rate and the exemption reason/code', () {
      final xml = serializer.serialize(
        invoice: invoice(kleinunternehmer: true),
        items: [
          InvoiceItem(
            invoiceId: 1,
            position: 1,
            description: 'Beratung',
            quantity: 1,
            unit: InvoiceItemUnit.hour,
            unitPriceCents: 10000,
            vatRate: VatRate.standard,
            lineTotalCents: 10000,
          ),
        ],
        business: seller(kleinunternehmer: true),
        customer: buyer(),
      );

      expect(xml, contains('<ram:CategoryCode>E</ram:CategoryCode>'));
      expect(
        xml,
        contains('<ram:RateApplicablePercent>0.00</ram:RateApplicablePercent>'),
      );
      expect(
        xml,
        contains(
          '<ram:ExemptionReason>Gemäß § 19 UStG wird keine Umsatzsteuer berechnet.</ram:ExemptionReason>',
        ),
      );
      expect(
        xml,
        contains(
          '<ram:ExemptionReasonCode>VATEX-EU-132</ram:ExemptionReasonCode>',
        ),
      );
      expect(
        xml,
        contains('<ram:GrandTotalAmount>100.00</ram:GrandTotalAmount>'),
      );
      expect(
        xml,
        contains(
          '<ram:TaxTotalAmount currencyID="EUR">0.00</ram:TaxTotalAmount>',
        ),
      );

      // Line-level VAT must be overridden to exempt too: the stored item rate
      // is `standard`, but §19 forbids showing VAT on any line.
      expect(xml, isNot(contains('<ram:CategoryCode>S</ram:CategoryCode>')));
      expect(
        xml,
        isNot(
          contains(
            '<ram:RateApplicablePercent>19.00</ram:RateApplicablePercent>',
          ),
        ),
      );
    });
  });

  group('escaping', () {
    test('escapes XML metacharacters in text content', () {
      final xml = serializer.serialize(
        invoice: invoice(),
        items: [
          InvoiceItem(
            invoiceId: 1,
            position: 1,
            description: 'Plan & Design <final>',
            quantity: 1,
            unit: InvoiceItemUnit.other,
            unitPriceCents: 100,
            vatRate: VatRate.standard,
            lineTotalCents: 100,
          ),
        ],
        business: seller(),
        customer: buyer(),
      );

      expect(
        xml,
        contains('<ram:Name>Plan &amp; Design &lt;final&gt;</ram:Name>'),
      );
      expect(xml, isNot(contains('<final>')));
    });
  });
}
