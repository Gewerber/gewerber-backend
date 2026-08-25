import 'package:serverpod/serverpod.dart';

import 'admin_auth_state.dart';

/// Mutating operations on the authentication state of a user (ban, unban).
abstract interface class AdminAuthGateway {
  /// Loads the current auth status of [userId].
  Future<AdminAuthState> authState(Session session, UuidValue userId);

  /// Blocks [userId]: sign-in and refresh-token rotation are refused, all
  /// refresh tokens are deleted immediately. Existing short-lived access
  /// tokens stay valid until they expire (JWT design; documented limitation).
  ///
  /// Throws `AuthUserNotFoundException` when no such auth user exists.
  Future<void> ban(Session session, UuidValue userId);

  /// Lifts the block on [userId]. Previously deleted refresh tokens do not
  /// come back — the user simply signs in again.
  ///
  /// Throws `AuthUserNotFoundException` when no such auth user exists.
  Future<void> unban(Session session, UuidValue userId);
}
