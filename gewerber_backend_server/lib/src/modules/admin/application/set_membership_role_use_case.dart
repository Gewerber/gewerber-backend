import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/admin/admin_context.dart';
import '../../../core/audit/audit_service.dart';
import '../../../generated/protocol.dart';
import '../domain/admin_business_gateway.dart';
import '../domain/require_confirm.dart';

/// Sets the tenant role of a membership. The platform guarantees that a
/// business always keeps at least one owner (validated inside a transaction
/// by [AdminBusinessGateway.setMembershipRole]).
@singleton
class SetMembershipRoleUseCase {
  SetMembershipRoleUseCase(this._businesses, this._audit);

  final AdminBusinessGateway _businesses;
  final AuditService _audit;

  Future<Membership> call(
    Session session, {
    required AdminContext actor,
    required int membershipId,
    required MembershipRole role,
    required bool confirm,
  }) async {
    requireConfirm(confirm);

    var before = await _currentRole(session, membershipId);
    final updated = await _businesses.setMembershipRole(
      session,
      membershipId,
      role,
      actorUserId: actor.userId,
    );

    await _audit.log(
      session,
      action: 'admin.membershipSetRole',
      entityType: 'Membership',
      entityId: '$membershipId',
      changes: {
        'from': before?.name ?? '<unknown>',
        'to': role.name,
        'businessId': '${updated.businessId}',
      },
      userId: actor.userId,
    );
    return updated;
  }

  Future<MembershipRole?> _currentRole(
    Session session,
    int membershipId,
  ) async {
    final membership = await Membership.db.findById(session, membershipId);
    return membership?.role;
  }
}
