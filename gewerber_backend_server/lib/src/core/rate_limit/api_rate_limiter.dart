import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../../generated/protocol.dart';

/// Operations guarded by API rate limiting (issue #54).
///
/// Budgets are rolling windows per key (see [ApiRateLimiter]): generous
/// enough for legitimate interactive use, tight enough to blunt abuse loops
/// against CPU- or I/O-expensive endpoints (PDF rendering, full-table
/// exports, SMTP sends).
///
/// Out of scope here by design:
/// - Authentication endpoints are already throttled inside the
///   `serverpod_auth_idp` module (account creation, login, password reset use
///   their own [DatabaseRateLimiter] instances).
/// - The public `waitlist.join` endpoint lives in the closed-source
///   commercial module and must be throttled there.
enum RateLimitedOperation {
  /// Invoice PDF rendering (`invoice.generatePdf`).
  invoicePdf('invoice_pdf', maxAttempts: 30, timeframe: Duration(minutes: 10)),

  /// XRechnung XML export (`invoice.exportXrechnung`).
  xrechnungExport(
    'invoice_xrechnung',
    maxAttempts: 30,
    timeframe: Duration(minutes: 10),
  ),

  /// Tabular invoice exports (`invoice.exportCsv`, `invoice.exportJson`).
  invoiceExport(
    'invoice_export',
    maxAttempts: 20,
    timeframe: Duration(minutes: 10),
  ),

  /// Payment reminder sends (`reminder.send`, triggers SMTP delivery).
  reminderSend(
    'reminder_send',
    maxAttempts: 10,
    timeframe: Duration(minutes: 10),
  );

  const RateLimitedOperation(
    this.source, {
    required this.maxAttempts,
    required this.timeframe,
  });

  /// The `source` namespace stored in `RateLimitedRequestAttempt` rows.
  final String source;

  /// Maximum admitted attempts per key within [timeframe].
  final int maxAttempts;

  /// Rolling window for counting attempts.
  final Duration timeframe;
}

/// Builds the limiter key for a caller.
///
/// Authenticated callers are keyed by user (`user:<userIdentifier>`) so the
/// budget follows the account across IPs and NATs; anonymous callers fall
/// back to `ip:<address>`. Pure function so it stays unit-testable without
/// a [Session].
String buildRateLimitKey({String? userIdentifier, String? ipAddress}) {
  final user = userIdentifier?.trim();
  if (user != null && user.isNotEmpty) return 'user:$user';
  final ip = (ipAddress ?? '').trim();
  return 'ip:${ip.isEmpty ? 'unknown' : ip}';
}

/// Per-IP/per-user rate limiting for expensive endpoints (issue #54).
///
/// Backed by the `serverpod_auth_idp` [DatabaseRateLimiter] (rows in the
/// existing `serverpod_auth_idp_rate_limited_request_attempt` table, domain
/// `gewerber`), so budgets survive restarts and are enforced consistently
/// across replicas. Rejected callers get a [RateLimitException].
@singleton
class ApiRateLimiter {
  /// Namespace isolating Gewerber's own limits from the auth module's.
  static const String domain = 'gewerber';

  /// Admits one attempt for [operation] or throws [RateLimitException].
  Future<void> check(Session session, RateLimitedOperation operation) async {
    final userIdentifier = session.authenticated?.userIdentifier;
    final ip =
        session.request?.connectionInfo.remote.address.toString() ?? 'unknown';
    final key = buildRateLimitKey(
      userIdentifier: userIdentifier,
      ipAddress: ip,
    );

    final limiter = DatabaseRateLimiter(
      RateLimiterConfig(
        domain: domain,
        source: operation.source,
        maxAttempts: operation.maxAttempts,
        timeframe: operation.timeframe,
      ),
    );

    final admitted = await limiter.tryRecordAttempt(
      session,
      key: key,
      extraData: {'ip': ip},
    );
    if (!admitted) {
      throw RateLimitException(
        message:
            'Too many requests for ${operation.source}. '
            'Try again in ${operation.timeframe.inSeconds} seconds.',
        retryAfterSeconds: operation.timeframe.inSeconds,
      );
    }
  }
}
