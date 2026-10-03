import '../../../core/i18n/locale_format.dart';
import '../../../core/i18n/message_catalog.dart';
import '../../../generated/protocol.dart';

/// Money formatting shared by the invoice PDF, reminder e-mail and exports.
///
/// The display format ([formatCents]) is locale-aware and delegates to
/// [LocaleFormat]. The export format ([formatCentsDecimal]) is **not**: CSV
/// columns are machine-consumed and keep the German `1190,00` shape they have
/// always had, so an export does not change shape when a business switches
/// display language. Same for ZUGFeRD/XRechnung, which format numerically and
/// independently of this class.
class MoneyFormatter {
  const MoneyFormatter._();

  /// Formats integer cents for display, e.g. `1.234,56 €` (de) or `€1,234.56`
  /// (en). Defaults to [fallbackLocale] so a caller with no locale of its own
  /// renders exactly as it did before issue #57.
  static String formatCents(
    int cents,
    Currency currency, {
    Locale locale = fallbackLocale,
  }) => LocaleFormat.money(cents, currency, locale: locale);

  /// Formats integer cents as a plain decimal `1190,00`, for CSV exports.
  ///
  /// Intentionally locale-independent: a CSV column is parsed by a spreadsheet
  /// or an accounting import, not read by a person, so the shape is part of the
  /// export contract rather than a presentation choice.
  static String formatCentsDecimal(int cents) {
    final isNegative = cents < 0;
    final remainder = (cents.abs() % 100).toString().padLeft(2, '0');
    final sign = isNegative ? '-' : '';
    return '$sign${cents.abs() ~/ 100},$remainder';
  }
}
