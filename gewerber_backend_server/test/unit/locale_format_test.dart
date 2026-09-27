import 'package:gewerber_backend_server/src/core/i18n/locale_format.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/money_formatter.dart';
import 'package:test/test.dart';

void main() {
  group('decimalSeparator', () {
    test('is a comma in de, ru and tr and a dot in en', () {
      expect(LocaleFormat.decimalSeparator(Locale.de), ',');
      expect(LocaleFormat.decimalSeparator(Locale.ru), ',');
      expect(LocaleFormat.decimalSeparator(Locale.tr), ',');
      expect(LocaleFormat.decimalSeparator(Locale.en), '.');
    });
  });

  group('groupSeparator', () {
    test('is a dot in de and tr, a comma in en', () {
      expect(LocaleFormat.groupSeparator(Locale.de), '.');
      expect(LocaleFormat.groupSeparator(Locale.tr), '.');
      expect(LocaleFormat.groupSeparator(Locale.en), ',');
    });

    test('is a non-breaking space in ru, not a dot', () {
      expect(LocaleFormat.groupSeparator(Locale.ru), '\u00A0');
    });
  });

  group('date', () {
    final date = DateTime.utc(2026, 12, 31, 12);

    test('renders de day-first with dots', () {
      expect(LocaleFormat.date(date, locale: Locale.de), '31.12.2026');
    });

    test('renders en day-first with slashes, not US month-first', () {
      // Deliberately not MM/DD/YYYY: see LocaleFormat.date's doc comment. A
      // day-first date is unambiguous to the German users this product serves,
      // and reordering the fields of a tax document is the worse failure.
      expect(LocaleFormat.date(date, locale: Locale.en), '31/12/2026');
    });

    test('de and en differ in separator so they cannot be confused', () {
      expect(
        LocaleFormat.date(date, locale: Locale.de),
        isNot(LocaleFormat.date(date, locale: Locale.en)),
      );
    });

    test('zero-pads single-digit days and months', () {
      expect(
        LocaleFormat.date(DateTime.utc(2026, 3, 4), locale: Locale.de),
        '04.03.2026',
      );
    });
  });

  group('group', () {
    test('leaves numbers of three digits or fewer alone', () {
      expect(LocaleFormat.group('999', locale: Locale.de), '999');
      expect(LocaleFormat.group('100', locale: Locale.en), '100');
    });

    test('groups thousands in de', () {
      expect(LocaleFormat.group('1234', locale: Locale.de), '1.234');
      expect(LocaleFormat.group('1234567', locale: Locale.de), '1.234.567');
    });

    test('groups thousands in en', () {
      expect(LocaleFormat.group('1234', locale: Locale.en), '1,234');
      expect(LocaleFormat.group('1234567', locale: Locale.en), '1,234,567');
    });
  });

  group('fixed', () {
    test('formats with two decimals and de separators', () {
      expect(LocaleFormat.fixed(1234.5, locale: Locale.de), '1.234,50');
    });

    test('formats with two decimals and en separators', () {
      expect(LocaleFormat.fixed(1234.5, locale: Locale.en), '1,234.50');
    });

    test('keeps the minus sign outside the grouping', () {
      expect(LocaleFormat.fixed(-1234.5, locale: Locale.de), '-1.234,50');
      expect(LocaleFormat.fixed(-1234.5, locale: Locale.en), '-1,234.50');
    });

    test('honours the requested fraction digit count', () {
      expect(
        LocaleFormat.fixed(2.345, locale: Locale.de, fractionDigits: 0),
        '2',
      );
    });
  });

  group('quantity', () {
    test('renders whole numbers without a decimal separator', () {
      // Preserves the pre-i18n behaviour of the PDF quantity column.
      expect(LocaleFormat.quantity(10, locale: Locale.de), '10');
      expect(LocaleFormat.quantity(10, locale: Locale.en), '10');
    });

    test('renders fractions with two decimals per locale', () {
      expect(LocaleFormat.quantity(2.5, locale: Locale.de), '2,50');
      expect(LocaleFormat.quantity(2.5, locale: Locale.en), '2.50');
    });

    test('does not group large whole numbers', () {
      // A line-item quantity is never thousands-separated; grouping here would
      // be a formatting regression on the quantity column.
      expect(LocaleFormat.quantity(1000, locale: Locale.de), '1000');
    });
  });

  group('money', () {
    test('places the symbol after the amount in de', () {
      expect(
        LocaleFormat.money(123456, Currency.eur, locale: Locale.de),
        '1.234,56 €',
      );
    });

    test('places the symbol before the amount in en', () {
      expect(
        LocaleFormat.money(123456, Currency.eur, locale: Locale.en),
        '€1,234.56',
      );
    });

    test('keeps the minus sign before the whole amount in de', () {
      expect(
        LocaleFormat.money(-123456, Currency.eur, locale: Locale.de),
        '-1.234,56 €',
      );
    });

    test('keeps the minus sign before the symbol in en', () {
      expect(
        LocaleFormat.money(-123456, Currency.eur, locale: Locale.en),
        '-€1,234.56',
      );
    });

    test('renders a zero amount', () {
      expect(LocaleFormat.money(0, Currency.eur, locale: Locale.de), '0,00 €');
      expect(LocaleFormat.money(0, Currency.eur, locale: Locale.en), '€0.00');
    });
  });

  group('MoneyFormatter', () {
    test('formatCents defaults to the pre-i18n German rendering', () {
      // The default keeps existing callers (the reminder e-mail) byte-identical
      // to what they produced before the locale parameter existed.
      expect(
        MoneyFormatter.formatCents(123456, Currency.eur),
        '1.234,56 €',
      );
      expect(
        MoneyFormatter.formatCents(-123456, Currency.eur),
        '-1.234,56 €',
      );
      expect(MoneyFormatter.formatCents(0, Currency.eur), '0,00 €');
    });

    test('formatCents honours an explicit locale', () {
      expect(
        MoneyFormatter.formatCents(123456, Currency.eur, locale: Locale.en),
        '€1,234.56',
      );
    });

    test('formatCentsDecimal is unchanged and locale-independent', () {
      // CSV is machine-consumed, so its shape is part of the export contract
      // and must not change with a business's display language.
      expect(MoneyFormatter.formatCentsDecimal(119000), '1190,00');
      expect(MoneyFormatter.formatCentsDecimal(-119000), '-1190,00');
      expect(MoneyFormatter.formatCentsDecimal(5), '0,05');
    });
  });
}
