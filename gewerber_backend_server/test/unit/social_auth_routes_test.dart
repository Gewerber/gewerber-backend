import 'package:gewerber_backend_server/src/auth/social_auth_routes.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('socialAuthRoutePlan', () {
    test(
      'all providers enabled mounts the generic callback and Apple routes',
      () {
        final plan = socialAuthRoutePlan(AuthProvider.values.toSet());

        expect(plan.flutterWebAuth2Callback, isTrue);
        expect(plan.appleRoutes, isTrue);
      },
    );

    test(
      'apple alone does not mount the generic flutter_web_auth_2 callback',
      () {
        final plan = socialAuthRoutePlan({AuthProvider.apple});

        expect(
          plan.flutterWebAuth2Callback,
          isFalse,
          reason:
              'Apple redirects to appleWebRedirectUri itself and never serves '
              'the flutter_web_auth_2 page',
        );
        expect(plan.appleRoutes, isTrue);
      },
    );

    test('google alone mounts only the generic callback', () {
      final plan = socialAuthRoutePlan({AuthProvider.google});

      expect(plan.flutterWebAuth2Callback, isTrue);
      expect(plan.appleRoutes, isFalse);
    });

    test('microsoft alone mounts only the generic callback', () {
      final plan = socialAuthRoutePlan({AuthProvider.microsoft});

      expect(plan.flutterWebAuth2Callback, isTrue);
      expect(plan.appleRoutes, isFalse);
    });

    test('facebook alone mounts no redirect route', () {
      // Facebook's login verifies an access token; it never redirects back to
      // the server, so it needs neither route.
      final plan = socialAuthRoutePlan({AuthProvider.facebook});

      expect(plan.flutterWebAuth2Callback, isFalse);
      expect(plan.appleRoutes, isFalse);
    });

    test('google plus apple mounts both route groups', () {
      final plan = socialAuthRoutePlan({
        AuthProvider.google,
        AuthProvider.apple,
      });

      expect(plan.flutterWebAuth2Callback, isTrue);
      expect(plan.appleRoutes, isTrue);
    });

    test('no provider enabled mounts nothing', () {
      final plan = socialAuthRoutePlan(const {});

      expect(plan.flutterWebAuth2Callback, isFalse);
      expect(plan.appleRoutes, isFalse);
    });
  });

  group('social auth route paths', () {
    test('match the paths documented for operators and provider consoles', () {
      expect(flutterWebAuth2CallbackPath, '/auth/callback');
      expect(appleWebAuthenticationCallbackPath, '/auth/apple/callback');
      expect(appleRevokedNotificationPath, '/auth/apple/revoked');
    });
  });
}
