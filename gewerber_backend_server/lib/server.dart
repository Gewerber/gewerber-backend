import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'src/core/di/injection.dart';
import 'src/core/di/service_locator.dart';
import 'src/core/mail/email_template.dart';
import 'src/core/mail/mail_service.dart';
import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(args, Protocol(), Endpoints());

  await configureDependencies();

  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      // Use JWT for authentication keys towards the server.
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      // Configure the email identity provider for email/password authentication.
      // Verification codes are sent by MailService via SMTP (settings read from
      // `config/passwords.yaml`). If no SMTP host is configured, the codes are
      // only logged, which keeps the flow usable in local development.
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode:
            (
              session, {
              required email,
              required accountRequestId,
              required verificationCode,
              required transaction,
            }) {
              return getIt<MailService>().sendVerificationCode(
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
            }) {
              return getIt<MailService>().sendVerificationCode(
                session,
                email: email,
                verificationCode: verificationCode,
                template: EmailTemplate.passwordResetVerification,
              );
            },
      ),
    ],
  );

  // Start the server.
  await pod.start();
}
