import '../../generated/protocol.dart';

/// Locale used when a message is requested for an untranslated locale, or when
/// a key is missing from every catalog.
///
/// `de` is the fallback because it is the `default:` of the persisted
/// `Locale`-typed columns (`Business.locale`, `UserProfile.locale`,
/// `Invoice.locale`) and therefore the locale a request has when nothing else
/// specifies one. Picking the same value keeps pre-i18n behaviour unchanged for
/// any request that does not carry a locale.
const Locale fallbackLocale = Locale.de;

/// Matches a `{name}` placeholder in a message template.
final RegExp placeholderPattern = RegExp(r'\{(\w+)\}');

/// Substitutes `{name}` placeholders in [template] with values from [args].
///
/// A placeholder with no matching entry in [args] is left in place verbatim
/// rather than being blanked out, so a missing argument is visible in the
/// rendered output instead of silently producing a gap in a sentence. Values
/// are stringified with `toString()`, so callers may pass ints, decimals,
/// enums or dates without pre-formatting — as long as the target locale does
/// not need locale-aware number/date formatting. Where it does (invoice
/// documents), format before calling and pass the result in `args`.
String interpolate(String template, Map<String, Object?> args) {
  if (args.isEmpty) return template;
  return template.replaceAllMapped(placeholderPattern, (match) {
    final name = match[1]!;
    final value = args[name];
    return value == null ? match[0]! : value.toString();
  });
}

/// Read access to user-facing, translatable text, keyed by stable message
/// keys rather than by the literal English/German wording.
///
/// Every backend-rendered string that reaches a user — invoice PDF labels,
/// transactional email bodies, guidance content, and the `message` field of the
/// `Validation`/`Conflict`/`Forbidden` exceptions — is resolved through this
/// contract. Keeping the lookup behind a key (and not the literal text) is what
/// makes a string translatable: call sites stop owning the wording, and a
/// translator only ever edits a catalog map.
///
/// Implementations are resolved from `getIt` (see
/// `LocaleMessageCatalog`), so render code takes a `MessageCatalog` rather
/// than constructing one.
abstract interface class MessageCatalog {
  /// Locales that have a first-class, human-maintained catalog.
  ///
  /// A locale absent from this set is still *supported* by the product — it is
  /// a valid `Locale` value and is persisted on user, business and invoice
  /// records — but it has no catalog of its own, so [text] resolves it through
  /// [fallbackLocale]. This is how `ru` and `tr` behave today: they are stored
  /// and round-trip correctly, but render English pending translated content.
  Set<Locale> get translatedLocales;

  /// Resolves [key] in [locale], substituting `{placeholder}` tokens from
  /// [args]. [locale] defaults to [fallbackLocale].
  ///
  /// Resolution order: the requested locale's catalog, then [fallbackLocale]'s
  /// catalog, then [key] itself. Returning the bare key keeps an untranslated
  /// message readable and, because keys are namespaced constants
  /// (`error.notAuthenticated`, `pdf.table.total`), still diagnosable.
  String text(String key, {Locale? locale, Map<String, Object?>? args});

  /// Whether [key] resolves to a real translation in [locale] or in
  /// [fallbackLocale] — i.e. whether [text] would return something other than
  /// the bare key. Intended for tests that assert catalog completeness.
  bool has(String key, {Locale? locale});
}

/// Shared resolution and interpolation rules for [MessageCatalog]
/// implementations.
///
/// Subclasses supply the per-locale maps; fallback, placeholder substitution
/// and the "unknown key" rules live here so every catalog behaves identically
/// and are testable once.
abstract base class MessageCatalogBase implements MessageCatalog {
  const MessageCatalogBase();

  /// The catalog for [locale], or `null` when that locale has no catalog of
  /// its own and should fall through to [fallbackLocale].
  Map<String, String>? catalogFor(Locale locale);

  @override
  String text(String key, {Locale? locale, Map<String, Object?>? args}) {
    final requested = catalogFor(locale ?? fallbackLocale);
    final template =
        requested?[key] ?? catalogFor(fallbackLocale)?[key] ?? _unknownKey(key);
    return interpolate(template, args ?? const {});
  }

  @override
  bool has(String key, {Locale? locale}) {
    final requested = catalogFor(locale ?? fallbackLocale);
    if (requested != null && requested.containsKey(key)) return true;
    return catalogFor(fallbackLocale)?.containsKey(key) ?? false;
  }

  /// A missing key is a programming error, so it is asserted in debug and test
  /// builds — where it should fail loudly — while still degrading to the
  /// readable key in production rather than throwing mid-request.
  String _unknownKey(String key) {
    assert(
      false,
      'Missing translation for "$key" in every catalog '
      '(${translatedLocales.join(', ')}). Add it to the locale maps.',
    );
    return key;
  }
}
