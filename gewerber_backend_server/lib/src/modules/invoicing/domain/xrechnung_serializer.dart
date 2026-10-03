import '../../../generated/protocol.dart';

/// Serializes an invoice (with its line items, the seller [Business] and the
/// buyer [Customer]) into an XRechnung 3.0.2 document — the German CIUS of
/// EN 16931 in CII D16B (`CrossIndustryInvoice`) syntax.
///
/// "Valid" is concrete here: the emitted document matches the XRechnung
/// scenario of the official KoSIT validator (1.6.3) against the XRechnung
/// 3.0.2 validator configuration release `v2026-08-31`
/// (`itplr-kosit/validator-configuration-xrechnung`), CII scenario
/// "EN16931 XRechnung (CII)". The committed fixtures under
/// `test/fixtures/xrechnung/` are run through `tool/validate_xrechnung.sh`
/// by the `xrechnung-validation` CI job.
///
/// Deliberate omissions: no document-level or line-level allowances/charges
/// are emitted (so `TaxBasisTotalAmount` equals `LineTotalAmount`), and the
/// payment means is hardcoded to code 58 (SEPA credit transfer) because no
/// payment-means field exists yet. Mandatory XRechnung fields are enforced
/// upstream by `XrechnungExportUseCase`, which fails fast listing what is
/// missing instead of letting an invalid document be emitted.
///
/// Pure function: no session, no I/O — unit-testable in isolation.
class XrechnungSerializer {
  const XrechnungSerializer();

  /// XRechnung 3.0.2 CII guideline identifier. The `#compliant#urn:xeinkauf.de:kosit:xrechnung_3.0`
  /// suffix is mandatory: the `kosit:` infix is what marks the document as
  /// XRechnung 3.0.2. Without it the document validates as plain EN 16931,
  /// not as XRechnung.
  static const String _guideline =
      'urn:cen.eu:en16931:2017#compliant#urn:xeinkauf.de:kosit:xrechnung_3.0';

  /// Maps a closed VAT rate to the EN 16931 category code.
  String _categoryCode(VatRate rate) {
    return switch (rate) {
      VatRate.standard || VatRate.reduced => 'S',
      VatRate.zero => 'Z',
      VatRate.reverseCharge => 'AE',
      VatRate.none => 'E',
    };
  }

  /// VAT rate as a percent integer (0 for none/zero/reverse-charge).
  int _percent(VatRate rate) {
    return switch (rate) {
      VatRate.standard => 19,
      VatRate.reduced => 7,
      VatRate.none || VatRate.zero || VatRate.reverseCharge => 0,
    };
  }

  /// UN/ECE Rec 20 unit code for the invoice line's unit.
  String _unitCode(InvoiceItemUnit unit) {
    return switch (unit) {
      InvoiceItemUnit.piece => 'C62',
      InvoiceItemUnit.hour => 'HUR',
      InvoiceItemUnit.day => 'DAY',
      InvoiceItemUnit.month => 'MON',
      InvoiceItemUnit.project || InvoiceItemUnit.other => 'C62',
    };
  }

