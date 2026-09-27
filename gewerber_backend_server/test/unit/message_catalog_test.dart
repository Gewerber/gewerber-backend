import 'package:gewerber_backend_server/src/core/i18n/country_names.dart';
import 'package:gewerber_backend_server/src/core/i18n/locale_message_catalog.dart';
import 'package:gewerber_backend_server/src/core/i18n/message_catalog.dart';
import 'package:gewerber_backend_server/src/core/i18n/messages.dart';
import 'package:gewerber_backend_server/src/core/i18n/messages_de.dart';
import 'package:gewerber_backend_server/src/core/i18n/messages_en.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

/// In-memory catalog used to exercise the fallback and interpolation rules
/// without depending on the shipped locale maps.
final class _FakeCatalog extends MessageCatalogBase {
  const _FakeCatalog(this._maps);

  final Map<Locale, Map<String, String>> _maps;

  @override
  Set<Locale> get translatedLocales => _maps.keys.toSet();

  @override
  Map<String, String>? catalogFor(Locale locale) => _maps[locale];
}

void main() {
  group('shipped catalogs', () {
    const catalog = LocaleMessageCatalog();

    test('fall back to de, matching the persisted Locale column default', () {
      expect(fallbackLocale, Locale.de);
    });

    test('declare de and en as translated locales', () {
      expect(catalog.translatedLocales, {Locale.de, Locale.en});
    });

    test('de defines every key in Messages', () {
      // de is the fallback catalog, so a key missing here is missing for every
      // locale. This is the guard that makes the other tests meaningful.
      const allKeys = <String>[
        Messages.errorNotAuthenticated,
        Messages.errorNotBusinessMember,
        Messages.errorAdminPermissionsRequired,
        Messages.errorAdminRoleRequired,
        Messages.errorInsufficientAdminRole,
        Messages.pdfDocumentInvoice,
        Messages.pdfDocumentCreditNote,
        Messages.pdfDocumentCancellationNotice,
        Messages.pdfDocumentCorrectionNote,
        Messages.pdfFieldVatId,
        Messages.pdfFieldTaxNumber,
        Messages.pdfFieldEmail,
        Messages.pdfFieldPhone,
        Messages.pdfFieldInvoiceRecipient,
        Messages.pdfFieldCreditNoteRecipient,
        Messages.pdfFieldCustomerVatId,
        Messages.pdfFieldInvoiceNumber,
        Messages.pdfFieldCreditNoteNumber,
        Messages.pdfFieldInvoiceDate,
        Messages.pdfFieldCreditNoteDate,
        Messages.pdfFieldCancelledInvoice,
        Messages.pdfFieldDueDate,
        Messages.pdfFieldServicePeriod,
        Messages.pdfTablePosition,
        Messages.pdfTableDescription,
        Messages.pdfTableQuantity,
        Messages.pdfTableUnit,
        Messages.pdfTableUnitPrice,
        Messages.pdfTableVatRate,
        Messages.pdfTableLineTotal,
        Messages.pdfTotalNetSubtotal,
        Messages.pdfTotalVat,
        Messages.pdfTotalGrandTotal,
        Messages.pdfNoteKleinunternehmer,
        Messages.pdfNoteReverseCharge,
        Messages.pdfSectionNotes,
        Messages.pdfSectionOffset,
        Messages.pdfTextOffsetExplanation,
        Messages.pdfSectionPaymentTerms,
        Messages.pdfTextPaymentTerms,
        Messages.pdfFooterPage,
        Messages.pdfUnitPiece,
        Messages.pdfUnitHour,
        Messages.pdfUnitDay,
        Messages.pdfUnitMonth,
        Messages.pdfUnitProject,
        Messages.pdfUnitOther,
        Messages.pdfCountryDeu,
        Messages.pdfCountryAut,
        Messages.pdfCountryBel,
        Messages.pdfCountryBgr,
        Messages.pdfCountryHrv,
        Messages.pdfCountryCyp,
        Messages.pdfCountryCze,
        Messages.pdfCountryDnk,
        Messages.pdfCountryEst,
        Messages.pdfCountryFin,
        Messages.pdfCountryFra,
        Messages.pdfCountryGrc,
        Messages.pdfCountryHun,
        Messages.pdfCountryIrl,
        Messages.pdfCountryIta,
        Messages.pdfCountryLva,
        Messages.pdfCountryLtu,
        Messages.pdfCountryLux,
        Messages.pdfCountryMlt,
        Messages.pdfCountryNld,
        Messages.pdfCountryPol,
        Messages.pdfCountryPrt,
        Messages.pdfCountryRou,
        Messages.pdfCountrySvk,
        Messages.pdfCountrySvn,
        Messages.pdfCountryEsp,
        Messages.pdfCountrySwe,
        Messages.pdfCountryChe,
        Messages.pdfCountryGbr,
        Messages.pdfCountryNor,
        Messages.pdfCountryIsl,
        Messages.pdfCountryLie,
        Messages.pdfCountryUsa,
        Messages.pdfCountryCan,
        Messages.pdfCountryAus,
        Messages.pdfCountryNzl,
        Messages.pdfCountryJpn,
        Messages.pdfCountryChn,
        Messages.pdfCountryInd,
        Messages.pdfCountryTur,
        Messages.pdfCountryUkr,
        Messages.pdfCountryAre,
        Messages.pdfCountrySau,
        Messages.pdfCountryBra,
        Messages.pdfCountryMex,
        Messages.pdfCountryZaf,
        Messages.pdfCountryKor,
        Messages.pdfCountrySgp,
        Messages.pdfCountryIsr,
      ];

      for (final key in allKeys) {
        expect(
          messageMapDe.containsKey(key),
          isTrue,
          reason: 'de catalog is missing "$key"',
        );
        expect(catalog.has(key, locale: Locale.de), isTrue);
      }
    });

    test('de and en define the same key set', () {
      // A key present in one map and not the other means a locale silently
      // renders a different string from the same call site.
      expect(
        messageMapEn.keys.toSet().difference(messageMapDe.keys.toSet()),
        isEmpty,
        reason: 'keys in en but not de',
      );
      expect(
        messageMapDe.keys.toSet().difference(messageMapEn.keys.toSet()),
        isEmpty,
        reason: 'keys in de but not en',
      );
    });

    test('no empty values in either catalog', () {
      for (final entry in {...messageMapDe, ...messageMapEn}.entries) {
        expect(
          entry.value.trim(),
          isNotEmpty,
          reason: 'empty value: ${entry.key}',
        );
      }
    });

    test('templates use only the {placeholder} form the interpolator supports', () {
      // A stray %s / $var / { spaced token } would survive resolution and leak
      // into the rendered document.
      final braces = RegExp(r'\{[^{}]*\}');
      final supported = RegExp(r'^\{\w+\}$');
      for (final entry in {...messageMapDe, ...messageMapEn}.entries) {
        for (final match in braces.allMatches(entry.value)) {
          expect(
            supported.hasMatch(match[0]!),
            isTrue,
            reason: 'unsupported placeholder "${match[0]}" in ${entry.key}',
          );
        }
      }
    });

    test(
      'German PDF labels are preserved verbatim from the hardcoded strings',
      () {
        // Guards the migration itself: de is what a German invoice rendered
        // before issue #57, and must not change when the catalog takes over.
        expect(
          catalog.text(Messages.pdfDocumentInvoice, locale: Locale.de),
          'Rechnung',
        );
        expect(
          catalog.text(Messages.pdfDocumentCreditNote, locale: Locale.de),
          'Gutschrift',
        );
        expect(
          catalog.text(Messages.pdfFieldInvoiceNumber, locale: Locale.de),
          'Rechnungsnummer',
        );
        expect(
          catalog.text(Messages.pdfNoteKleinunternehmer, locale: Locale.de),
          'Gemäß § 19 UStG wird keine Umsatzsteuer berechnet.',
        );
      },
    );

    test('English error strings match the pre-catalog literals exactly', () {
      // Routing errors through the catalog must be a no-op for English
      // requests so deployed clients see unchanged bytes.
      expect(
        catalog.text(Messages.errorNotAuthenticated, locale: Locale.en),
        'Not authenticated.',
      );
      expect(
        catalog.text(Messages.errorNotBusinessMember, locale: Locale.en),
        'Not a member of this business.',
      );
      expect(
        catalog.text(Messages.errorAdminPermissionsRequired, locale: Locale.en),
        'Admin permissions required.',
      );
      expect(
        catalog.text(Messages.errorAdminRoleRequired, locale: Locale.en),
        'Administrator role required.',
      );
    });

    test('translates the same key per locale', () {
      expect(
        catalog.text(Messages.pdfDocumentInvoice, locale: Locale.de),
        'Rechnung',
      );
      expect(
        catalog.text(Messages.pdfDocumentInvoice, locale: Locale.en),
        'Invoice',
      );
    });

    test('ru and tr resolve through the fallback until translated', () {
      // The product supports four locales, but only two have catalogs. A stored
      // ru/tr preference must render something real rather than a raw key.
      for (final locale in [Locale.ru, Locale.tr]) {
        expect(
          catalog.has(Messages.pdfDocumentInvoice, locale: locale),
          isTrue,
        );
        expect(
          catalog.text(Messages.pdfDocumentInvoice, locale: locale),
          'Rechnung',
        );
      }
    });
  });

  group('country names', () {
    const catalog = LocaleMessageCatalog();

    test('every Country resolves to a translated name in every locale', () {
      for (final country in Country.values) {
        final key = countryKey(country);
        for (final locale in [Locale.de, Locale.en]) {
          final name = catalog.text(key, locale: locale);
          expect(
            name,
            isNot(key),
            reason: '${country.name} has no $locale country name',
          );
          expect(name.trim(), isNotEmpty);
        }
      }
    });

    test('no country renders as its raw enum code', () {
      // The pre-i18n PDF generator had a `_ => country.name` fallback, so 19 of
      // the 49 values printed `nor`, `are`, `jpn` and so on onto the invoice.
      for (final country in Country.values) {
        for (final locale in [Locale.de, Locale.en]) {
          expect(
            catalog.text(countryKey(country), locale: locale),
            isNot(country.name),
            reason: '${country.name} leaks its enum code in $locale',
          );
        }
      }
    });

    test('covers all 49 Country values', () {
      // A tripwire for a new country being added to the enum without a
      // corresponding catalog entry; `countryKey` being exhaustive means this
      // only fails on the missing translation, at the point it is added.
      expect(Country.values, hasLength(49));
    });
  });

  group('interpolate', () {
    const catalog = LocaleMessageCatalog();

    test('substitutes named placeholders', () {
      expect(
        catalog.text(Messages.pdfTextPaymentTerms, args: const {'days': 14}),
        'Zahlbar innerhalb von 14 Tagen nach Rechnungsdatum ohne Abzug.',
      );
    });

    test('substitutes several placeholders in one template', () {
      expect(
        catalog.text(
          Messages.pdfFooterPage,
          locale: Locale.en,
          args: const {'page': 2, 'pages': 7},
        ),
        'Page 2 of 7',
      );
    });

    test('leaves a placeholder with no argument visible', () {
      // A missing argument should be diagnosable in the output, not a silent
      // gap in a sentence.
      expect(
        catalog.text(Messages.pdfTextPaymentTerms, locale: Locale.de),
        contains('{days}'),
      );
    });

    test('stringifies non-string argument values', () {
      expect(
        catalog.text(
          Messages.pdfFooterPage,
          locale: Locale.de,
          args: const {'page': 1, 'pages': 3},
        ),
        'Seite 1 von 3',
      );
    });

    test('is a no-op when args is empty', () {
      expect(interpolate('plain', {}), 'plain');
    });
  });

  group('fallback and unknown keys', () {
    test('falls back to de for a locale with no catalog', () {
      const fake = _FakeCatalog({
        Locale.de: {'greeting': 'Hallo'},
      });
      expect(fake.text('greeting', locale: Locale.tr), 'Hallo');
    });

    test('uses the requested catalog when it has the key', () {
      const fake = _FakeCatalog({
        Locale.de: {'greeting': 'Hallo'},
        Locale.en: {'greeting': 'Hello'},
      });
      expect(fake.text('greeting', locale: Locale.en), 'Hello');
      expect(fake.text('greeting', locale: Locale.de), 'Hallo');
    });

    test('falls back per key, not per locale', () {
      // A partially translated locale must render the translated keys and fall
      // through for the rest, rather than reverting wholesale to de.
      const fake = _FakeCatalog({
        Locale.de: {'a': 'de-a', 'b': 'de-b'},
        Locale.en: {'a': 'en-a'},
      });
      expect(fake.text('a', locale: Locale.en), 'en-a');
      expect(fake.text('b', locale: Locale.en), 'de-b');
    });

    test('has() agrees with text() on a partial locale', () {
      const fake = _FakeCatalog({
        Locale.de: {'a': 'de-a', 'b': 'de-b'},
        Locale.en: {'a': 'en-a'},
      });
      expect(fake.has('a', locale: Locale.en), isTrue);
      expect(fake.has('b', locale: Locale.en), isTrue);
      expect(fake.has('missing', locale: Locale.en), isFalse);
    });

    test('an unknown key resolves to the key itself', () {
      // Under `assert` this also throws, which is the point: a missing key must
      // fail a test loudly rather than reaching a user as `error.typo`.
      expect(
        () => const _FakeCatalog({}).text('error.typo'),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
