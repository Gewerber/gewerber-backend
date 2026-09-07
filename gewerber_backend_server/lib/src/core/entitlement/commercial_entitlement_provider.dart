// The commercial module (real and stub) exposes the source contract under
// `src/` only; it is a module-internal service, not part of its public API.
// ignore: implementation_imports
import 'package:gewerber_backend_commercial_server/src/modules/subscription/services/commercial_entitlement_source.dart';
import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../tenant/tenant_context.dart';
import 'entitlement_provider.dart';

/// Commercial (SaaS) binding for [EntitlementProvider].
///
/// Adapts a [CommercialEntitlementSource] (backed by the closed-source
/// subscription tables) to the OSS [EntitlementProvider] contract: it resolves
/// the plan feature keys granted to the tenant's user and maps them onto the
/// OSS [Feature] enum. Registered in place of [AllFeaturesEntitlementProvider]
/// only when the `GEWERBER_COMMERCIAL_ENTITLEMENTS=true` environment variable
/// is set (see `core/di/injection.dart`); self-hosted OSS deployments never
/// construct this class.
///
/// ### Feature-key mapping
///
/// The commercial plan definitions use their own key vocabulary. Keys are
/// mapped explicitly (never by dynamic enum lookup) so that a plan rename on
/// the commercial side can never crash the core:
///
/// | Commercial key     | OSS [Feature]            |
/// |--------------------|--------------------------|
/// | `invoicing`        | `Feature.invoicing`      |
/// | `time_tracking`    | `Feature.time_tracking`  |
/// | `basic_accounting` | `Feature.accounting`     |
/// | `guidance`         | `Feature.guidance`       |
/// | `multi_currency`   | `Feature.multi_currency` |
/// | `banking`          | `Feature.banking`        |
/// | `employees`        | `Feature.employees`      |
///
/// Keys without an OSS enum equivalent (`unlimited_invoices`, `no_branding`,
/// `exports`, `payments`, `payroll`, `multi_user`) are commercial-only
/// concepts: they are skipped — logged once per key, never thrown. The OSS
/// enum is deliberately not extended here; gating those extras happens inside
/// the commercial module.
///
/// ### Fail-open on source errors
///
/// If the [CommercialEntitlementSource] itself throws (e.g. the commercial
/// subscription DB is unreachable), [featuresFor] logs a warning and returns
/// the same feature set as the OSS default [AllFeaturesEntitlementProvider]
/// (all [Feature] values) instead of propagating the error. Rationale: an
/// outage of commercial infrastructure must never take down the entitlement
/// endpoint for SaaS users or degrade them below what a self-hosted OSS
/// deployment gets by default; entitlements are a convenience gate, not a
/// security boundary.
class CommercialEntitlementProvider implements EntitlementProvider {
  /// Creates the provider.
  ///
  /// [sourceFactory] builds the session-scoped [CommercialEntitlementSource]
  /// for each call; it defaults to the database-backed
  /// [DbCommercialEntitlementSource] shipped with the commercial module and is
  /// injectable for tests.
  CommercialEntitlementProvider({
    this.sourceFactory = DbCommercialEntitlementSource.new,
  });

  /// Builds the [CommercialEntitlementSource] used for a given request
  /// session (the source itself is session-scoped, the provider is not).
  final CommercialEntitlementSource Function(Session session) sourceFactory;

  /// Explicit mapping from commercial plan feature keys to OSS [Feature]
  /// values. Keys not listed here are commercial-only and get skipped.
  static const Map<String, Feature> featureByKey = {
    'invoicing': Feature.invoicing,
    'time_tracking': Feature.time_tracking,
    'basic_accounting': Feature.accounting,
    'guidance': Feature.guidance,
    'multi_currency': Feature.multi_currency,
    'banking': Feature.banking,
    'employees': Feature.employees,
  };

  /// Feature keys already reported as unknown via [session] logging, so that
  /// a misconfigured plan produces one warning per key instead of one per
  /// request. (Also used to reset state from unit tests.)
  static final Set<String> loggedUnknownKeys = <String>{};

  @override
  Future<bool> hasCapability(
    Session session, {
    required String capability,
    required UuidValue userId,
    int? businessId,
  }) async {
    final source = sourceFactory(session);
    try {
      // Checks the *raw* commercial key set (before the [Feature] mapping), so
      // commercial-only capabilities like `unlimited_invoices` — which have no
      // OSS enum equivalent and are skipped by [featuresFor] — remain queryable
      // without extending the OSS vocabulary.
      final keys = await source.featuresFor(
        userId: userId,
        businessId: businessId,
      );
      return keys.contains(capability);
    } catch (error, stackTrace) {
      // Fail-open, mirroring [featuresFor]: an outage of commercial
      // infrastructure must never degrade users below the OSS baseline (where
      // every capability is granted).
      session.log(
        '[CommercialEntitlementProvider] Commercial entitlement source '
        'failed; failing open for capability "$capability".',
        level: LogLevel.warning,
        exception: error,
        stackTrace: stackTrace,
      );
      return true;
    }
  }

  @override
  Future<Set<Feature>> featuresFor(
    Session session,
    TenantContext tenant,
  ) async {
    final source = sourceFactory(session);
    final Set<String> keys;
    try {
      keys = await source.featuresFor(
        userId: tenant.userId,
        businessId: tenant.businessId,
      );
    } catch (error, stackTrace) {
      // Fail-open: a commercial-infra outage (e.g. the subscription DB is
      // down) must never 500 the entitlement endpoint or degrade users below
      // the OSS baseline, so we log a warning and grant the same feature set
      // the default [AllFeaturesEntitlementProvider] would (all features).
      session.log(
        '[CommercialEntitlementProvider] Commercial entitlement source '
        'failed; failing open to the OSS default (all features enabled).',
        level: LogLevel.warning,
        exception: error,
        stackTrace: stackTrace,
      );
      return Feature.values.toSet();
    }
    return mapFeatureKeys(
      keys,
      onUnknownKey: (key) => session.log(
        '[CommercialEntitlementProvider] Feature key "$key" has no OSS '
        'Feature equivalent and was skipped.',
        level: LogLevel.warning,
      ),
    );
  }

  /// Maps commercial feature [keys] to the OSS [Feature] set.
  ///
  /// Unknown keys are skipped (never thrown) and reported once per key via
  /// [onUnknownKey]. Pure function exposed for unit testing without a live
  /// [Session].
  static Set<Feature> mapFeatureKeys(
    Iterable<String> keys, {
    void Function(String key)? onUnknownKey,
  }) {
    final features = <Feature>{};
    for (final key in keys) {
      final feature = featureByKey[key];
      if (feature != null) {
        features.add(feature);
        continue;
      }
      if (loggedUnknownKeys.add(key)) {
        onUnknownKey?.call(key);
      }
    }
    return features;
  }
}
