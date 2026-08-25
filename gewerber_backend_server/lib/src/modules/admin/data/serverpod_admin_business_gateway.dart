import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/admin_business_gateway.dart';

@Singleton(as: AdminBusinessGateway)
class ServerpodAdminBusinessGateway implements AdminBusinessGateway {
  const ServerpodAdminBusinessGateway();

  @override
  Future<List<Business>> searchBusinesses(
    Session session, {
    String? query,
    int? afterId,
    required int limit,
  }) {
    final normalized = query?.trim() ?? '';
    return Business.db.find(
      session,
      where: (t) {
        var expression = Constant.bool(true) as Expression;
        if (normalized.isNotEmpty) {
          expression &= t.name.ilike('%$normalized%');
        }
        if (afterId != null) {
          expression &= t.id > afterId;
        }
        return expression;
      },
      orderBy: (t) => t.id,
      limit: limit,
    );
  }

  @override
  Future<AdminBusinessDetail> getBusiness(Session session, int businessId) {
    return _withMemberships(session, businessId);
  }

  @override
  Future<Membership> setMembershipRole(
    Session session,
    int membershipId,
    MembershipRole role, {
    Transaction? transaction,
  }) {
    Future<Membership> run(Transaction tx) async {
      final membership = await Membership.db.findById(
        session,
        membershipId,
        transaction: tx,
      );
      if (membership == null) {
        throw NotFoundException(
          entityType: 'Membership',
          entityId: '$membershipId',
        );
      }

      // Serialize competing role changes on the same business: the row lock
      // on the parent business orders concurrent demotions, so two admins
      // can never both pass the last-owner check below. Fail closed when the
      // parent is gone (orphaned membership) instead of skipping the lock.
      final business = await Business.db.findById(
        session,
        membership.businessId,
        lockMode: LockMode.forUpdate,
        transaction: tx,
      );
      if (business == null) {
        throw NotFoundException(
          entityType: 'Business',
          entityId: '${membership.businessId}',
        );
      }

      final demotesAnOwner =
          membership.role == MembershipRole.owner &&
          role != MembershipRole.owner;
      if (demotesAnOwner) {
        // Recounted inside the business lock — no TOCTOU window.
        final owners = await Membership.db.count(
          session,
          where: (t) =>
              t.businessId.equals(membership.businessId) &
              t.role.equals(MembershipRole.owner),
          transaction: tx,
        );
        if (owners <= 1) {
          throw ConflictException(
            message:
                'Cannot remove the last owner of business '
                '${membership.businessId}. Promote another owner first.',
          );
        }
      }

      membership.role = role;
      return Membership.db.updateRow(session, membership, transaction: tx);
    }

    return transaction == null ? session.db.transaction(run) : run(transaction);
  }

  Future<AdminBusinessDetail> _withMemberships(
    Session session,
    int businessId,
  ) async {
    final business = await Business.db.findById(session, businessId);
    if (business == null) {
      throw NotFoundException(entityType: 'Business', entityId: '$businessId');
    }
    final memberships = await Membership.db.find(
      session,
      where: (t) => t.businessId.equals(businessId),
      orderBy: (t) => t.createdAt,
    );
    return AdminBusinessDetail(
      business: business,
      memberships: memberships
          .map(
            (m) => AdminMembershipInfo(
              membership: m,
              businessName: business.name,
            ),
          )
          .toList(),
    );
  }
}
