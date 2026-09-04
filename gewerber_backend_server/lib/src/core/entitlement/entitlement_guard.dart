import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../di/service_locator.dart';
import '../tenant/tenant_context.dart';
import 'entitlement_provider.dart';

/// Entry-point guard for feature gating.
///
/// Resolves the [EntitlementProvider] through getIt at call time — not via
/// constructor injection — so a DI scope override (e.g. the commercial module
/// binding a subscription-backed provider) takes effect on every request.
/// This mirrors how [EntitlementEndpoint] resolves the provider.
///
/// Throws [ForbiddenException] when [feature] is not enabled for [tenant].
@singleton
class EntitlementGuard {
  Future<void> require(
    Session session,
    TenantContext tenant,
    Feature feature,
  ) async {
    final features = await getIt<EntitlementProvider>().featuresFor(
      session,
      tenant,
    );
    if (!features.contains(feature)) {
      throw ForbiddenException(
        message: 'Feature not available: ${feature.name}',
      );
    }
  }
}
