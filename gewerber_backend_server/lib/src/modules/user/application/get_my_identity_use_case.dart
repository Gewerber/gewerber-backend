import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/admin/admin_role_resolver.dart';
import '../../../core/tenant/session_auth.dart';
import '../../../generated/protocol.dart';
import '../../business/domain/business_gateway.dart';
import '../../business/domain/membership_gateway.dart';

/// Resolves the authenticated caller's own identity: their auth user id, the
/// global admin role from the `admin_user` allowlist (if any) and every
/// business membership with the business display name.
///
/// Used by clients that need to discover what they are allowed to see —
/// notably the MCP integration tooling opened up to regular users. Data
/// isolation is unaffected: only the caller's own rows are read.
@singleton
class GetMyIdentityUseCase {
  GetMyIdentityUseCase(this._roles, this._memberships, this._businesses);

  final AdminRoleResolver _roles;
  final MembershipGateway _memberships;
  final BusinessGateway _businesses;

  Future<MyIdentity> call(Session session) async {
    final userId = session.authUserId;
    if (userId == null) {
      throw ForbiddenException(message: 'Not authenticated.');
    }

    final globalRole = (await _roles.findByUser(session, userId))?.role;

    final membershipRows = await _memberships.findByUser(session, userId);
    final businessNames = <int, String>{};
    for (final membership in membershipRows) {
      final business = await _businesses.findById(
        session,
        membership.businessId,
      );
      if (business != null) {
        businessNames[membership.businessId] = business.name;
      }
    }

    return MyIdentity(
      userId: userId,
      globalRole: globalRole,
      // Deterministic order so consumers can diff responses reliably.
      memberships: [
        for (final membership
            in membershipRows
              ..sort((a, b) => a.businessId.compareTo(b.businessId)))
          if (businessNames.containsKey(membership.businessId))
            MyMembershipInfo(
              businessId: membership.businessId,
              businessName: businessNames[membership.businessId]!,
              role: membership.role,
            ),
      ],
    );
  }
}
