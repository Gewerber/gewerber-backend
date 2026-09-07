import 'dart:async';
import 'dart:io';
import 'dart:math';

// The commercial module exposes the PayPal billing surface (webhook route,
// gateway factory, reconciliation job) under `src/` only; they are
// module-internal services, not part of its public API.
// ignore: implementation_imports
import 'package:gewerber_backend_commercial_server/src/modules/subscription/payments/payment_gateway.dart';
// ignore: implementation_imports
import 'package:gewerber_backend_commercial_server/src/modules/subscription/payments/paypal_gateway_factory.dart';
// ignore: implementation_imports
import 'package:gewerber_backend_commercial_server/src/modules/subscription/payments/paypal_webhook_route.dart';
// ignore: implementation_imports
import 'package:gewerber_backend_commercial_server/src/modules/subscription/services/paypal_reconciliation_job.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'src/core/di/injection.dart';
import 'src/core/di/service_locator.dart';
import 'src/core/mail/email_template.dart';
import 'src/core/mail/mail_service.dart';
import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/modules/invoicing/jobs/invoicing_job_scheduler.dart';

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
        registrationVerificationCodeGenerator: _generateVerificationCode,
        passwordResetVerificationCodeGenerator: _generateVerificationCode,
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

  // PayPal billing wiring (commercial deployments only; a complete no-op in
  // the OSS default configuration). Runs before `pod.start()` because the
  // Relic-based web server binds its routes when it starts.
  await _wirePayPalBilling(pod);

  // Start the server.
  await pod.start();

  // Background jobs: materialize due recurring invoices and mark overdue
  // invoices periodically.
  await const InvoicingJobScheduler().ensureScheduled(pod.futureCalls);
}

/// Length of the email verification codes (registration + password reset).
/// 8 digits give 10^8 combinations — brute-force resistant enough for a
/// rate-limited, expiring code without being unreadable for users.
///
/// Contract: the client app (gewerber-app) must accept codes of this exact
/// length. The value is mirrored in `AppConstants.verificationCodeLength`
/// in the app, but the two packages cannot share a Dart import.
const int _verificationCodeLength = 8;

/// Generates a numeric verification code of [_verificationCodeLength]
/// digits. The code length is set here because the email IdP takes the
/// generator function as configuration (the IdP default is also 8 digits;
/// keeping an explicit generator documents the contract).
String _generateVerificationCode() {
  const digits = '0123456789';
  final random = Random.secure();
  return String.fromCharCodes(
    Iterable.generate(
      _verificationCodeLength,
      (_) => digits.codeUnitAt(random.nextInt(digits.length)),
    ),
  );
}

/// How often the PayPal reconciliation sweep runs (safety net for lost or
/// never-delivered webhooks). Matches the hourly cadence of the invoicing
/// future calls.
const Duration _paypalReconciliationInterval = Duration(hours: 1);

/// Mounts the commercial PayPal webhook route and schedules the
/// reconciliation sweep.
///
/// Bit-identical no-op in the OSS default configuration: gated by the same
/// [commercialEntitlementsEnabled] flag as the `EntitlementProvider` DI swap
/// (see `src/core/di/injection.dart`), so self-hosted deployments without the
/// commercial env var never mount a route or start a timer. When the flag is
/// on but `PAYPAL_CLIENT_ID` / `PAYPAL_CLIENT_SECRET` are unset
/// ([PayPalGatewayFactory.maybeFromEnv] returns `null`), billing is simply
/// not configured: one info line is logged and nothing is wired.
///
/// The route must be added before [Serverpod.start] (the web server binds
/// routes at start). The reconciler runs on its own [Timer.periodic] — not a
/// Serverpod future call — because the job lives in the commercial module's
/// `src/` and is not registered in the OSS generated future-call protocol;
/// the timer is cancelled via the experimental shutdown-task hook.
Future<void> _wirePayPalBilling(Serverpod pod) async {
  if (!commercialEntitlementsEnabled()) return;

  final gateway = PayPalGatewayFactory.maybeFromEnv();
  if (gateway == null) {
    await pod.withSession(
      (session) async => session.log('PayPal billing not configured'),
    );
    return;
  }

  if (pod.config.webServer == null) {
    // Without a `web` section in the runtime config the Relic web server is
    // never created and `pod.webServer` would throw; PayPal can then not
    // reach this server at all, so surface the misconfiguration instead of
    // crashing startup. The reconciler below still runs as the safety net.
    await pod.withSession(
      (session) async => session.log(
        'PayPal gateway configured but the web server is disabled: the '
        'webhook route is not mounted. Add a `web` section to the runtime '
        'config to receive PayPal webhooks; the reconciliation sweep still '
        'runs as a safety net.',
        level: LogLevel.warning,
      ),
    );
  } else {
    pod.webServer.addRoute(
      PayPalWebhookRouteHandler(gatewayFactory: () => gateway),
      '/commercial/paypal/webhook',
    );
  }

  final reconciler = Timer.periodic(_paypalReconciliationInterval, (_) {
    unawaited(_runPayPalReconciliation(pod, gateway));
  });
  pod.experimental.shutdownTasks.addTask(
    'paypal-reconciliation-timer',
    () async => reconciler.cancel(),
  );
}

/// Runs one [reconcileStalePendingSubscriptions] sweep on a fresh internal
/// session (created and closed per run via [Serverpod.withSession], the
/// Serverpod 4 idiom for database work outside a request).
Future<void> _runPayPalReconciliation(
  Serverpod pod,
  PaymentGateway gateway,
) async {
  try {
    await pod.withSession((session) async {
      final report = await reconcileStalePendingSubscriptions(
        session,
        gateway,
      );
      session.log('PayPal reconciliation finished: $report');
    });
  } catch (error, stackTrace) {
    // `withSession` itself failed (e.g. the database is unreachable) — there
    // is no session to log through, so fall back to stderr. The next hourly
    // tick retries.
    stderr.writeln('PayPal reconciliation run failed: $error');
    stderr.writeln(stackTrace);
  }
}
