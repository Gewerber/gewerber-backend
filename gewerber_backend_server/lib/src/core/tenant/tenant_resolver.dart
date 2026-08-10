import 'package:serverpod/serverpod.dart';

import 'tenant_context.dart';

abstract interface class TenantResolver {
  Future<TenantContext> resolve(Session session, {int? businessId});

  Future<TenantContext> requireAdmin(Session session, {int? businessId});
}
