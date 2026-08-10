import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class MembershipGateway {
  Future<Membership> create(
    Session session,
    Membership membership, {
    Transaction? transaction,
  });

  Future<Membership?> find(
    Session session, {
    required UuidValue userId,
    required int businessId,
  });

  Future<List<Membership>> findByUser(Session session, UuidValue userId);

  Future<List<Membership>> findByBusiness(Session session, int businessId);
}
