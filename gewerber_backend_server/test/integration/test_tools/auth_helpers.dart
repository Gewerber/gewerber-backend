import 'package:gewerber_backend_server/src/core/di/service_locator.dart';
import 'package:gewerber_backend_server/src/core/mail/email_template.dart';
import 'package:gewerber_backend_server/src/core/mail/mail_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'serverpod_test_tools.dart';

/// Deterministic verification codes used by [configureTestAuthServices].
///
/// Tests capture the code actually handed to the MailService callback (via
/// [CapturingMailService]) — the fixed values only exist so that failure
/// paths have a guaranteed-distinct "wrong code" to use without gambling on
/// randomness.
const String testRegistrationVerificationCode = '24681357';
const String testPasswordResetVerificationCode = '13572468';

/// A code that never matches any generated verification code.
const String wrongVerificationCode = '99999999';

/// A [MailService] fake that captures verification codes per template instead
/// of sending anything.
///
/// Both email IdP callbacks (registration + password reset) route through
/// `MailService.sendVerificationCode` with a distinct [EmailTemplate], so the
/// template key is enough to tell the two callback contexts apart.
class CapturingMailService implements MailService {
  final Map<EmailTemplate, String> capturedCodes = {};

  /// The code captured for [template], or `null` if no email was sent.
  String? codeFor(EmailTemplate template) => capturedCodes[template];

  @override
  Future<MailSendStatus> sendVerificationCode(
    Session session, {
    required String email,
    required String verificationCode,
    required EmailTemplate template,
  }) async {
    capturedCodes[template] = verificationCode;
    return MailSendStatus.loggedOnly;
  }

  @override
  Future<MailSendStatus> sendPaymentReminder(
    Session session, {
    required String toEmail,
    required String customerName,
    required String businessName,
    required String invoiceNumber,
    required int level,
    required String formattedAmount,
    required DateTime dueDate,
  }) async {
    return MailSendStatus.loggedOnly;
  }
}

/// Runs [body] with a [CapturingMailService] shadowing the real MailService
/// in a pushed getIt scope (popped in `finally`).
///
/// The email IdP callbacks resolve `getIt<MailService>()` at call time, so
/// the fake is picked up for every verification email sent inside [body].
Future<T> withCapturingMailService<T>(
  Future<T> Function(CapturingMailService mail) body,
) async {
  final mail = CapturingMailService();
  getIt.pushNewScope();
  getIt.registerSingleton<MailService>(mail);
  try {
    return await body(mail);
  } finally {
    await getIt.popScope();
  }
}

/// Initializes the global `AuthServices` with the same providers as
/// `lib/server.dart` (JWT token manager + email IdP), but:
/// - with deterministic verification codes instead of random ones, and
/// - with the verification-email callbacks resolving MailService from getIt
///   at call time, so tests can shadow it via [withCapturingMailService].
///
/// Must be called after the test Serverpod instance has started (the
/// `*FromPasswords` configs read `config/passwords.yaml` through
/// `Serverpod.instance`), i.e. in a `setUpAll` registered inside the
/// `withServerpod` group.
void configureTestAuthServices() {
  AuthServices.set(
    tokenManagerBuilders: [JwtConfigFromPasswords()],
    identityProviderBuilders: [
      EmailIdpConfigFromPasswords(
        registrationVerificationCodeGenerator: () =>
            testRegistrationVerificationCode,
        passwordResetVerificationCodeGenerator: () =>
            testPasswordResetVerificationCode,
        sendRegistrationVerificationCode:
            (
              session, {
              required email,
              required accountRequestId,
              required verificationCode,
              required transaction,
            }) async {
              await getIt<MailService>().sendVerificationCode(
                session,
                email: email,
                verificationCode: verificationCode,
                template: EmailTemplate.registrationVerification,
              );
            },
        sendPasswordResetVerificationCode:
            (
              session, {
              required email,
              required passwordResetRequestId,
              required verificationCode,
              required transaction,
            }) async {
              await getIt<MailService>().sendVerificationCode(
                session,
                email: email,
                verificationCode: verificationCode,
                template: EmailTemplate.passwordResetVerification,
              );
            },
      ),
    ],
  );
}

/// Registers a new user through the email IdP endpoints
/// (startRegistration → verifyRegistrationCode → finishRegistration) and
/// returns the resulting [AuthSuccess].
///
/// The verification code is taken from the captured registration email —
/// this proves the sendRegistrationVerificationCode callback wiring end to
/// end. Mail delivery failures are ignored; only the captured code matters
/// here.
Future<AuthSuccess> registerTestUser(
  TestSessionBuilder sessionBuilder,
  TestEndpoints endpoints, {
  required String email,
  required String password,
}) {
  return withCapturingMailService((mail) async {
    final accountRequestId = await endpoints.emailIdp.startRegistration(
      sessionBuilder,
      email: email,
    );

    final code = mail.codeFor(EmailTemplate.registrationVerification);
    if (code == null) {
      throw StateError(
        'Registration verification email was not sent for $email — the '
        'sendRegistrationVerificationCode callback did not run.',
      );
    }

    final registrationToken = await endpoints.emailIdp.verifyRegistrationCode(
      sessionBuilder,
      accountRequestId: accountRequestId,
      verificationCode: code,
    );

    return endpoints.emailIdp.finishRegistration(
      sessionBuilder,
      registrationToken: registrationToken,
      password: password,
    );
  });
}
