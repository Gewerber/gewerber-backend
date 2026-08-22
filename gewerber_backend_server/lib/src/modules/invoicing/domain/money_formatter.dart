import '../../../generated/protocol.dart';

/// German-style money formatting shared by PDF, emails and exports.
class MoneyFormatter {
  const MoneyFormatter._();

  /// Formats integer cents as `1.234,56 €` (German grouping, comma decimal).
  static String formatCents(int cents, Currency currency) {
    final isNegative = cents < 0;
    final grouped = _groupThousands(cents.abs() ~/ 100);
    final remainder = (cents.abs() % 100).toString().padLeft(2, '0');
    final sign = isNegative ? '-' : '';
    return '$sign$grouped,$remainder ${_currencySymbol(currency)}';
  }

  /// Formats integer cents as a plain decimal `1190,00` (for CSV exports).
  static String formatCentsDecimal(int cents) {
    final isNegative = cents < 0;
    final remainder = (cents.abs() % 100).toString().padLeft(2, '0');
    final sign = isNegative ? '-' : '';
    return '$sign${cents.abs() ~/ 100},$remainder';
  }

  static String _groupThousands(int value) {
    final raw = value.toString();
    final buffer = StringBuffer();
    var count = 0;
    for (var i = raw.length - 1; i >= 0; i--) {
      buffer.write(raw[i]);
      count++;
      if (count % 3 == 0 && i > 0) {
        buffer.write('.');
      }
    }
    return buffer.toString().split('').reversed.join();
  }

  static String _currencySymbol(Currency currency) {
    return switch (currency) {
      Currency.eur => '€',
    };
  }
}