  /// ISO 3166-1 alpha-2 code for the address country (alpha-3 enum value).
  String _countryCode(Country country) {
    switch (country) {
      case Country.deu:
        return 'DE';
      case Country.aut:
        return 'AT';
      case Country.bel:
        return 'BE';
      case Country.bgr:
        return 'BG';
      case Country.hrv:
        return 'HR';
      case Country.cyp:
        return 'CY';
      case Country.cze:
        return 'CZ';
      case Country.dnk:
        return 'DK';
      case Country.est:
        return 'EE';
      case Country.fin:
        return 'FI';
      case Country.fra:
        return 'FR';
      case Country.grc:
        return 'GR';
      case Country.hun:
        return 'HU';
      case Country.irl:
        return 'IE';
      case Country.ita:
        return 'IT';
      case Country.lva:
        return 'LV';
      case Country.ltu:
        return 'LT';
      case Country.lux:
        return 'LU';
      case Country.mlt:
        return 'MT';
      case Country.nld:
        return 'NL';
      case Country.pol:
        return 'PL';
      case Country.prt:
        return 'PT';
      case Country.rou:
        return 'RO';
      case Country.svk:
        return 'SK';
      case Country.svn:
        return 'SI';
      case Country.esp:
        return 'ES';
      case Country.swe:
        return 'SE';
      case Country.che:
        return 'CH';
      case Country.gbr:
        return 'GB';
      case Country.nor:
        return 'NO';
      case Country.isl:
        return 'IS';
      case Country.lie:
        return 'LI';
      case Country.usa:
        return 'US';
      case Country.can:
        return 'CA';
      case Country.aus:
        return 'AU';
      case Country.nzl:
        return 'NZ';
      case Country.jpn:
        return 'JP';
      case Country.chn:
        return 'CN';
      case Country.ind:
        return 'IN';
      case Country.tur:
        return 'TR';
      case Country.ukr:
        return 'UA';
      case Country.are:
        return 'AE';
      case Country.sau:
        return 'SA';
      case Country.bra:
        return 'BR';
      case Country.mex:
        return 'MX';
      case Country.zaf:
        return 'ZA';
      case Country.kor:
        return 'KR';
      case Country.sgp:
        return 'SG';
      case Country.isr:
        return 'IL';
    }
  }

  /// ISO 4217 code for the invoice currency.
  String _currencyCode(Currency currency) {
    return switch (currency) {
      Currency.eur => 'EUR',
    };
  }

  /// [settings] supplies the BG-16 payment-account fields (IBAN, BIC,
  /// account holder) for the seller business; the export use case enforces
  /// their presence before calling.
  String serialize({
    required Invoice invoice,
    required List<InvoiceItem> items,
    required Business business,
    Customer? customer,
    BusinessSettings? settings,
    String? originalInvoiceNumber,
  }) {
    final currency = _currencyCode(invoice.currency);
    final isCreditNote = invoice.type == InvoiceType.creditNote;
    final typeCode = isCreditNote ? '381' : '380';
    // A credit note reverses the original's stored VAT. The business's
    // current §19 status must not reclassify those lines.
    final applyKleinunternehmer = !isCreditNote && business.isKleinunternehmer;
    // Credit-note signs: credit notes store the signed inverse of the
    // original's amounts, but Peppol BIS Billing 3.0 §5.6.1 states that "the
    // function of crediting or debiting is controlled merely by the business
    // document type (e.g. 380 or 381) while the representation of the amount,
    // including its sign, is not affected". The document type already conveys
    // the credit direction, so the XML must restate the original's amounts as
    // positive values; negating them too would double-negate. EN 16931 BR-27
    // (BT-146 item net price shall NOT be negative) and BR-28 (BT-147 gross
    // price) are hard validation failures, so every monetary and quantity
    // field is emitted through `_signed`/`_signedQuantity` below. Do not
    // "restore" the negation here — it breaks the KoSIT XRechnung validator.

    final breakdown = _breakdown(
      items: items,
      isKleinunternehmer: applyKleinunternehmer,
      fallbackNetCents: invoice.subtotalCents,
      fallbackTaxCents: invoice.vatTotalCents,
    );
    final lineTotal = breakdown.fold<int>(0, (sum, b) => sum + b.basisCents);
    final taxTotal = breakdown.fold<int>(0, (sum, b) => sum + b.taxCents);
    final grandTotal = lineTotal + taxTotal;

    final w = StringBuffer();
    w.writeln('<?xml version="1.0" encoding="UTF-8"?>');
    w.writeln(
      '<rsm:CrossIndustryInvoice '
      'xmlns:rsm="urn:un:unece:uncefact:data:standard:CrossIndustryInvoice:100" '
      'xmlns:ram="urn:un:unece:uncefact:data:standard:ReusableAggregateBusinessInformationEntity:100" '
      'xmlns:udt="urn:un:unece:uncefact:data:standard:UnqualifiedDataType:100">',
    );

    _writeExchangedDocumentContext(w);
    _writeExchangedDocument(w, invoice.number, typeCode, invoice.issueDate);

    w.writeln('  <rsm:SupplyChainTradeTransaction>');

    for (final item in items) {
      _writeLineItem(
        w,
        item,
        isKleinunternehmer: applyKleinunternehmer,
        isCreditNote: isCreditNote,
      );
    }

    _writeHeaderTradeAgreement(w, business, customer);

    // Mandatory child of the SupplyChainTradeTransaction XSD sequence
    // (IncludedSupplyChainTradeLineItem*, ApplicableHeaderTradeAgreement,
    // ApplicableHeaderTradeDelivery, ApplicableHeaderTradeSettlement).
    w.writeln('    <ram:ApplicableHeaderTradeDelivery/>');

    w.writeln('    <ram:ApplicableHeaderTradeSettlement>');
    w.writeln(
      '      <ram:InvoiceCurrencyCode>$currency</ram:InvoiceCurrencyCode>',
    );
    // BG-16 (BR-DE-1): in the HeaderTradeSettlementType XSD sequence
    // SpecifiedTradeSettlementPaymentMeans sits after the currency codes and
    // before the ApplicableTradeTax elements.
    _writePaymentMeans(w, settings, sellerName: business.name);
    for (final b in breakdown) {
      _writeHeaderTradeTax(w, b, currency, isCreditNote: isCreditNote);
    }
    _writePaymentTerms(w, invoice.dueDate, invoice.paymentTermsDays);
    _writeMonetarySummation(
      w,
      currency: currency,
      lineTotal: lineTotal,
      taxTotal: taxTotal,
      grandTotal: grandTotal,
      isCreditNote: isCreditNote,
    );
    _writeInvoiceReferencedDocument(w, originalInvoiceNumber);
    w.writeln('    </ram:ApplicableHeaderTradeSettlement>');

    w.writeln('  </rsm:SupplyChainTradeTransaction>');
    w.writeln('</rsm:CrossIndustryInvoice>');

    return w.toString();
  }

