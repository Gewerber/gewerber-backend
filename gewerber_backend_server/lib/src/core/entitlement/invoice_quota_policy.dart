import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../di/injection.dart';
import '../di/service_locator.dart';
import 'entitlement_provider.dart';

/// Free-tier invoice quota policy.
///
/// Small commercial-surface helper: it answers *whether* invoice creation is
/// quota-limited for a user and *what the monthly limit is*, but it never
/// touches the database — counting and enforcement live in the invoicing
/// module (core must not depend on modules).
///
/// Everything here is inert unless the deployment opted into commercial
/// entitlements via [commercialEntitlementsEnabled] (env var
/// `GEWERBER_COMMERCIAL_ENTITLEMENTS=true`, the same flag that swaps the
/// [EntitlementProvider] DI binding). With the flag off — the default for
/// every self-hosted OSS build — [enforcementEnabled] is `false` and callers
/// must skip the quota check entirely (no extra queries, behavior identical
/// to pre-quota releases).
@singleton
class InvoiceQuotaPolicy {
  /// Production constructor: reads the process environment and applies the
  /// documented [defaultFreeMonthlyInvoiceLimit].
  InvoiceQuotaPolicy() : this._(environment: Platform.environment);

  /// Test-only constructor: injects a fake [environment] map (and optionally
  /// a [defaultFreeMonthlyLimit]) so the flag/limit lookups can be exercised
  /// without touching the real process environment. Never referenced by the
  /// injectable-generated wiring (which uses the default constructor).
  InvoiceQuotaPolicy.test({
    required Map<String, String> environment,
    int defaultFreeMonthlyLimit = defaultFreeMonthlyInvoiceLimit,
  }) : this._(
         environment: environment,
         defaultFreeMonthlyLimit: defaultFreeMonthlyLimit,
       );

  InvoiceQuotaPolicy._({
    required this._environment,
    this.defaultFreeMonthlyLimit = defaultFreeMonthlyInvoiceLimit,
  });

  /// Owner-confirmed OSS default: free-tier users may create this many
  /// invoices per calendar month when commercial entitlements are enforced.
  /// Deployment-tunable via [freeInvoiceLimitEnvVar] without code changes.
  static const int defaultFreeMonthlyInvoiceLimit = 3;

  /// Environment variable overriding [defaultFreeMonthlyInvoiceLimit] with an
  /// integer (e.g. `GEWERBER_FREE_INVOICE_LIMIT=5`). Invalid or unset values
  /// fall back to the documented default.
  static const String freeInvoiceLimitEnvVar = 'GEWERBER_FREE_INVOICE_LIMIT';

  /// Commercial capability key that lifts the quota entirely. It has no OSS
  /// [Feature] enum equivalent by design (a numeric limit is not a
  /// capability); it is queried through
  /// [EntitlementProvider.hasCapability] instead.
  static const String unlimitedInvoicesCapability = 'unlimited_invoices';

  /// Fallback monthly limit used when the env override is absent or not a
  /// valid integer.
  final int defaultFreeMonthlyLimit;

  final Map<String, String> _environment;

  /// Parsed once (lazy, immutable after first read).
  late final int? _envLimitOverride = int.tryParse(
    _environment[freeInvoiceLimitEnvVar] ?? '',
  );

  /// Whether quota enforcement is active for this process — the exact same
  /// flag that swaps in the [CommercialEntitlementProvider] (see
  /// `core/di/injection.dart`). Callers must check this *before* any quota
  /// work so that OSS builds run zero extra queries.
  bool get enforcementEnabled => commercialEntitlementsEnabled(_environment);

  /// The monthly limit granted to free-tier users, honoring the
  /// [freeInvoiceLimitEnvVar] override. Values `<= 0` are treated as "no
  /// override" (a zero quota would brick the deployment).
  int get configuredFreeMonthlyLimit {
    final override = _envLimitOverride;
    if (override == null || override <= 0) return defaultFreeMonthlyLimit;
    return override;
  }

  /// Monthly invoice limit for [userId] (optionally scoped to a
  /// [businessId]), or `null` when the user is unlimited.
  ///
  /// Returns `null` when the active [EntitlementProvider] grants the
  /// [unlimitedInvoicesCapability] (paid plans via the commercial provider;
  /// *every* user in the OSS all-features build). Otherwise the free-tier
  /// limit from [configuredFreeMonthlyLimit].
  ///
  /// Only meaningful when [enforcementEnabled] is `true`.
  Future<int?> monthlyInvoiceLimit(
    Session session, {
    required UuidValue userId,
    int? businessId,
  }) async {
    final provider = getIt<EntitlementProvider>();
    if (await provider.hasCapability(
      session,
      capability: unlimitedInvoicesCapability,
      userId: userId,
      businessId: businessId,
    )) {
      return null;
    }
    return configuredFreeMonthlyLimit;
  }
}
