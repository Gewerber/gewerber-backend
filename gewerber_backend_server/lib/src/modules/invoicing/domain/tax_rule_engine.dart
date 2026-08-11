import 'package:injectable/injectable.dart';

import '../../../generated/protocol.dart';

/// Resolves the applicable VAT rate for an invoice.
///
/// German rules applied:
/// - Kleinunternehmer (§19 UStG): no VAT is charged or shown.
/// - EU B2B with a valid VAT ID: reverse charge.
/// - Non-EU customer: zero rate (export).
/// - Domestic: standard (19 %) or reduced (7 %).
@singleton
class TaxRuleEngine {
  static const int standardPercent = 19;
  static const int reducedPercent = 7;

  /// EU member states as of 2026 (ISO alpha-3).
  static const Set<Country> euCountries = {
    Country.deu,
    Country.aut,
    Country.bel,
    Country.bgr,
    Country.hrv,
    Country.cyp,
    Country.cze,
    Country.dnk,
    Country.est,
    Country.fin,
    Country.fra,
    Country.grc,
    Country.hun,
    Country.irl,
    Country.ita,
    Country.lva,
    Country.ltu,
    Country.lux,
    Country.mlt,
    Country.nld,
    Country.pol,
    Country.prt,
    Country.rou,
    Country.svk,
    Country.svn,
    Country.esp,
    Country.swe,
  };

  VatRate resolveDefaultRate({
    required Business business,
    Customer? customer,
  }) {
    if (business.isKleinunternehmer) {
      return VatRate.none;
    }
    final country = customer?.address?.country ?? Country.deu;
    if (country != Country.deu &&
        euCountries.contains(country) &&
        _hasVatId(customer)) {
      return VatRate.reverseCharge;
    }
    if (!euCountries.contains(country)) {
      return VatRate.zero;
    }
    return VatRate.standard;
  }

  int percentFor(VatRate rate) {
    return switch (rate) {
      VatRate.standard => standardPercent,
      VatRate.reduced => reducedPercent,
      VatRate.none || VatRate.zero || VatRate.reverseCharge => 0,
    };
  }

  bool _hasVatId(Customer? customer) {
    final vatId = customer?.vatId?.trim();
    return vatId != null && vatId.isNotEmpty;
  }
}