  // --- document header -------------------------------------------------------

  void _writeExchangedDocumentContext(StringBuffer w) {
    w.writeln('  <rsm:ExchangedDocumentContext>');
    // BT-23 business process type (PEPPOL-EN16931-R001): the Peppol BIS
    // Billing 3.0 profile id convention `urn:fdc:peppol.eu:2017:poacc:
    // billing:01:1.0`. In the CII ExchangedDocumentContextType XSD sequence
    // BusinessProcessSpecifiedDocumentContextParameter comes BEFORE
    // GuidelineSpecifiedDocumentContextParameter — do not reorder.
    w.writeln('    <ram:BusinessProcessSpecifiedDocumentContextParameter>');
    w.writeln(
      '      <ram:ID>urn:fdc:peppol.eu:2017:poacc:billing:01:1.0</ram:ID>',
    );
    w.writeln('    </ram:BusinessProcessSpecifiedDocumentContextParameter>');
    w.writeln('    <ram:GuidelineSpecifiedDocumentContextParameter>');
    w.writeln('      <ram:ID>$_guideline</ram:ID>');
    w.writeln('    </ram:GuidelineSpecifiedDocumentContextParameter>');
    w.writeln('  </rsm:ExchangedDocumentContext>');
  }

  void _writeExchangedDocument(
    StringBuffer w,
    String number,
    String typeCode,
    DateTime issueDate,
  ) {
    w.writeln('  <rsm:ExchangedDocument>');
    w.writeln('    <ram:ID>${_escape(number)}</ram:ID>');
    w.writeln('    <ram:TypeCode>$typeCode</ram:TypeCode>');
    w.writeln('    <ram:IssueDateTime>');
    w.writeln(
      '      <udt:DateTimeString format="102">${_formatDate(issueDate)}</udt:DateTimeString>',
    );
    w.writeln('    </ram:IssueDateTime>');
    w.writeln('  </rsm:ExchangedDocument>');
  }

  // --- trade agreement (parties) --------------------------------------------

