import 'package:gewerber_backend_commercial_server/gewerber_backend_commercial_server.dart'
    show CommercialEntitlementInstaller, CommercialEntitlementProvider;
import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../di/service_locator.dart';
import '../tenant/tenant_context.dart';
import 'entitlement_provider.dart';

// Re-exported so `core/di/injection.dart` has a single import touchpoint for
// both the host installer implementation and the module interface it
// implements (always the module's *public barrel*, never a `src/` path).
export 'package:gewerber_backend_commercial_server/gewerber_backend_commercial_server.dart'
    show CommercialEntitlementInstaller;

/// Maps OSS feature [names] (the `name` of each host `Feature` enum value) to
/// the host [Feature] set.
///
/// A `null` [names] is the commercial module's contractual *fail-open*
/// signal: the module could not resolve the tenant's entitlements (or grants
/// everything), so every OSS feature is enabled — the same result the default
/// [AllFeaturesEntitlementProvider] produces.
///
/// Names without a `Feature` equivalent are skipped and reported via
/// [onUnknownKey], never thrown. This preserves the guarantee of the former
/// OSS-side adapter that a plan/vocabulary rename on the commercial side can
/// never crash the core. The lookup map is built from `Feature.values`, so
/// the happy path involves no exception handling.
Set<Feature> featuresFromOssNames(
  Set<String>? names, {
  void Function(String name)? onUnknownKey,
}) {
  if (names == null) return Feature.values.toSet();
  final byName = {for (final feature in Feature.values) feature.name: feature};
  final features = <Feature>{};
  for (final name in names) {
    final feature = byName[name];
    if (feature != null) {
      features.add(feature);
      continue;
    }
    onUnknownKey?.call(name);
  }
  return features;
}

/// Host-side implementation of the commercial module's
/// [CommercialEntitlementInstaller] hook.
///
/// Dependency direction (open-core boundary): the module cannot import the
/// host's [EntitlementProvider] type — that would create a host⇄module import
/// cycle — so instead the module declares this installer interface and the
/// host implements it. When `wireCommercialBilling` runs with the
/// `GEWERBER_COMMERCIAL_ENTITLEMENTS` flag on, it resolves the installer from
/// the host's service locator and calls [installCommercialEntitlements],
/// which swaps the OSS default binding for the module's provider. The public
/// stubs' no-op wiring never does this, so self-hosted OSS deployments keep
/// the [AllFeaturesEntitlementProvider] binding.
final class HostCommercialEntitlementInstaller
    implements CommercialEntitlementInstaller {
  const HostCommercialEntitlementInstaller();

  @override
  void installCommercialEntitlements(CommercialEntitlementProvider provider) {
    // Unconditional unregister, matching the old DI swap: injectable
    // registers the default eagerly, so an [EntitlementProvider] binding is
    // always present at this point.
    getIt.unregister<EntitlementProvider>();
    getIt.registerSingleton<EntitlementProvider>(
      _ModuleEntitlementAdapter(provider),
    );
  }
}

/// Adapts the module's [CommercialEntitlementProvider] to the host
/// [EntitlementProvider] contract.
///
/// The provider's own behavior (plan resolution, fail-open on data-source
/// errors, raw capability checks) is owned and tested by the commercial
/// module; this adapter only bridges the call signatures and maps the
/// returned OSS feature names onto the host [Feature] enum via
/// [featuresFromOssNames].
final class _ModuleEntitlementAdapter implements EntitlementProvider {
  _ModuleEntitlementAdapter(this._provider);

  final CommercialEntitlementProvider _provider;

  @override
  Future<Set<Feature>> featuresFor(
    Session session,
    TenantContext tenant,
  ) async {
    final names = await _provider.ossFeatureNames(
      session,
      userId: tenant.userId,
      businessId: tenant.businessId,
    );
    return featuresFromOssNames(
      names,
      onUnknownKey: (name) => session.log(
        '[HostCommercialEntitlementInstaller] OSS feature name "$name" from '
        'the commercial module has no Feature equivalent and was skipped.',
        level: LogLevel.warning,
      ),
    );
  }

  @override
  Future<bool> hasCapability(
    Session session, {
    required String capability,
    required UuidValue userId,
    int? businessId,
  }) {
    // 1:1 delegation: same signature, same (module-owned) semantics.
    return _provider.hasCapability(
      session,
      capability: capability,
      userId: userId,
      businessId: businessId,
    );
  }
}
