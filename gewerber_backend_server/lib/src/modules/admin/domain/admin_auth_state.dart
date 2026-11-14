import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

/// Snapshot of a user's authentication state used by admin mutations.
class AdminAuthState {
  const AdminAuthState({
    required this.userId,
    required this.blocked,
    required this.emailConfirmed,
    required this.providers,
    this.email,
    this.emailProvider,
    this.authUserCreatedAt,
  });

  final UuidValue userId;
  final bool blocked;

  /// Whether ownership of [email] is confirmed. Resolved from the strongest
  /// identity, so it is `true` for the email IdP (an `EmailAccount` row only
  /// exists after the verification challenge), Google and Microsoft, mirrors
  /// Apple's `isEmailVerified` claim and is `false` for Facebook.
  final bool emailConfirmed;

  /// Address of the strongest identity (email IdP, then Google, Apple,
  /// Microsoft, Facebook) or `null` when no identity supplied one.
  final String? email;

  /// Social provider that supplied [email]; `null` for the email IdP and when
  /// there is no address.
  final AuthProvider? emailProvider;

  /// Social providers holding an account row for this auth user. The email IdP
  /// is not a social provider and therefore not listed.
  final List<AuthProvider> providers;

  final DateTime? authUserCreatedAt;
}
