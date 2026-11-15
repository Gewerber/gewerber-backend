import 'dart:collection';
import 'dart:io' show stdout;

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/apple.dart';

import '../generated/protocol.dart';

/// Generic, provider-agnostic `flutter_web_auth_2` callback path, served by
/// [FlutterWebAuth2CallbackRoute].
///
/// Used by the OAuth2 PKCE providers that redirect the browser back to a URI
/// supplied by the Flutter app (Google and Microsoft). Facebook is not in that
/// group: `FacebookIdp.login` verifies an access token obtained natively, so it
/// never redirects through this route.
///
/// **The route must be served from the same origin as the Flutter web app**
/// (see [FlutterWebAuth2CallbackRoute]): the callback page hands the OAuth
/// result to the app window with `window.postMessage(..., origin)`, which
/// browsers only deliver across matching scheme + host + port. If the app is
/// hosted separately (e.g. `app.gewerber.de` while this server answers on
/// `api.gewerber.de`), the app must serve the `auth.html` file shipped by
/// `flutter_web_auth_2` instead, or the app host has to proxy this path.
const String flutterWebAuth2CallbackPath = '/auth/callback';

/// Apple's web/Android authentication callback path.
///
/// Apple POSTs here; the route redirects the browser to the configured
/// `appleWebRedirectUri` (or the Android intent URI), so it does not need the
/// generic `flutter_web_auth_2` callback page.
const String appleWebAuthenticationCallbackPath = '/auth/apple/callback';

/// Apple's server-to-server revocation notification hook path. Apple POSTs
/// consent-revoked and account-deleted notifications here.
const String appleRevokedNotificationPath = '/auth/apple/revoked';

/// The web routes [registerSocialAuthRoutes] mounts for a set of enabled
/// social providers.
///
/// Kept separate from the registration so the decision is testable without a
/// live [Serverpod] instance (whose `webServer` has no public route listing).
typedef SocialAuthRoutePlan = ({
  /// Mount [FlutterWebAuth2CallbackRoute] at [flutterWebAuth2CallbackPath].
  bool flutterWebAuth2Callback,

  /// Mount Apple's callback and revocation routes via
  /// `Serverpod.configureAppleIdpRoutes`.
  bool appleRoutes,
});

/// The routes implied by [enabled].
///
/// Apple is deliberately excluded from [SocialAuthRoutePlan.flutterWebAuth2Callback]:
/// its `AppleWebAuthenticationCallbackRoute` redirects to `appleWebRedirectUri`
/// itself and never serves the `flutter_web_auth_2` page, so an Apple-only
/// deployment must not mount `/auth/callback`.
SocialAuthRoutePlan socialAuthRoutePlan(Set<AuthProvider> enabled) => (
  flutterWebAuth2Callback:
      enabled.contains(AuthProvider.google) ||
      enabled.contains(AuthProvider.microsoft),
  appleRoutes: enabled.contains(AuthProvider.apple),
);

/// Servers already wired by [registerSocialAuthRoutes].
///
/// Boot runs this once; the guard keeps a second call (e.g. a test or a
/// restart path re-running the boot sequence) from adding duplicate Relic
/// routes, where the second registration would be unreachable.
final Set<Serverpod> _registeredPods = HashSet<Serverpod>.identity();

/// Mounts the OAuth callback routes for the enabled social identity providers.
///
/// Must be called after `Serverpod.initializeAuthServices` (Apple's route
/// factory resolves `AuthServices.instance.appleIdp`) and before
/// `Serverpod.start` (the Relic web server binds its routes when it starts).
///
/// Registers nothing when no redirect-based provider is enabled. Logs the
/// mounted paths so operators can check them against the provider consoles.
void registerSocialAuthRoutes(Serverpod pod, Set<AuthProvider> enabled) {
  if (!_registeredPods.add(pod)) {
    stdout.writeln('[auth] oauth routes: already registered for this server');
    return;
  }

  final plan = socialAuthRoutePlan(enabled);
  if (!plan.flutterWebAuth2Callback && !plan.appleRoutes) {
    stdout.writeln('[auth] oauth routes: none (no redirect-based provider)');
    return;
  }

  if (pod.config.webServer == null) {
    // Without a `webServer` section in the runtime config no Relic web server
    // is created and `pod.webServer` throws. The providers stay registered,
    // but their redirect URIs cannot resolve; surface the misconfiguration
    // instead of crashing startup.
    stdout.writeln(
      '[auth] oauth routes: not mounted — web server disabled (add a '
      '`webServer` section to the runtime config for social sign-in redirects)',
    );
    return;
  }

  if (plan.flutterWebAuth2Callback) {
    pod.webServer.addRoute(
      FlutterWebAuth2CallbackRoute(),
      flutterWebAuth2CallbackPath,
    );
    stdout.writeln(
      '[auth] oauth route: GET $flutterWebAuth2CallbackPath '
      '(flutter_web_auth_2 callback)',
    );
  }

  if (plan.appleRoutes) {
    pod.configureAppleIdpRoutes(
      webAuthenticationCallbackRoutePath: appleWebAuthenticationCallbackPath,
      revokedNotificationRoutePath: appleRevokedNotificationPath,
    );
    stdout.writeln(
      '[auth] oauth routes: POST $appleWebAuthenticationCallbackPath '
      '(apple callback), POST $appleRevokedNotificationPath '
      '(apple notifications)',
    );
  }
}