  void _writeHeaderTradeAgreement(
    StringBuffer w,
    Business business,
    Customer? customer,
  ) {
    w.writeln('    <ram:ApplicableHeaderTradeAgreement>');
    // BT-10 buyer reference / Leitweg-ID (BR-DE-15): in the CII
    // HeaderTradeAgreementType XSD sequence BuyerReference is the first
    // child (Reference?, BuyerReference, SellerTradeParty, ...). Emitted
    // only when present — the export use case enforces it, the serializer
    // stays a pure emit-if-present function.
    if (_nonBlank(customer?.buyerReference)) {
      w.writeln(
        '      <ram:BuyerReference>${_escape(customer!.buyerReference!.trim())}</ram:BuyerReference>',
      );
    }
    // BG-6 seller contact (BR-DE-2) and BT-34 seller electronic address:
    // contactPhone/contactEmail are passed for the seller only.
    _writeTradeParty(
      w,
      'SellerTradeParty',
      business.name,
      business.address,
      business.vatId,
      business.taxNumber,
      electronicMail: business.email,
      contactPhone: business.phone,
      contactEmail: business.email,
    );
    if (customer != null) {
      // BT-49 buyer electronic address.
      _writeTradeParty(
        w,
        'BuyerTradeParty',
        customer.companyName ?? customer.name,
        customer.address,
        customer.vatId,
        null,
        electronicMail: customer.email,
      );
    }
    w.writeln('    </ram:ApplicableHeaderTradeAgreement>');
  }

  /// Emits one trade party. Optional named parameters carry the XRechnung
  /// / Peppol additions: [electronicMail] (BT-34 seller / BT-49 buyer
  /// electronic address) and [contactPhone]/[contactEmail] (BG-6 seller
  /// contact, passed by the caller for the seller only). Child order is
  /// fixed by the CII D16B XSD `TradePartyType` sequence (ID, GlobalID,
  /// Name, RoleCode, Description, SpecifiedLegalOrganization,
  /// DefinedTradeContact, PostalTradeAddress, URIUniversalCommunication,
  /// SpecifiedTaxRegistration) — do not reorder.
  void _writeTradeParty(
    StringBuffer w,
    String element,
    String name,
    Address? address,
    String? vatId,
    String? taxNumber, {
    String? electronicMail,
    String? contactPhone,
    String? contactEmail,
  }) {
    w.writeln('      <ram:$element>');
    w.writeln('        <ram:Name>${_escape(name)}</ram:Name>');
    // BG-6 (BR-DE-2): emitted only when the seller has at least one of
    // phone/email; the empty sub-elements are skipped, never emitted blank.
    final hasContactPhone = _nonBlank(contactPhone);
    final hasContactEmail = _nonBlank(contactEmail);
    if (hasContactPhone || hasContactEmail) {
      w.writeln('        <ram:DefinedTradeContact>');
      w.writeln('          <ram:PersonName>${_escape(name)}</ram:PersonName>');
      if (hasContactPhone) {
        w.writeln('          <ram:TelephoneUniversalCommunication>');
        w.writeln(
          '            <ram:CompleteNumber>${_escape(contactPhone!.trim())}</ram:CompleteNumber>',
        );
        w.writeln('          </ram:TelephoneUniversalCommunication>');
      }
      if (hasContactEmail) {
        w.writeln('          <ram:EmailURIUniversalCommunication>');
        w.writeln(
          '            <ram:URIID>${_escape(contactEmail!.trim())}</ram:URIID>',
        );
        w.writeln('          </ram:EmailURIUniversalCommunication>');
      }
      w.writeln('        </ram:DefinedTradeContact>');
    }
    if (address != null) {
      w.writeln('        <ram:PostalTradeAddress>');
      w.writeln(
        '          <ram:PostcodeCode>${_escape(address.zip)}</ram:PostcodeCode>',
      );
      w.writeln(
        '          <ram:LineOne>${_escape(address.street)}</ram:LineOne>',
      );
      w.writeln(
        '          <ram:CityName>${_escape(address.city)}</ram:CityName>',
      );
      w.writeln(
        '          <ram:CountryID>${_countryCode(address.country)}</ram:CountryID>',
      );
      w.writeln('        </ram:PostalTradeAddress>');
    }
    // BT-34 / BT-49 electronic address (PEPPOL-EN16931-R020 / R010). The
    // EAS code "EM" designates electronic mail (0204 is the Leitweg-ID —
    // a different scheme, not used here).
    if (_nonBlank(electronicMail)) {
      w.writeln('        <ram:URIUniversalCommunication>');
      w.writeln(
        '          <ram:URIID schemeID="EM">${_escape(electronicMail!.trim())}</ram:URIID>',
      );
      w.writeln('        </ram:URIUniversalCommunication>');
    }
    if (vatId != null && vatId.trim().isNotEmpty) {
      w.writeln('        <ram:SpecifiedTaxRegistration>');
      w.writeln(
        '          <ram:ID schemeID="VA">${_escape(vatId.trim())}</ram:ID>',
      );
      w.writeln('        </ram:SpecifiedTaxRegistration>');
    } else if (taxNumber != null && taxNumber.trim().isNotEmpty) {
      w.writeln('        <ram:SpecifiedTaxRegistration>');
      w.writeln(
        '          <ram:ID schemeID="FC">${_escape(taxNumber.trim())}</ram:ID>',
      );
      w.writeln('        </ram:SpecifiedTaxRegistration>');
    }
    w.writeln('      </ram:$element>');
  }

