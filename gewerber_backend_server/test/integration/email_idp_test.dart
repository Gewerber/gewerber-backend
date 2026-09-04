@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/mail/email_template.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
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

  // NOTE: RollbackDatabase.afterEach (the default) forbids the nested
  // session.db.transaction calls the email IdP makes internally (the DB-backed
  // attempt rate limiter runs its attempt logging in a dedicated transaction
  // that must never roll back with the parent). Therefore this group runs with
  // rollbacks disabled — withServerpod still provisions a fresh, private
  // database per group and drops it afterwards, and every test uses its own
  // unique email so the tests stay independent despite the shared database.
  withServerpod(
    'Given EmailIdpEndpoint',
    (sessionBuilder, endpoints) {
      const password = 'Sicheres!Passwort1';
      test(
        'when registering through the full flow then login with the same '
        'password succeeds',
        () async {
          const email = 'register@example.de';
          final registration = await registerTestUser(
            sessionBuilder,
            endpoints,
            email: email,
            password: password,
          );

          expect(registration.authUserId, isNotNull);
          expect(registration.refreshToken, isNotNull);

          final login = await endpoints.emailIdp.login(
            sessionBuilder,
            email: email,
            password: password,
          );

          expect(login.authUserId, registration.authUserId);
        },
      );

      test(
        'when verifying a registration with a wrong code then it throws',
        () async {
          const email = 'wrong-code@example.de';
          await withCapturingMailService((mail) async {
            final accountRequestId = await endpoints.emailIdp.startRegistration(
              sessionBuilder,
              email: email,
            );

            expect(
              mail.codeFor(EmailTemplate.registrationVerification),
              isNotNull,
            );

            await expectLater(
              () => endpoints.emailIdp.verifyRegistrationCode(
                sessionBuilder,
                accountRequestId: accountRequestId,
                verificationCode: wrongVerificationCode,
              ),
              throwsA(
                isA<EmailAccountRequestException>().having(
                  (e) => e.reason,
                  'reason',
                  EmailAccountRequestExceptionReason.invalid,
                ),
              ),
            );
          });
        },
      );

      test(
        'when registering the same email twice then verification of the '
        'second request fails without leaking that the email exists',
        () async {
          const email = 'duplicate@example.de';
          await registerTestUser(
            sessionBuilder,
            endpoints,
            email: email,
            password: password,
          );

          // startRegistration deliberately does NOT throw for an already
          // registered email (anti account-enumeration): it returns a
          // decoy request ID, but no usable verification code is ever sent
          // for it, so the flow cannot be completed.
          final decoyRequestId = await endpoints.emailIdp.startRegistration(
            sessionBuilder,
            email: email,
          );

          // No mail goes out for the decoy request — the captured code stays
          // empty, which itself documents the "user cannot proceed" behavior.
          await withCapturingMailService((mail) async {
            await expectLater(
              () => endpoints.emailIdp.verifyRegistrationCode(
                sessionBuilder,
                accountRequestId: decoyRequestId,
                verificationCode: testRegistrationVerificationCode,
              ),
              throwsA(isA<EmailAccountRequestException>()),
            );
          });
        },
      );

      test(
        'when checking hasAccount then it flips from false to true',
        () async {
          const email = 'has-account@example.de';
          // An unauthenticated session is not associated with any email
          // account.
          expect(
            await endpoints.emailIdp.hasAccount(sessionBuilder),
            isFalse,
          );

          final registration = await registerTestUser(
            sessionBuilder,
            endpoints,
            email: email,
            password: password,
          );

          // The registered identity now has an email account attached.
          final registeredSession = sessionBuilder.copyWith(
            authentication: AuthenticationOverride.authenticationInfo(
              registration.authUserId.uuid,
              {},
            ),
          );
          expect(
            await endpoints.emailIdp.hasAccount(registeredSession),
            isTrue,
          );
        },
      );

      test(
        'when completing the password reset flow then the old password is '
        'rejected and the new one accepted',
        () async {
          const email = 'password-reset@example.de';
          await registerTestUser(
            sessionBuilder,
            endpoints,
            email: email,
            password: password,
          );

          final passwordResetRequestId = await withCapturingMailService((
            mail,
          ) async {
            final requestId = await endpoints.emailIdp.startPasswordReset(
              sessionBuilder,
              email: email,
            );

            final code = mail.codeFor(
              EmailTemplate.passwordResetVerification,
            );
            expect(code, isNotNull);

            return endpoints.emailIdp.verifyPasswordResetCode(
              sessionBuilder,
              passwordResetRequestId: requestId,
              verificationCode: code!,
            );
          });

          const newPassword = 'Neues!Sicheres2';
          await endpoints.emailIdp.finishPasswordReset(
            sessionBuilder,
            finishPasswordResetToken: passwordResetRequestId,
            newPassword: newPassword,
          );

          await expectLater(
            () => endpoints.emailIdp.login(
              sessionBuilder,
              email: email,
              password: password,
            ),
            throwsA(isA<EmailAccountLoginException>()),
          );

          final login = await endpoints.emailIdp.login(
            sessionBuilder,
            email: email,
            password: newPassword,
          );
          expect(login.authUserId, isNotNull);
        },
      );

      test(
        'when finishing a registration with a garbage token then it throws',
        () async {
          await expectLater(
            () => endpoints.emailIdp.finishRegistration(
              sessionBuilder,
              registrationToken: 'not-a-real-registration-token',
              password: password,
            ),
            throwsA(isA<EmailAccountRequestException>()),
          );
        },
      );
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}
