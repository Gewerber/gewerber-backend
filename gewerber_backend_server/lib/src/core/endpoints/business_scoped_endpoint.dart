import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../di/service_locator.dart';
import '../entitlement/entitlement_guard.dart';
import '../tenant/tenant_context.dart';
import '../tenant/tenant_resolver.dart';

abstract class BusinessScopedEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Feature required to use this endpoint (`null` = no check, OSS default).
  ///
  /// Enforced in the central [tenant]/[adminTenant] resolution flow: after
  /// the tenant context is resolved, [EntitlementGuard.require] asserts the
  /// feature is enabled. Endpoints that delegate tenant resolution to their
  /// use cases instead call [requireFeature] at the top of each method.
  ///
  /// OSS ships with the default `null` (all features enabled), so this is a
  /// no-op unless an endpoint opts in — zero behavior change.
  // Getters are ignored by Serverpod codegen (like `requireLogin`), so no
  // `@doNotGenerate` is needed here.
  Feature? get requiredFeature => null;

  /// Entry-point guard: resolves the tenant context and asserts [feature]
  /// via [EntitlementGuard].
  ///
  /// Call this BEFORE the normal method flow. It performs its own tenant
  /// resolution (same as [tenant]) and does not hand the context back — the
  /// subsequent use-case call re-resolves the tenant as usual. This is a
  /// pure pre-check, not a way to pass the context down.
  @doNotGenerate
  Future<void> requireFeature(
    Session session,
    int? businessId,
    Feature feature,
  ) async {
    final tenantContext = await getIt<TenantResolver>().resolve(
      session,
      businessId: businessId,
    );
    await getIt<EntitlementGuard>().require(session, tenantContext, feature);
  }

  @doNotGenerate
  Future<TenantContext> tenant(Session session, {int? businessId}) async {
    final tenantContext = await getIt<TenantResolver>().resolve(
      session,
      businessId: businessId,
    );
    return _enforceFeature(session, tenantContext);
  }

  @doNotGenerate
  Future<TenantContext> adminTenant(Session session, {int? businessId}) async {
    final tenantContext = await getIt<TenantResolver>().requireAdmin(
      session,
      businessId: businessId,
    );
    return _enforceFeature(session, tenantContext);
  }

  /// Central feature check for the [tenant]/[adminTenant] resolution flow.
  /// No-op unless [requiredFeature] is overridden.
  @doNotGenerate
  Future<TenantContext> _enforceFeature(
    Session session,
    TenantContext tenantContext,
  ) async {
    final feature = requiredFeature;
    if (feature != null) {
      await getIt<EntitlementGuard>().require(session, tenantContext, feature);
    }
    return tenantContext;
  }
}
