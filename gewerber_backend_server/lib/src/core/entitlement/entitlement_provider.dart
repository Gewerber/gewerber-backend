import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../tenant/tenant_context.dart';

/// Contract for feature gating.
///
/// The OSS core ships [AllFeaturesEntitlementProvider] which allows every
/// feature. Commercial deployments (SaaS) replace the DI binding with an
/// implementation backed by subscription data (gewerber-payments).
abstract interface class EntitlementProvider {
  Future<Set<Feature>> featuresFor(Session session, TenantContext tenant);
}