  // --- line items ------------------------------------------------------------

  void _writeLineItem(
    StringBuffer w,
    InvoiceItem item, {
    required bool isKleinunternehmer,
    required bool isCreditNote,
  }) {
    final unitCode = _unitCode(item.unit);
    final quantity = _formatQuantity(
      _signedQuantity(item.quantity, isCreditNote),
    );
    final netPrice = _formatAmount(_signed(item.unitPriceCents, isCreditNote));
    final lineTotal = _formatAmount(_signed(item.lineTotalCents, isCreditNote));
    // Under the Kleinunternehmer rule (§19 UStG) no VAT may be shown on any
    // line, regardless of the stored rate — keep the line-level tax category
    // consistent with the document-level breakdown.
    final effectiveRate = isKleinunternehmer ? VatRate.none : item.vatRate;
    final percent = _percent(effectiveRate);

    w.writeln('    <ram:IncludedSupplyChainTradeLineItem>');
    w.writeln('      <ram:AssociatedDocumentLineDocument>');
    w.writeln('        <ram:LineID>${item.position}</ram:LineID>');
    w.writeln('      </ram:AssociatedDocumentLineDocument>');
    w.writeln('      <ram:SpecifiedTradeProduct>');
    w.writeln('        <ram:Name>${_escape(item.description)}</ram:Name>');
    w.writeln('      </ram:SpecifiedTradeProduct>');
    w.writeln('      <ram:SpecifiedLineTradeAgreement>');
    w.writeln('        <ram:NetPriceProductTradePrice>');
    w.writeln('          <ram:ChargeAmount>$netPrice</ram:ChargeAmount>');
    w.writeln(
      '          <ram:BasisQuantity unitCode="$unitCode">$quantity</ram:BasisQuantity>',
    );
    w.writeln('        </ram:NetPriceProductTradePrice>');
    w.writeln('      </ram:SpecifiedLineTradeAgreement>');
    w.writeln('      <ram:SpecifiedLineTradeDelivery>');
    w.writeln(
      '        <ram:BilledQuantity unitCode="$unitCode">$quantity</ram:BilledQuantity>',
    );
    w.writeln('      </ram:SpecifiedLineTradeDelivery>');
    w.writeln('      <ram:SpecifiedLineTradeSettlement>');
    w.writeln('        <ram:ApplicableTradeTax>');
    w.writeln('          <ram:TypeCode>VAT</ram:TypeCode>');
    w.writeln(
      '          <ram:CategoryCode>${_categoryCode(effectiveRate)}</ram:CategoryCode>',
    );
    w.writeln(
      '          <ram:RateApplicablePercent>${_formatPercent(percent)}</ram:RateApplicablePercent>',
    );
    w.writeln('        </ram:ApplicableTradeTax>');
    w.writeln('        <ram:SpecifiedTradeSettlementLineMonetarySummation>');
    w.writeln(
      '          <ram:LineTotalAmount>$lineTotal</ram:LineTotalAmount>',
    );
    w.writeln('        </ram:SpecifiedTradeSettlementLineMonetarySummation>');
    w.writeln('      </ram:SpecifiedLineTradeSettlement>');
    w.writeln('    </ram:IncludedSupplyChainTradeLineItem>');
  }

