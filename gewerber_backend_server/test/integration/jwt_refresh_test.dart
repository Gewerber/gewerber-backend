@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';

import 'test_tools/auth_helpers.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  setUpAll(() async {
    // AuthServices is initialized per test isolate (the test server does not
    // run lib/server.dart's `run`), after the test Serverpod has started so
    // that the `*FromPasswords` configs can read config/passwords.yaml.
    configureTestAuthServices();
  });

  setUpAll(() async {
    await configureDependencies();
  });

  // NOTE: RollbackDatabase.afterEach (the default) forbids the nested
  // session.db.transaction calls the JWT rotation makes internally
  // (rotateRefreshToken runs in its own transaction, and the rate limiter of
  // the email IdP used for registration does the same). Therefore this group
  // runs with rollbacks disabled — withServerpod still provisions a fresh,
  // private database per group and drops it afterwards, and every test uses
  // its own unique email so the tests stay independent despite the shared
  // database.
  withServerpod('Given JwtRefreshEndpoint', (sessionBuilder, endpoints) {
    const password = 'Sicheres!Passwort1';

    test(
      'when refreshing with a valid refresh token then a new token pair is '
      'issued and the new access token authenticates the user',
      () async {
        const email = 'refresh@example.de';
        final registration = await registerTestUser(
          sessionBuilder,
          endpoints,
          email: email,
          password: password,
        );

        // A business so that listMine below has something to return.
        final businessSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            registration.authUserId.uuid,
            {},
          ),
        );
        final business = await endpoints.business.create(
          businessSession,
          CreateBusinessRequest(name: 'Mein Gewerbe'),
        );

        final login = await endpoints.emailIdp.login(
          sessionBuilder,
          email: email,
          password: password,
        );

        final refreshed = await endpoints.jwtRefresh.refreshAccessToken(
          sessionBuilder,
          refreshToken: login.refreshToken!,
        );

        expect(refreshed.authStrategy, login.authStrategy);
        expect(refreshed.authUserId, login.authUserId);
        expect(refreshed.token, isNot(login.token));
        expect(refreshed.tokenExpiresAt, isNotNull);
        // Automatic token rotation: the refresh token is replaced on every
        // refresh, the old value must never be returned again.
        expect(refreshed.refreshToken, isNotNull);
        expect(refreshed.refreshToken, isNot(login.refreshToken));

        // The test tools have no HTTP layer that would carry the bearer
        // token, so the token itself is validated through the framework's
        // authentication handler: it must resolve the new access token to
        // the registered user's identity.
        final session = sessionBuilder.build();
        final authInfo = await AuthServices.instance.authenticationHandler(
          session,
          refreshed.token,
        );
        expect(authInfo, isNotNull);
        expect(authInfo!.userIdentifier, registration.authUserId.uuid);

        // Authenticated business calls work with the refreshed identity —
        // same userIdentifier the real token handler would produce.
        final refreshedSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            authInfo.userIdentifier,
            {},
          ),
        );
        final mine = await endpoints.business.listMine(refreshedSession);
        expect(mine.map((b) => b.id), contains(business.id));
      },
    );

    test(
      'when refreshing with a garbage refresh token then it throws',
      () async {
        await expectLater(
          () => endpoints.jwtRefresh.refreshAccessToken(
            sessionBuilder,
            refreshToken: 'not-a-real-refresh-token',
          ),
          throwsA(isA<RefreshTokenMalformedException>()),
        );
      },
    );

    test(
      'when reusing a rotated-out refresh token then it is rejected and '
      'the whole token chain is revoked',
      () async {
        const reuseEmail = 'rotation-reuse@example.de';
        await registerTestUser(
          sessionBuilder,
          endpoints,
          email: reuseEmail,
          password: password,
        );
        final login = await endpoints.emailIdp.login(
          sessionBuilder,
          email: reuseEmail,
          password: password,
        );
        final firstRefreshToken = login.refreshToken!;

        final refreshed = await endpoints.jwtRefresh.refreshAccessToken(
          sessionBuilder,
          refreshToken: firstRefreshToken,
        );
        expect(refreshed.refreshToken, isNot(firstRefreshToken));

        // Automatic token rotation semantics (actual serverpod_auth behavior,
        // pinned here): every successful refresh replaces the rotating secret
        // of the underlying refresh-token row, so the previously issued
        // refresh token becomes invalid immediately. Replaying the rotated-
        // out token does not match the stored secret anymore and is treated
        // as a possible token theft: the server answers with
        // RefreshTokenInvalidSecretException and DELETES the refresh-token
        // row as an anti-replay measure.
        await expectLater(
          () => endpoints.jwtRefresh.refreshAccessToken(
            sessionBuilder,
            refreshToken: firstRefreshToken,
          ),
          throwsA(isA<RefreshTokenInvalidSecretException>()),
        );

        // Because the reuse detection deleted the underlying row, the
        // replacement refresh token issued by the rotation above is dead as
        // well: refreshing with it now fails with a not-found error.
        await expectLater(
          () => endpoints.jwtRefresh.refreshAccessToken(
            sessionBuilder,
            refreshToken: refreshed.refreshToken,
          ),
          throwsA(isA<RefreshTokenNotFoundException>()),
        );
      },
    );
  }, rollbackDatabase: RollbackDatabase.disabled);
}
