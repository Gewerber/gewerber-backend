import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/invitation_gateway.dart';

@Singleton(as: InvitationGateway)
class ServerpodInvitationGateway implements InvitationGateway {
  @override
  Future<Invitation> create(
    Session session,
    Invitation invitation, {
    Transaction? transaction,
  }) {
    return Invitation.db.insertRow(
      session,
      invitation,
      transaction: transaction,
    );
  }

  @override
  Future<Invitation?> findByTokenHash(Session session, String tokenHash) {
    return Invitation.db.findFirstRow(
      session,
      where: (t) => t.tokenHash.equals(tokenHash),
    );
  }

  @override
  Future<Invitation?> findActiveByBusinessAndEmail(
    Session session, {
    required int businessId,
    required String email,
  }) {
    return Invitation.db.findFirstRow(
      session,
      where: (t) =>
          t.businessId.equals(businessId) &
          t.email.equals(email) &
          t.status.equals(InvitationStatus.pending),
    );
  }

  @override
  Future<List<Invitation>> findByBusiness(Session session, int businessId) {
    return Invitation.db.find(
      session,
      where: (t) =>
          t.businessId.equals(businessId) &
          t.status.equals(InvitationStatus.pending),
      orderBy: (t) => t.createdAt,
    );
  }

  @override
  Future<Invitation> delete(Session session, Invitation invitation) {
    return Invitation.db.deleteRow(session, invitation);
  }
}
