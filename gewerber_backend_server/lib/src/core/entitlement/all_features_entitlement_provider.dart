import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../tenant/tenant_context.dart';
import 'entitlement_provider.dart';

/// Default OSS binding: every feature is enabled.
@Singleton(as: EntitlementProvider)
class AllFeaturesEntitlementProvider implements EntitlementProvider {
  @override
  Future<Set<Feature>> featuresFor(
    Session session,
    TenantContext tenant,
  ) async {
    return Feature.values.toSet();
  }

  @override
  Future<bool> hasCapability(
    Session session, {
    required String capability,
    required UuidValue userId,
    int? businessId,
  }) async {
    // The OSS build is fully unlocked: every capability is granted.
    return true;
  }
}