  // --- header VAT + totals ---------------------------------------------------

  void _writeHeaderTradeTax(
    StringBuffer w,
    _TaxBreakdown b,
    String currency, {
    required bool isCreditNote,
  }) {
    // Child order is fixed by the CII D16B XSD TradeTaxType sequence
    // (CalculatedAmount, TypeCode, ExemptionReason, BasisAmount, CategoryCode,
    // ExemptionReasonCode, RateApplicablePercent) — do not "tidy" it up.
    // BT-120/BT-121: required for exempt (E, §19 UStG) and reverse-charge
    // (AE, BR-AE-10, §13b UStG) categories.
    final exemption = switch (b.category) {
      'E' => (
        reason: 'Gemäß § 19 UStG wird keine Umsatzsteuer berechnet.',
        code: 'VATEX-EU-132',
      ),
      'AE' => (
        reason:
            'Steuerschuldnerschaft des Leistungsempfängers gemäß § 13b UStG.',
        code: 'VATEX-EU-AE',
      ),
      _ => null,
    };
    w.writeln('      <ram:ApplicableTradeTax>');
    w.writeln(
      '        <ram:CalculatedAmount>${_formatAmount(_signed(b.taxCents, isCreditNote))}</ram:CalculatedAmount>',
    );
    w.writeln('        <ram:TypeCode>VAT</ram:TypeCode>');
    if (exemption != null) {
      w.writeln(
        '        <ram:ExemptionReason>${_escape(exemption.reason)}</ram:ExemptionReason>',
      );
    }
    w.writeln(
      '        <ram:BasisAmount>${_formatAmount(_signed(b.basisCents, isCreditNote))}</ram:BasisAmount>',
    );
    w.writeln('        <ram:CategoryCode>${b.category}</ram:CategoryCode>');
    if (exemption != null) {
      w.writeln(
        '        <ram:ExemptionReasonCode>${exemption.code}</ram:ExemptionReasonCode>',
      );
    }
    w.writeln(
      '        <ram:RateApplicablePercent>${_formatPercent(b.ratePercent)}</ram:RateApplicablePercent>',
    );
    w.writeln('      </ram:ApplicableTradeTax>');
  }

  /// BG-16 payment instructions (BR-DE-1): BT-81 `TypeCode` is fixed to 58
  /// (SEPA credit transfer — no payment-mean field exists yet); BT-84 IBAN
  /// from [settings], BT-85 account holder falling back to the seller
  /// [sellerName] (always present), optional BT-86 BIC. Child order follows
  /// the CII `TradeSettlementPaymentMeansType` XSD sequence (TypeCode,
  /// PayeePartyCreditorFinancialAccount [IBANID, AccountName],
  /// PayeeSpecifiedCreditorFinancialInstitution [BICID]). Emitted only when
  /// an IBAN is present — the export use case enforces it.
  void _writePaymentMeans(
    StringBuffer w,
    BusinessSettings? settings, {
    required String sellerName,
  }) {
    if (!_nonBlank(settings?.iban)) return;
    final bic = settings!.bic?.trim();
    final accountName = _nonBlank(settings.accountHolder)
        ? settings.accountHolder!.trim()
        : sellerName;
    w.writeln('      <ram:SpecifiedTradeSettlementPaymentMeans>');
    w.writeln('        <ram:TypeCode>58</ram:TypeCode>');
    w.writeln('        <ram:PayeePartyCreditorFinancialAccount>');
    w.writeln(
      '          <ram:IBANID>${_escape(settings.iban!.trim())}</ram:IBANID>',
    );
    w.writeln(
      '          <ram:AccountName>${_escape(accountName)}</ram:AccountName>',
    );
    w.writeln('        </ram:PayeePartyCreditorFinancialAccount>');
    if (bic != null && bic.isNotEmpty) {
      w.writeln('        <ram:PayeeSpecifiedCreditorFinancialInstitution>');
      w.writeln('          <ram:BICID>${_escape(bic)}</ram:BICID>');
      w.writeln('        </ram:PayeeSpecifiedCreditorFinancialInstitution>');
    }
    w.writeln('      </ram:SpecifiedTradeSettlementPaymentMeans>');
  }

