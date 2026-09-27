import '../../generated/protocol.dart';
import 'messages.dart';

/// Maps a [Country] to its message key in the message catalog.
///
/// Lives beside the catalog rather than in the PDF generator because it is a
/// catalog concern, not a rendering one — and because it is the invariant worth
/// testing directly: **every** enum value resolves to a real, translated
/// country name.
///
/// The switch is exhaustive on purpose, with no `_` arm. Adding a value to
/// `country.spy.yaml` is therefore a compile error here rather than a country
/// silently printing its raw three-letter enum code (`nor`, `are`) on a tax
/// document. That is exactly what the pre-i18n `_ => country.name` fallback in
/// the PDF generator did for 19 of the 49 values.
String countryKey(Country country) => switch (country) {
  Country.deu => Messages.pdfCountryDeu,
  Country.aut => Messages.pdfCountryAut,
  Country.bel => Messages.pdfCountryBel,
  Country.bgr => Messages.pdfCountryBgr,
  Country.hrv => Messages.pdfCountryHrv,
  Country.cyp => Messages.pdfCountryCyp,
  Country.cze => Messages.pdfCountryCze,
  Country.dnk => Messages.pdfCountryDnk,
  Country.est => Messages.pdfCountryEst,
  Country.fin => Messages.pdfCountryFin,
  Country.fra => Messages.pdfCountryFra,
  Country.grc => Messages.pdfCountryGrc,
  Country.hun => Messages.pdfCountryHun,
  Country.irl => Messages.pdfCountryIrl,
  Country.ita => Messages.pdfCountryIta,
  Country.lva => Messages.pdfCountryLva,
  Country.ltu => Messages.pdfCountryLtu,
  Country.lux => Messages.pdfCountryLux,
  Country.mlt => Messages.pdfCountryMlt,
  Country.nld => Messages.pdfCountryNld,
  Country.pol => Messages.pdfCountryPol,
  Country.prt => Messages.pdfCountryPrt,
  Country.rou => Messages.pdfCountryRou,
  Country.svk => Messages.pdfCountrySvk,
  Country.svn => Messages.pdfCountrySvn,
  Country.esp => Messages.pdfCountryEsp,
  Country.swe => Messages.pdfCountrySwe,
  Country.che => Messages.pdfCountryChe,
  Country.gbr => Messages.pdfCountryGbr,
  Country.nor => Messages.pdfCountryNor,
  Country.isl => Messages.pdfCountryIsl,
  Country.lie => Messages.pdfCountryLie,
  Country.usa => Messages.pdfCountryUsa,
  Country.can => Messages.pdfCountryCan,
  Country.aus => Messages.pdfCountryAus,
  Country.nzl => Messages.pdfCountryNzl,
  Country.jpn => Messages.pdfCountryJpn,
  Country.chn => Messages.pdfCountryChn,
  Country.ind => Messages.pdfCountryInd,
  Country.tur => Messages.pdfCountryTur,
  Country.ukr => Messages.pdfCountryUkr,
  Country.are => Messages.pdfCountryAre,
  Country.sau => Messages.pdfCountrySau,
  Country.bra => Messages.pdfCountryBra,
  Country.mex => Messages.pdfCountryMex,
  Country.zaf => Messages.pdfCountryZaf,
  Country.kor => Messages.pdfCountryKor,
  Country.sgp => Messages.pdfCountrySgp,
  Country.isr => Messages.pdfCountryIsr,
};
