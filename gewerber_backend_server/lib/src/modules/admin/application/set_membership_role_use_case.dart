import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/admin/admin_context.dart';
import '../../../core/audit/audit_service.dart';
import '../../../generated/protocol.dart';
import '../domain/admin_business_gateway.dart';
import '../domain/require_confirm.dart';

/// Sets the tenant role of a membership. The platform guarantees that a
/// business always keeps at least one owner (validated inside a transaction
/// by [AdminBusinessGateway.setMembershipRole]). Mutation and audit entry
/// share one transaction — the trail can never describe a change that did
/// not happen.
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

    return session.db.transaction((transaction) async {
      final before = await _currentRole(session, membershipId, transaction);
      final updated = await _businesses.setMembershipRole(
        session,
        membershipId,
        role,
        transaction: transaction,
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
        transaction: transaction,
      );
      return updated;
    });
  }

  Future<MembershipRole?> _currentRole(
    Session session,
    int membershipId,
    Transaction transaction,
  ) async {
    final membership = await Membership.db.findById(
      session,
      membershipId,
      transaction: transaction,
    );
    return membership?.role;
  }
}
