import 'package:serverpod/serverpod.dart';

import '../di/service_locator.dart';
import '../tenant/tenant_context.dart';
import '../tenant/tenant_resolver.dart';

abstract class BusinessScopedEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @doNotGenerate
  Future<TenantContext> tenant(Session session, {int? businessId}) {
    return getIt<TenantResolver>().resolve(session, businessId: businessId);
  }

  @doNotGenerate
  Future<TenantContext> adminTenant(Session session, {int? businessId}) {
    return getIt<TenantResolver>().requireAdmin(
      session,
      businessId: businessId,
    );
  }
}
