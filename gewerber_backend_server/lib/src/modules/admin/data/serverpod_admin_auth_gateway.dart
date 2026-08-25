import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as core;
import 'package:serverpod_auth_idp_server/providers/email.dart' as idp;

import '../../../generated/protocol.dart';
import '../domain/admin_auth_gateway.dart';
import '../domain/admin_auth_state.dart';

/// Auth mutations built on the public admin APIs of `serverpod_auth_core`
/// ([core.AuthUsers]) and the email IdP tables.
@Singleton(as: AdminAuthGateway)
class ServerpodAdminAuthGateway implements AdminAuthGateway {
  static final _authUsers = core.AuthUsers();

  @override
  Future<AdminAuthState> authState(Session session, UuidValue userId) async {
    final account = await idp.EmailAccount.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
      include: idp.EmailAccount.include(
        authUser: core.AuthUser.include(),
      ),
    );
    final authUser = account?.authUser;

    if (authUser == null) {
      // No email account: load the auth user directly so the blocked flag is
      // still reported for users registered via other identity providers.
      try {
        final model = await _authUsers.get(session, authUserId: userId);
        return AdminAuthState(
          userId: userId,
          blocked: model.blocked,
          emailConfirmed: false,
          authUserCreatedAt: model.createdAt,
        );
      } on core.AuthUserNotFoundException {
        throw NotFoundException(entityType: 'AuthUser', entityId: '$userId');
      }
    }

    return AdminAuthState(
      userId: userId,
      blocked: authUser.blocked,
      emailConfirmed: true,
      email: account!.email,
      authUserCreatedAt: authUser.createdAt,
    );
  }

  @override
  Future<void> ban(Session session, UuidValue userId) async {
    // Blocks sign-in and refresh-token rotation from now on. Translates the
    // package exception into the generated NotFoundException so clients can
    // catch by type.
    await _updateBlocked(session, userId, blocked: true);

    // Kill all refresh tokens immediately: the banned user can no longer
    // obtain new access tokens. Already issued access tokens stay valid until
    // they expire (short-lived JWTs — documented limitation).
    await core.RefreshToken.db.deleteWhere(
      session,
      where: (t) => t.authUserId.equals(userId),
    );

    // Close live WebSocket/stream connections of the user.
    await session.messages.authenticationRevoked(
      userId.uuid,
      RevokedAuthenticationUser(),
    );
  }

  @override
  Future<void> unban(Session session, UuidValue userId) async {
    // Previously deleted refresh tokens do not come back — the user signs in
    // again and gets a fresh token pair.
    await _updateBlocked(session, userId, blocked: false);
  }

  /// Residual risk (accepted): the three steps of [ban] are separate commits,
  /// not one transaction — a crash between them could leave a blocked user
  /// with orphaned tokens or live connections. A cross-module transaction
  /// over `serverpod_auth_core_*` tables was rejected deliberately: those
  /// tables belong to the auth module's own transaction discipline
  /// (`runInTransactionOrSavepoint`), and the window is practically harmless
  /// because a blocked user cannot mint new tokens anyway.
  Future<void> _updateBlocked(
    Session session,
    UuidValue userId, {
    required bool blocked,
  }) async {
    try {
      await _authUsers.update(session, authUserId: userId, blocked: blocked);
    } on core.AuthUserNotFoundException {
      throw NotFoundException(entityType: 'AuthUser', entityId: '$userId');
    }
  }
}
