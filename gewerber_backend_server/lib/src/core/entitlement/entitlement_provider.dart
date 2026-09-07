import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../tenant/tenant_context.dart';

/// Contract for feature gating.
///
/// The OSS core ships [AllFeaturesEntitlementProvider] which allows every
/// feature. Commercial deployments (SaaS) replace the DI binding with
/// [CommercialEntitlementProvider], an implementation backed by subscription
/// data (gewerber-payments). The swap is opt-in via the
/// `GEWERBER_COMMERCIAL_ENTITLEMENTS=true` environment variable (see
/// `core/di/injection.dart`); it stays off — and this default binding stays
/// active — for all self-hosted OSS deployments.
abstract interface class EntitlementProvider {
  Future<Set<Feature>> featuresFor(Session session, TenantContext tenant);

  /// Checks a raw capability key against the entitlements granted to [userId]
  /// (optionally scoped to a [businessId]).
  ///
  /// Capabilities are the *commercial* plan-key vocabulary and deliberately
  /// not every key has an OSS [Feature] enum equivalent (e.g.
  /// `unlimited_invoices`). This method is the seam that lets core code query
  /// such keys without mapping them into [Feature]:
  ///
  /// - [AllFeaturesEntitlementProvider] (OSS default) always returns `true` —
  ///   in the open-source build every capability is free.
  ///   [CommercialEntitlementProvider] checks the raw key set returned by its
  ///   commercial entitlement source (fail-open on source errors, mirroring
  ///   [featuresFor]).
  Future<bool> hasCapability(
    Session session, {
    required String capability,
    required UuidValue userId,
    int? businessId,
  });
}