  void _writeMonetarySummation(
    StringBuffer w, {
    required String currency,
    required int lineTotal,
    required int taxTotal,
    required int grandTotal,
    required bool isCreditNote,
  }) {
    w.writeln(
      '      <ram:SpecifiedTradeSettlementHeaderMonetarySummation>',
    );
    w.writeln(
      '        <ram:LineTotalAmount>${_formatAmount(_signed(lineTotal, isCreditNote))}</ram:LineTotalAmount>',
    );
    w.writeln(
      '        <ram:TaxBasisTotalAmount>${_formatAmount(_signed(lineTotal, isCreditNote))}</ram:TaxBasisTotalAmount>',
    );
    w.writeln(
      '        <ram:TaxTotalAmount currencyID="$currency">${_formatAmount(_signed(taxTotal, isCreditNote))}</ram:TaxTotalAmount>',
    );
    w.writeln(
      '        <ram:GrandTotalAmount>${_formatAmount(_signed(grandTotal, isCreditNote))}</ram:GrandTotalAmount>',
    );
    w.writeln(
      '        <ram:DuePayableAmount>${_formatAmount(_signed(grandTotal, isCreditNote))}</ram:DuePayableAmount>',
    );
    w.writeln(
      '      </ram:SpecifiedTradeSettlementHeaderMonetarySummation>',
    );
  }

  /// BT-9 (due date) and/or BT-20 (payment terms). BR-CO-25 requires an
  /// invoice to carry a due date or payment terms; a credit note has no
  /// payment obligation of its own, so it states the original's payment terms
  /// instead. The `HeaderTradeSettlementType` XSD sequence places
  /// `SpecifiedTradePaymentTerms` after the `ApplicableTradeTax` elements and
  /// before `SpecifiedTradeSettlementHeaderMonetarySummation`.
  void _writePaymentTerms(StringBuffer w, DateTime? dueDate, int termsDays) {
    if (dueDate == null && termsDays <= 0) return;
    w.writeln('      <ram:SpecifiedTradePaymentTerms>');
    // Child order is fixed by the CII D16B XSD TradePaymentTermsType sequence
    // (ID, FromEventCode, SettlementPeriodMeasure, Description,
    // DueDateDateTime, TypeCode, ...) — Description precedes DueDateDateTime.
    if (termsDays > 0) {
      w.writeln(
        '        <ram:Description>Zahlbar innerhalb von $termsDays Tagen.</ram:Description>',
      );
    }
    if (dueDate != null) {
      w.writeln('        <ram:DueDateDateTime>');
      w.writeln(
        '          <udt:DateTimeString format="102">${_formatDate(dueDate)}</udt:DateTimeString>',
      );
      w.writeln('        </ram:DueDateDateTime>');
    }
    w.writeln('      </ram:SpecifiedTradePaymentTerms>');
  }

  /// Reference to the original invoice (credit notes). In the CII D16B XSD
  /// this element belongs to `HeaderTradeSettlementType`, directly after
  /// `SpecifiedTradeSettlementHeaderMonetarySummation` — not to the trade
  /// agreement, which has no such child.
  void _writeInvoiceReferencedDocument(
    StringBuffer w,
    String? originalInvoiceNumber,
  ) {
    if (originalInvoiceNumber == null || originalInvoiceNumber.trim().isEmpty) {
      return;
    }
    w.writeln('      <ram:InvoiceReferencedDocument>');
    // The CII ReferencedDocumentType XSD has no `ID` child — the identifier
    // element is `IssuerAssignedID` (BT-25 / credit-note original number).
    w.writeln(
      '        <ram:IssuerAssignedID>${_escape(originalInvoiceNumber.trim())}</ram:IssuerAssignedID>',
    );
    w.writeln('      </ram:InvoiceReferencedDocument>');
  }

  // --- VAT breakdown ---------------------------------------------------------

