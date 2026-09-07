import 'dart:io';

import 'package:injectable/injectable.dart';

import '../entitlement/all_features_entitlement_provider.dart';
import '../entitlement/commercial_entitlement_provider.dart';
import '../entitlement/entitlement_provider.dart';
import 'injection.config.dart';
import 'service_locator.dart';

/// Environment variable that swaps the [EntitlementProvider] DI binding from
/// the OSS default [AllFeaturesEntitlementProvider] to the
/// [CommercialEntitlementProvider] (subscription-backed feature gating).
///
/// Set it to `true` only in commercial SaaS deployments (see
/// `deploy/docker-compose.yml` env style, e.g. `SERVERPOD_APPLY_MIGRATIONS`).
/// An env var — not a `config/*.yaml` entry — is used deliberately: Serverpod
/// 4's typed runtime config is code-generated from a fixed schema, so adding a
/// custom `commercial.entitlements` key would require regenerating the config
/// classes for zero benefit. Self-hosted OSS builds leave it unset and keep
/// the all-features behavior unchanged.
const String commercialEntitlementsFlagEnvVar =
    'GEWERBER_COMMERCIAL_ENTITLEMENTS';

/// Whether the deployment opted into commercial entitlements via
/// [commercialEntitlementsFlagEnvVar] (exact value `true`).
///
/// Single source of truth for the flag: used by the DI swap below *and* by
/// runtime feature gates (e.g. `InvoiceQuotaPolicy`) so both always agree.
bool commercialEntitlementsEnabled([Map<String, String>? environment]) =>
    (environment ?? Platform.environment)[commercialEntitlementsFlagEnvVar] ==
    'true';

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  getIt.init();
  _registerCommercialEntitlementsIfEnabled();
}

/// Replaces the generated [EntitlementProvider] binding when the deployment
/// opts into commercial entitlements. No-op (OSS default preserved) whenever
/// [commercialEntitlementsFlagEnvVar] is not exactly `true`.
void _registerCommercialEntitlementsIfEnabled() {
  if (!commercialEntitlementsEnabled()) return;
  getIt.unregister<EntitlementProvider>();
  getIt.registerSingleton<EntitlementProvider>(
    CommercialEntitlementProvider(),
  );
}
