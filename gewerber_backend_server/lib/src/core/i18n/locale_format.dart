import '../../generated/protocol.dart';

/// Locale-aware number, date and money formatting for user-facing documents.
///
/// Deliberately hand-rolled rather than delegating to `package:intl`: the only
/// display locales with a translated catalog are `de` and `en` (see
/// `LocaleMessageCatalog`), and both separators are one `switch` away. Pulling
/// `intl` in would add a runtime dependency to the server for two cases, plus
/// its CLDR data to the image. Revisit when `ru`/`tr` content actually lands —
/// at which point `NumberFormat`/`DateFormat` are the right answer and this
/// class should delegate rather than grow more `switch` arms.
///
/// **Not** for machine-readable output. ZUGFeRD and XRechnung require ISO dates
/// and dot decimals regardless of the document's language, so their serializers
/// keep formatting numerically and independently of anything here.
///
/// Every function is total over the [Locale] enum: there is deliberately no
/// `_` arm, so adding a locale to `locale.spy.yaml` is a compile error here
/// rather than a silently wrong separator.
abstract final class LocaleFormat {
  /// Decimal separator for [locale].
  static String decimalSeparator(Locale locale) => switch (locale) {
    Locale.de => ',',
    Locale.en => '.',
    Locale.ru => ',',
    Locale.tr => ',',
  };

  /// Thousands separator for [locale], or `null` for no grouping.
  static String? groupSeparator(Locale locale) => switch (locale) {
    Locale.de => '.',
    Locale.en => ',',
    // Russian convention is a non-breaking space, not a dot. U+00A0 exists in
    // WinAnsi, so the built-in PDF font can render it.
    Locale.ru => '\u00A0',
    Locale.tr => '.',
  };

  /// Formats [dateTime] as a day-first calendar date.
  ///
  /// Day-first in every locale. `en` deliberately uses `DD/MM/YYYY` rather than
  /// the US `MM/DD/YYYY`: this product's users are German, `03/04/2026` is
  /// unambiguous to them, and silently reordering the fields of a *tax
  /// document* to satisfy a convention none of the target locales actually
  /// share is the worse failure. The separator also differs from `de` (`.`
  /// vs `/`) so the two renderings cannot be confused at a glance.
  ///
  /// `toLocal()` is applied to match the previous behaviour of the PDF
  /// generator, which formatted stored UTC timestamps in the server's zone.
  static String date(DateTime dateTime, {required Locale locale}) {
    final local = dateTime.toLocal();
    final day = _two(local.day);
    final month = _two(local.month);
    final year = local.year;
    return switch (locale) {
      Locale.de || Locale.ru || Locale.tr => '$day.$month.$year',
      Locale.en => '$day/$month/$year',
    };
  }

  /// Formats [value] with exactly [fractionDigits] decimals, grouping the
  /// integer part per [locale].
  static String fixed(
    num value, {
    required Locale locale,
    int fractionDigits = 2,
  }) {
    final negative = value < 0;
    final parts = value.abs().toStringAsFixed(fractionDigits).split('.');
    final grouped = group(parts.first, locale: locale);
    final decimals = parts.length > 1
        ? '${decimalSeparator(locale)}${parts[1]}'
        : '';
    return '${negative ? '-' : ''}$grouped$decimals';
  }

  /// Formats [value] as an invoice line-item quantity: whole numbers render
  /// without a decimal separator, everything else with [fractionDigits].
  ///
  /// This preserves the pre-i18n rendering, where `10` was `10` and `2.5` was
  /// `2,50`, so a German invoice's quantity column is unchanged.
  static String quantity(
    num value, {
    required Locale locale,
    int fractionDigits = 2,
  }) {
    if (value == value.truncateToDouble()) {
      return value.truncate().toString();
    }
    return fixed(value, locale: locale, fractionDigits: fractionDigits);
  }

  /// Inserts the [locale] thousands separator into an unsigned digit string.
  static String group(String digits, {required Locale locale}) {
    final separator = groupSeparator(locale);
    if (separator == null || digits.length <= 3) return digits;

    final buffer = StringBuffer();
    var count = 0;
    for (var i = digits.length - 1; i >= 0; i--) {
      buffer.write(digits[i]);
      count++;
      if (count % 3 == 0 && i > 0) {
        buffer.write(separator);
      }
    }
    return buffer.toString().split('').reversed.join();
  }

  /// Formats integer [cents] as an amount with its currency symbol.
  ///
  /// Symbol placement follows the locale: German puts it after the amount with
  /// a space (`1.234,56 €`), English puts it before without (`€1,234.56`).
  static String money(int cents, Currency currency, {required Locale locale}) {
    final symbol = _currencySymbol(currency);
    final amount = fixed(cents.abs() / 100, locale: locale);
    final sign = cents < 0 ? '-' : '';
    return switch (locale) {
      Locale.de || Locale.ru || Locale.tr => '$sign$amount $symbol',
      Locale.en => '$sign$symbol$amount',
    };
  }

  static String _currencySymbol(Currency currency) => switch (currency) {
    Currency.eur => '€',
  };

  static String _two(int value) => value.toString().padLeft(2, '0');
}
