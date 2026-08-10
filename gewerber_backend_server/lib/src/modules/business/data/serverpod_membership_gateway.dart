import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/membership_gateway.dart';

@Singleton(as: MembershipGateway)
class ServerpodMembershipGateway implements MembershipGateway {
  @override
  Future<Membership> create(
    Session session,
    Membership membership, {
    Transaction? transaction,
  }) {
    return Membership.db.insertRow(
      session,
      membership,
      transaction: transaction,
    );
  }

  @override
  Future<Membership?> find(
    Session session, {
    required UuidValue userId,
    required int businessId,
  }) {
    return Membership.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.businessId.equals(businessId),
    );
  }

  @override
  Future<List<Membership>> findByUser(Session session, UuidValue userId) {
    return Membership.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.createdAt,
    );
  }

  @override
  Future<List<Membership>> findByBusiness(Session session, int businessId) {
    return Membership.db.find(
      session,
      where: (t) => t.businessId.equals(businessId),
      orderBy: (t) => t.createdAt,
    );
  }
}
