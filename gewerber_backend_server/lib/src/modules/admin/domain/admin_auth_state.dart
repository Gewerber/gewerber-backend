import 'package:serverpod/serverpod.dart';

/// Snapshot of a user's authentication state used by admin mutations.
class AdminAuthState {
  const AdminAuthState({
    required this.userId,
    required this.blocked,
    required this.emailConfirmed,
    this.email,
    this.authUserCreatedAt,
  });

  final UuidValue userId;
  final bool blocked;

  /// In the Serverpod email IdP an `EmailAccount` row only exists after the
  /// registration verification code was confirmed — an existing account is
  /// therefore always confirmed.
  final bool emailConfirmed;

  final String? email;
  final DateTime? authUserCreatedAt;
}
