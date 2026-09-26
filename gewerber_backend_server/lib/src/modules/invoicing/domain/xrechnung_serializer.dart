import '../../../generated/protocol.dart';

/// Serializes an invoice (with its line items, the seller [Business] and the
/// buyer [Customer]) into a minimal XRechnung document.
///
/// XRechnung is the German e-invoice profile of the EN 16931 / CII D16B
/// (`CrossIndustryInvoice`) syntax. This serializer emits a structurally valid
/// CII document: the guideline context, the exchanged document header, the
/// seller/buyer trade parties, per-line items and a per-category VAT
/// breakdown with a self-consistent monetary summation.
///
/// Pure function: no session, no I/O — unit-testable in isolation.
class XrechnungSerializer {
  const XrechnungSerializer();

  /// EN 16931 guideline identifier that marks the document as XRechnung.
  static const String _guideline = 'urn:cen.eu:en16931:2017';

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

  String serialize({
    required Invoice invoice,
    required List<InvoiceItem> items,
    required Business business,
    Customer? customer,
    String? originalInvoiceNumber,
  }) {
    final currency = _currencyCode(invoice.currency);
    final isCreditNote = invoice.type == InvoiceType.creditNote;
    final typeCode = isCreditNote ? '381' : '380';
    // A credit note reverses the original's stored VAT. The business's
    // current §19 status must not reclassify those lines.
    final applyKleinunternehmer = !isCreditNote && business.isKleinunternehmer;

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
      );
    }

    _writeHeaderTradeAgreement(
      w,
      business,
      customer,
      originalInvoiceNumber: originalInvoiceNumber,
    );

    w.writeln('    <ram:ApplicableHeaderTradeSettlement>');
    w.writeln(
      '      <ram:InvoiceCurrencyCode>$currency</ram:InvoiceCurrencyCode>',
    );
    for (final b in breakdown) {
      _writeHeaderTradeTax(w, b, currency);
    }
    _writeMonetarySummation(
      w,
      currency: currency,
      lineTotal: lineTotal,
      taxTotal: taxTotal,
      grandTotal: grandTotal,
    );
    w.writeln('    </ram:ApplicableHeaderTradeSettlement>');

    w.writeln('  </rsm:SupplyChainTradeTransaction>');
    w.writeln('</rsm:CrossIndustryInvoice>');

    return w.toString();
  }

  // --- document header -------------------------------------------------------

  void _writeExchangedDocumentContext(StringBuffer w) {
    w.writeln('  <rsm:ExchangedDocumentContext>');
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
    Customer? customer, {
    String? originalInvoiceNumber,
  }) {
    w.writeln('    <ram:ApplicableHeaderTradeAgreement>');
    if (originalInvoiceNumber != null &&
        originalInvoiceNumber.trim().isNotEmpty) {
      w.writeln('      <ram:InvoiceReferencedDocument>');
      w.writeln(
        '        <ram:ID>${_escape(originalInvoiceNumber.trim())}</ram:ID>',
      );
      w.writeln('      </ram:InvoiceReferencedDocument>');
    }
    _writeTradeParty(
      w,
      'SellerTradeParty',
      business.name,
      business.address,
      business.vatId,
      business.taxNumber,
    );
    if (customer != null) {
      _writeTradeParty(
        w,
        'BuyerTradeParty',
        customer.companyName ?? customer.name,
        customer.address,
        customer.vatId,
        null,
      );
    }
    w.writeln('    </ram:ApplicableHeaderTradeAgreement>');
  }

  void _writeTradeParty(
    StringBuffer w,
    String element,
    String name,
    Address? address,
    String? vatId,
    String? taxNumber,
  ) {
    w.writeln('      <ram:$element>');
    w.writeln('        <ram:Name>${_escape(name)}</ram:Name>');
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
  }) {
    final unitCode = _unitCode(item.unit);
    final quantity = _formatQuantity(item.quantity);
    final netPrice = _formatAmount(item.unitPriceCents);
    final lineTotal = _formatAmount(item.lineTotalCents);
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

  void _writeHeaderTradeTax(StringBuffer w, _TaxBreakdown b, String currency) {
    w.writeln('      <ram:ApplicableTradeTax>');
    w.writeln(
      '        <ram:CalculatedAmount>${_formatAmount(b.taxCents)}</ram:CalculatedAmount>',
    );
    w.writeln('        <ram:TypeCode>VAT</ram:TypeCode>');
    if (b.category == 'E') {
      w.writeln(
        '        <ram:ExemptionReason>Gemäß § 19 UStG wird keine Umsatzsteuer berechnet.</ram:ExemptionReason>',
      );
      w.writeln(
        '        <ram:ExemptionReasonCode>VATEX-EU-132</ram:ExemptionReasonCode>',
      );
    }
    w.writeln(
      '        <ram:BasisAmount>${_formatAmount(b.basisCents)}</ram:BasisAmount>',
    );
    w.writeln('        <ram:CategoryCode>${b.category}</ram:CategoryCode>');
    w.writeln(
      '        <ram:RateApplicablePercent>${_formatPercent(b.ratePercent)}</ram:RateApplicablePercent>',
    );
    w.writeln('      </ram:ApplicableTradeTax>');
  }

  void _writeMonetarySummation(
    StringBuffer w, {
    required String currency,
    required int lineTotal,
    required int taxTotal,
    required int grandTotal,
  }) {
    w.writeln(
      '      <ram:SpecifiedTradeSettlementHeaderMonetarySummation>',
    );
    w.writeln(
      '        <ram:LineTotalAmount>${_formatAmount(lineTotal)}</ram:LineTotalAmount>',
    );
    w.writeln(
      '        <ram:TaxBasisTotalAmount>${_formatAmount(lineTotal)}</ram:TaxBasisTotalAmount>',
    );
    w.writeln(
      '        <ram:TaxTotalAmount currencyID="$currency">${_formatAmount(taxTotal)}</ram:TaxTotalAmount>',
    );
    w.writeln(
      '        <ram:GrandTotalAmount>${_formatAmount(grandTotal)}</ram:GrandTotalAmount>',
    );
    w.writeln(
      '        <ram:DuePayableAmount>${_formatAmount(grandTotal)}</ram:DuePayableAmount>',
    );
    w.writeln(
      '      </ram:SpecifiedTradeSettlementHeaderMonetarySummation>',
    );
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
    return q.toStringAsFixed(4).replaceFirst(RegExp(r'0+$'), '');
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