  List<_TaxBreakdown> _breakdown({
    required List<InvoiceItem> items,
    required bool isKleinunternehmer,
    required int fallbackNetCents,
    required int fallbackTaxCents,
  }) {
    if (isKleinunternehmer) {
      final net = items.isEmpty
          ? fallbackNetCents
          : items.fold<int>(0, (sum, i) => sum + i.lineTotalCents);
      return [
        _TaxBreakdown(
          category: 'E',
          ratePercent: 0,
          basisCents: net,
          taxCents: 0,
        ),
      ];
    }

    if (items.isEmpty) {
      final category = fallbackTaxCents != 0 ? 'S' : 'Z';
      final ratePercent = fallbackTaxCents != 0 ? 19 : 0;
      return [
        _TaxBreakdown(
          category: category,
          ratePercent: ratePercent,
          basisCents: fallbackNetCents,
          taxCents: fallbackTaxCents,
        ),
      ];
    }

    final byRate = <VatRate, List<InvoiceItem>>{};
    for (final item in items) {
      byRate.putIfAbsent(item.vatRate, () => []).add(item);
    }

    final result = <_TaxBreakdown>[];
    for (final entry in byRate.entries) {
      final rate = entry.key;
      final percent = _percent(rate);
      var basis = 0;
      var tax = 0;
      for (final item in entry.value) {
        final net = item.lineTotalCents;
        basis += net;
        tax += (net * percent / 100).round();
      }
      result.add(
        _TaxBreakdown(
          category: _categoryCode(rate),
          ratePercent: percent,
          basisCents: basis,
          taxCents: tax,
        ),
      );
    }
    return result;
  }

  // --- formatting helpers ----------------------------------------------------

  /// Sign normaliser for credit notes (see the note in [serialize]).
  ///
  /// Peppol BIS Billing 3.0 §5.6.1: the document type (`381` for a credit
  /// note), not the amount sign, conveys the credit direction. EN 16931
  /// BR-27 / BR-28 additionally forbid negative item prices. Credit notes
  /// therefore restate the original invoice's amounts as positive values.
  ///
  /// A no-op for ordinary invoices, so their output stays byte-identical.
  int _signed(int cents, bool isCreditNote) {
    return isCreditNote ? cents.abs() : cents;
  }

  /// Quantity counterpart of [_signed]: BR-CO-11 / the Peppol amount
  /// representation rule apply to `BasisQuantity` and `BilledQuantity` too,
  /// so a credit note states the original's positive quantity.
  double? _signedQuantity(double? quantity, bool isCreditNote) {
    if (!isCreditNote || quantity == null) return quantity;
    return quantity.abs();
  }

  String _formatDate(DateTime date) {
    final d = date.toLocal();
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y$m$day';
  }

  /// Cents -> decimal with exactly two fraction digits (period separator).
  String _formatAmount(int cents) {
    return (cents / 100).toStringAsFixed(2);
  }

  String _formatPercent(int percent) {
    return percent.toStringAsFixed(2);
  }

  String _formatQuantity(double? quantity) {
    final q = quantity ?? 1;
    if (q == q.roundToDouble()) {
      return q.round().toString();
    }
    // Trim trailing zeros, but never leave a bare trailing separator: the
    // 4-dp form of a value smaller than the 4th decimal (e.g. 1.00001) is
    // "1.0000", which trims to "1." — not a valid xs:decimal, and invalid
    // XML Schema content fails the whole document.
    final trimmed = q.toStringAsFixed(4).replaceFirst(RegExp(r'0+$'), '');
    return trimmed.endsWith('.') ? '${trimmed}0' : trimmed;
  }

  /// True when [value] carries non-blank content. Used to guarantee no XML
  /// element is ever emitted with empty text (skip instead).
  bool _nonBlank(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  String _escape(String value) {
    return value
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&apos;');
  }
}

class _TaxBreakdown {
  const _TaxBreakdown({
    required this.category,
    required this.ratePercent,
    required this.basisCents,
    required this.taxCents,
  });

  final String category;
  final int ratePercent;
  final int basisCents;
  final int taxCents;
}
