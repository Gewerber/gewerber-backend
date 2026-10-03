// Fast behavioural regression net for the XRechnung serializer.
//
// Division of labour: byte-for-byte pinning lives in
// `xrechnung_golden_test.dart` and spec conformance in
// `tool/validate_xrechnung.sh` (KoSIT validator). This file only asserts
// behaviourally (contains / isNot(contains)) that the profile-mandated
// elements are present, so it needs neither the validator nor a database.
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/xrechnung_serializer.dart';
import 'package:test/test.dart';

void main() {
  const serializer = XrechnungSerializer();

  // XRechnung 3.0.2 guideline id (BT-24). The `#compliant#...kosit:` suffix
  // is what makes the document an XRechnung rather than plain EN 16931.
  const guidelineId =
      'urn:cen.eu:en16931:2017#compliant#urn:xeinkauf.de:kosit:xrechnung_3.0';
  // BT-23 business process type (PEPPOL-EN16931-R001).
  const businessProcessId = 'urn:fdc:peppol.eu:2017:poacc:billing:01:1.0';

  /// Fully-populated seller: `email`/`phone` feed BG-6 (BR-DE-2) and
  /// BT-34; without them the export use case would refuse the document.
  Business seller({bool kleinunternehmer = false}) => Business(
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

  /// Buyer with BT-49 electronic address and BT-10 buyer reference
  /// (Leitweg-ID style, mandatory under BR-DE-15).
  Customer buyer() => Customer(
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

  /// BG-16 payment account (BR-DE-1): BT-84 IBAN, BT-86 BIC, BT-85 holder.
  BusinessSettings settings() => BusinessSettings(
    businessId: 1,
    iban: 'DE02120300000000202051',
    bic: 'BYLADEM1001',
    accountHolder: 'Acme Gewerbe GmbH',
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

  /// Serializes a one-line invoice whose only variable is the line
  /// [quantity]; the amounts are placeholders, the quantity formatting is
  /// what the tests assert.
  String invoiceXmlWithQuantity(double quantity) => serializer.serialize(
    invoice: invoice(),
    items: [
      InvoiceItem(
        invoiceId: 1,
        position: 1,
        description: 'Beratung',
        quantity: quantity,
        unit: InvoiceItemUnit.hour,
        unitPriceCents: 100,
        vatRate: VatRate.standard,
        lineTotalCents: 100,
      ),
    ],
    business: seller(),
    customer: buyer(),
  );

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
      // XRechnung 3.0.2: the plain `urn:cen.eu:en16931:2017` id would
      // validate as generic EN 16931, not as XRechnung.
      expect(xml, contains('<ram:ID>$guidelineId</ram:ID>'));
      // BT-23 business process type (PEPPOL-EN16931-R001).
      expect(
        xml,
        contains('<ram:BusinessProcessSpecifiedDocumentContextParameter>'),
      );
      expect(xml, contains('<ram:ID>$businessProcessId</ram:ID>'));
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

    test('emits the mandatory delivery section and the due date', () {
      final xml = serializer.serialize(
        invoice: invoice(),
        items: standardItems(),
        business: seller(),
        customer: buyer(),
      );

      // `ApplicableHeaderTradeDelivery` is a required child of the CII
      // SupplyChainTradeTransaction XSD sequence; the delivery model has no
      // data yet, so it stays an empty element.
      expect(xml, contains('<ram:ApplicableHeaderTradeDelivery/>'));
      // BT-9: the invoice's due date is rendered as payment terms (BR-CO-25).
      expect(xml, contains('<ram:SpecifiedTradePaymentTerms>'));
      expect(xml, contains('<ram:DueDateDateTime>'));
      expect(
        xml,
        contains(
          '<udt:DateTimeString format="102">20260929</udt:DateTimeString>',
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

    // Peppol BIS Billing 3.0 §5.6.1: the document type (381), not the amount
    // sign, conveys the credit — and EN 16931 BR-27/BR-28 forbid negative
    // item prices. The serializer therefore restates the stored (negative)
    // credit amounts as positive. The original reference is `IssuerAssignedID`
    // because the CII ReferencedDocumentType XSD has no `ID` child.
    test(
      'credit note references the original and restates amounts positive',
      () {
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
          contains('<ram:IssuerAssignedID>RE-2026-0001</ram:IssuerAssignedID>'),
        );
        expect(xml, contains('<ram:ChargeAmount>50.00</ram:ChargeAmount>'));
        expect(
          xml,
          contains('<ram:BilledQuantity unitCode="C62">2</ram:BilledQuantity>'),
        );
        expect(
          xml,
          contains('<ram:LineTotalAmount>150.00</ram:LineTotalAmount>'),
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
        // No element text anywhere carries a minus sign (BR-27 / BR-28 safe).
        expect(xml, isNot(contains('>-')));
      },
    );

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

    test('emits BT-10 reference, BT-34/BT-49 addresses, BG-6 contact', () {
      final xml = serializer.serialize(
        invoice: invoice(),
        items: standardItems(),
        business: seller(),
        customer: buyer(),
      );

      // BT-10 buyer reference / Leitweg-ID (BR-DE-15).
      expect(
        xml,
        contains('<ram:BuyerReference>04011000-12345-34</ram:BuyerReference>'),
      );
      // BT-34 / BT-49 electronic addresses (PEPPOL-EN16931-R020 / R010);
      // EAS code "EM" designates electronic mail.
      expect(
        xml,
        contains(
          '<ram:URIID schemeID="EM">kontakt@acme-gewerbe.de</ram:URIID>',
        ),
      );
      expect(
        xml,
        contains(
          '<ram:URIID schemeID="EM">max@mustermann-werkstatt.de</ram:URIID>',
        ),
      );
      // BG-6 seller contact (BR-DE-2): phone and e-mail, never blank fields.
      expect(xml, contains('<ram:DefinedTradeContact>'));
      expect(
        xml,
        contains('<ram:CompleteNumber>+49 30 1234567</ram:CompleteNumber>'),
      );
      expect(xml, contains('<ram:EmailURIUniversalCommunication>'));
      expect(
        xml,
        contains('<ram:URIID>kontakt@acme-gewerbe.de</ram:URIID>'),
      );
    });
  });

  group('payment means (BG-16)', () {
    test('emits type code 58 with the IBAN, holder and BIC', () {
      final xml = serializer.serialize(
        invoice: invoice(),
        items: standardItems(),
        business: seller(),
        customer: buyer(),
        settings: settings(),
      );

      // BT-81 is fixed to 58 (SEPA credit transfer); BT-84 IBAN, BT-85
      // account holder, BT-86 BIC come from the business settings (BR-DE-1).
      expect(xml, contains('<ram:SpecifiedTradeSettlementPaymentMeans>'));
      expect(xml, contains('<ram:TypeCode>58</ram:TypeCode>'));
      expect(
        xml,
        contains('<ram:IBANID>DE02120300000000202051</ram:IBANID>'),
      );
      expect(
        xml,
        contains('<ram:AccountName>Acme Gewerbe GmbH</ram:AccountName>'),
      );
      expect(xml, contains('<ram:BICID>BYLADEM1001</ram:BICID>'));
    });

    test('omits BG-16 when no payment settings are given', () {
      // Emit-if-present stays the serializer's contract; the export use case
      // is what enforces presence before calling.
      final xml = serializer.serialize(
        invoice: invoice(),
        items: standardItems(),
        business: seller(),
        customer: buyer(),
      );

      expect(
        xml,
        isNot(contains('<ram:SpecifiedTradeSettlementPaymentMeans>')),
      );
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

  // `_formatQuantity` renders both `ram:BasisQuantity` and
  // `ram:BilledQuantity` of every line. Regression net for the bare-
  // separator bug: trimming trailing zeros from the 4-dp form of a value
  // below the 4th decimal (e.g. 1.00001 → "1.0000" → "1.") emitted text
  // that is not a valid `xs:decimal`, failing XSD validation of the whole
  // document. Earlier fixtures all used integer quantities, so the
  // fractional branch was uncovered.
  group('quantity formatting', () {
    /// Guards against the invalid form reappearing: no element text may
    /// start with the separator, and every quantity element's text must be
    /// a valid `xs:decimal` — in particular never the bare separator form
    /// (`1.` / `0.`) the pre-fix trimming produced. (A generic `.</`
    /// document check is not possible: legitimate sentences such as the
    /// payment-terms description end with a full stop.)
    void expectValidQuantityDecimals(String xml) {
      // A raw `>` only ever appears at tag boundaries (text is escaped),
      // so `>.` would mean some element's text starts with the separator.
      expect(xml, isNot(contains('>.')));
      final quantities = RegExp(
        r'<ram:(?:Billed|Basis)Quantity unitCode="[^"]*">([^<]*)</ram:',
      ).allMatches(xml).map((m) => m.group(1)!).toList();
      // One BasisQuantity and one BilledQuantity per line.
      expect(quantities, hasLength(2));
      for (final quantity in quantities) {
        expect(
          quantity,
          matches(RegExp(r'^[+-]?(?:0|[1-9]\d*)(?:\.\d+)?$')),
          reason: 'quantity text "$quantity" is not a valid xs:decimal',
        );
      }
    }

    test(
      'emits ordinary fractional quantities with trailing zeros trimmed',
      () {
        final xml = invoiceXmlWithQuantity(1.5);
        expect(
          xml,
          contains(
            '<ram:BilledQuantity unitCode="HUR">1.5</ram:BilledQuantity>',
          ),
        );
        expect(
          xml,
          contains('<ram:BasisQuantity unitCode="HUR">1.5</ram:BasisQuantity>'),
        );

        final quarter = invoiceXmlWithQuantity(0.25);
        expect(
          quarter,
          contains(
            '<ram:BilledQuantity unitCode="HUR">0.25</ram:BilledQuantity>',
          ),
        );
        expect(
          quarter,
          contains(
            '<ram:BasisQuantity unitCode="HUR">0.25</ram:BasisQuantity>',
          ),
        );
        expectValidQuantityDecimals(quarter);
      },
    );

    test('sub-4th-decimal quantity 1.00001 emits 1.0, never a bare "1."', () {
      final xml = invoiceXmlWithQuantity(1.00001);
      expect(
        xml,
        contains('<ram:BilledQuantity unitCode="HUR">1.0</ram:BilledQuantity>'),
      );
      expect(
        xml,
        contains('<ram:BasisQuantity unitCode="HUR">1.0</ram:BasisQuantity>'),
      );
      // The pre-fix output was `>1.</ram:...` — pin that it cannot return.
      expect(xml, isNot(contains('1.</ram:')));
      expectValidQuantityDecimals(xml);
    });

    test('sub-unit quantity 0.00001 emits 0.0, never a bare "0."', () {
      final xml = invoiceXmlWithQuantity(0.00001);
      expect(
        xml,
        contains('<ram:BilledQuantity unitCode="HUR">0.0</ram:BilledQuantity>'),
      );
      expect(
        xml,
        contains('<ram:BasisQuantity unitCode="HUR">0.0</ram:BasisQuantity>'),
      );
      expect(xml, isNot(contains('0.</ram:')));
      expectValidQuantityDecimals(xml);
    });

    test('integral quantities emit without a decimal point', () {
      final xml = invoiceXmlWithQuantity(2.0);
      expect(
        xml,
        contains('<ram:BilledQuantity unitCode="HUR">2</ram:BilledQuantity>'),
      );
      expect(
        xml,
        contains('<ram:BasisQuantity unitCode="HUR">2</ram:BasisQuantity>'),
      );
      expect(xml, isNot(contains('2.</ram:')));
    });

    test('quantities are rounded to four decimal places', () {
      final xml = invoiceXmlWithQuantity(3.14159);
      expect(
        xml,
        contains(
          '<ram:BilledQuantity unitCode="HUR">3.1416</ram:BilledQuantity>',
        ),
      );
      expect(
        xml,
        contains(
          '<ram:BasisQuantity unitCode="HUR">3.1416</ram:BasisQuantity>',
        ),
      );
      expectValidQuantityDecimals(xml);
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
      // CII TradeTaxType XSD sequence: ExemptionReason comes before
      // BasisAmount/CategoryCode, ExemptionReasonCode right after
      // CategoryCode — the KoSIT validator rejects any other order. The
      // line-level tax has no exemption fields, so the header breakdown's
      // elements are the last occurrences in the document.
      final exemptionReason = xml.lastIndexOf('<ram:ExemptionReason>');
      final category = xml.lastIndexOf(
        '<ram:CategoryCode>E</ram:CategoryCode>',
      );
      final exemptionCode = xml.lastIndexOf(
        '<ram:ExemptionReasonCode>VATEX-EU-132</ram:ExemptionReasonCode>',
      );
      expect(exemptionReason, greaterThanOrEqualTo(0));
      expect(exemptionReason, lessThan(category));
      expect(category, lessThan(exemptionCode));

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
