import 'package:injectable/injectable.dart';

import '../../generated/protocol.dart';
import 'message_catalog.dart';
import 'messages_de.dart';
import 'messages_en.dart';

/// Default [MessageCatalog] backed by the in-repository locale maps.
///
/// Resolved from `getIt`, so render code takes a `MessageCatalog` and never
/// constructs one. The maps are plain `const` data — no file I/O, no codegen,
/// no runtime dependency — which keeps the catalogs greppable, reviewable in a
/// diff, and type-checked against [Messages] at compile time.
///
/// ## Adding a locale
///
///  1. Add the value to `lib/src/modules/business/models/locale.spy.yaml`,
///     then `serverpod generate` and commit the generated artifacts (this is
///     the only step in the i18n work that trips the `privacy-guard`
///     byte-identical check).
///  2. Add `messages_<code>.dart` with a full map.
///  3. Register it in [_maps] and add it to [translatedLocales].
///
/// A locale added to the enum but not to [_maps] keeps working: it stores and
/// round-trips, and renders through the [fallbackLocale] until its catalog
/// lands. That is the current state of `ru` and `tr`.
@Singleton(as: MessageCatalog)
final class LocaleMessageCatalog extends MessageCatalogBase {
  const LocaleMessageCatalog();

  static const Map<Locale, Map<String, String>> _maps =
      <Locale, Map<String, String>>{
        Locale.de: messageMapDe,
        Locale.en: messageMapEn,
      };

  @override
  Set<Locale> get translatedLocales => _maps.keys.toSet();

  @override
  Map<String, String>? catalogFor(Locale locale) => _maps[locale];
}
