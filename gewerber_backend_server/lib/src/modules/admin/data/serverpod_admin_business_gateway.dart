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
    UuidValue? actorUserId,
  }) async {
    return session.db.transaction((transaction) async {
      final membership = await Membership.db.findById(
        session,
        membershipId,
        transaction: transaction,
      );
      if (membership == null) {
        throw NotFoundException(
          entityType: 'Membership',
          entityId: '$membershipId',
        );
      }

      final demotesAnOwner =
          membership.role == MembershipRole.owner &&
          role != MembershipRole.owner;
      if (demotesAnOwner) {
        final owners = await Membership.db.count(
          session,
          where: (t) =>
              t.businessId.equals(membership.businessId) &
              t.role.equals(MembershipRole.owner),
          transaction: transaction,
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
      return Membership.db.updateRow(session, membership);
    });
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
