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
}
