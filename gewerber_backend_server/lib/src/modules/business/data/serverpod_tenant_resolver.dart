import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/session_auth.dart';
import '../../../core/tenant/tenant_context.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/membership_gateway.dart';

@Singleton(as: TenantResolver)
class ServerpodTenantResolver implements TenantResolver {
  ServerpodTenantResolver(this._memberships);

  final MembershipGateway _memberships;

  @override
  Future<TenantContext> resolve(Session session, {int? businessId}) async {
    final userId = session.authUserId;
    if (userId == null) {
      throw ForbiddenException(message: 'Not authenticated.');
    }

    if (businessId == null) {
      final memberships = await _memberships.findByUser(session, userId);
      if (memberships.isEmpty) {
        throw NotFoundException(entityType: 'Business');
      }
      final membership = memberships.first;
      return TenantContext(
        userId: userId,
        businessId: membership.businessId,
        role: membership.role,
      );
    }

    final membership = await _memberships.find(
      session,
      userId: userId,
      businessId: businessId,
    );
    if (membership == null) {
      throw ForbiddenException(message: 'Not a member of this business.');
    }
    return TenantContext(
      userId: userId,
      businessId: businessId,
      role: membership.role,
    );
  }

  @override
  Future<TenantContext> requireAdmin(Session session, {int? businessId}) async {
    final tenant = await resolve(session, businessId: businessId);
    if (!tenant.isAdmin) {
      throw ForbiddenException(message: 'Admin permissions required.');
    }
    return tenant;
  }
}
