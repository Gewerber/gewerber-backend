import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class InvitationGateway {
  Future<Invitation> create(
    Session session,
    Invitation invitation, {
    Transaction? transaction,
  });

  Future<Invitation?> findByTokenHash(Session session, String tokenHash);

  /// Finds the pending ("active") invitation for [email] in [businessId].
  /// Expiry is derived from `expiresAt` by use cases, not by this query.
  Future<Invitation?> findActiveByBusinessAndEmail(
    Session session, {
    required int businessId,
    required String email,
  });

  /// Lists pending invitations of a business, oldest first.
  Future<List<Invitation>> findByBusiness(Session session, int businessId);

  Future<Invitation> delete(Session session, Invitation invitation);
}
