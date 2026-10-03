import 'package:gewerber_backend_server/src/core/i18n/locale_resolver.dart';
import 'package:gewerber_backend_server/src/core/i18n/message_catalog.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('forInvoice', () {
    test('prefers the locale snapshotted on the invoice', () {
      // A document must keep its language even if the business is reconfigured
      // afterwards, so the stored invoice locale outranks everything.
      expect(
        LocaleResolver.forInvoice(invoice: Locale.en, business: Locale.de),
        Locale.en,
      );
    });

    test('falls back to the business locale when the invoice has none', () {
      expect(
        LocaleResolver.forInvoice(invoice: null, business: Locale.tr),
        Locale.tr,
      );
    });

    test('falls back to de when neither is known', () {
      // Pre-i18n behaviour: no locale context meant German.
      expect(LocaleResolver.forInvoice(), Locale.de);
      expect(fallbackLocale, Locale.de);
    });

    test('is stable when the same inputs are re-resolved', () {
      const inputs = {'invoice': Locale.ru, 'business': Locale.tr};
      expect(
        LocaleResolver.forInvoice(
          invoice: inputs['invoice'],
          business: inputs['business'],
        ),
        LocaleResolver.forInvoice(
          invoice: inputs['invoice'],
          business: inputs['business'],
        ),
      );
    });
  });

  group('forBusinessCorrespondence', () {
    test('prefers the business locale over the sending user', () {
      // A dunning email is sent on behalf of the business, which may be
      // configured differently from the user who triggered the send.
      expect(
        LocaleResolver.forBusinessCorrespondence(
          business: Locale.en,
          user: Locale.de,
        ),
        Locale.en,
      );
    });

    test('falls back to the user when the business locale is unknown', () {
      expect(
        LocaleResolver.forBusinessCorrespondence(user: Locale.ru),
        Locale.ru,
      );
    });

    test('falls back to de when nothing is known', () {
      expect(LocaleResolver.forBusinessCorrespondence(), Locale.de);
    });
  });

  group('forUserInterface', () {
    test('prefers the personal profile preference over the business', () {
      // Errors and guidance land on the signed-in user's own screen, and the
      // profile locale is a personal UI preference with no legal content.
      expect(
        LocaleResolver.forUserInterface(
          userProfile: Locale.tr,
          business: Locale.de,
        ),
        Locale.tr,
      );
    });

    test('falls back to the business when the profile is not loaded', () {
      // Keeps the common in-request path cheap: callers that already hold a
      // business but have not loaded the profile still get a real locale.
      expect(
        LocaleResolver.forUserInterface(business: Locale.en),
        Locale.en,
      );
    });

    test('falls back to de when nothing is known', () {
      expect(LocaleResolver.forUserInterface(), Locale.de);
    });
  });

  group('forAdminSurface', () {
    test('uses the admin user profile locale', () {
      expect(LocaleResolver.forAdminSurface(userProfile: Locale.en), Locale.en);
    });

    test('ignores any business notion and falls back to de', () {
      // The admin API is driven by gewerber-mcp and has no business context.
      expect(LocaleResolver.forAdminSurface(), Locale.de);
    });
  });

  group('forAuthEmail', () {
    test('uses an explicitly requested locale', () {
      expect(LocaleResolver.forAuthEmail(requested: Locale.en), Locale.en);
    });

    test('falls back to de when none was requested', () {
      // Registration fires before a profile exists, so there is nothing to read
      // a preference from yet.
      expect(LocaleResolver.forAuthEmail(), Locale.de);
    });
  });
}
