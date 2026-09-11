import 'dart:io';

import 'package:injectable/injectable.dart';

import '../entitlement/all_features_entitlement_provider.dart';
import '../entitlement/commercial_entitlement_installer.dart';
import 'injection.config.dart';
import 'service_locator.dart';

/// Environment variable that opts a deployment into commercial entitlements.
///
/// When set to exactly `true`, the flag gates the *module-side* provider swap
/// performed by the commercial module's `wireCommercialBilling` entrypoint
/// (which installs its `CommercialEntitlementProvider` over the OSS default
/// [AllFeaturesEntitlementProvider] via the host-registered
/// [CommercialEntitlementInstaller], see
/// `core/entitlement/commercial_entitlement_installer.dart`), as well as
/// quota enforcement in `InvoiceQuotaPolicy`. Injection itself no longer
/// swaps the provider; it only registers the installer hook.
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
/// Single source of truth for the flag: consulted by the commercial module's
/// `wireCommercialBilling` (via the host-registered
/// [CommercialEntitlementInstaller]) *and* by runtime feature gates (e.g.
/// `InvoiceQuotaPolicy`) so both always agree.
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
  // Registered unconditionally; the module's wireCommercialBilling consults
  // it only when the entitlements flag is on (the public stubs' no-op never
  // does).
  getIt.registerSingleton<CommercialEntitlementInstaller>(
    const HostCommercialEntitlementInstaller(),
  );
}
