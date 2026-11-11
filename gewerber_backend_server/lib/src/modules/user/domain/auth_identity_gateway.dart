import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

/// The sign-in identities backing one auth user.
///
/// Account linking is not implemented yet: a human who signed up with an email
/// address and later signed in with Google owns two `AuthUser` rows, so each
/// snapshot describes exactly one of them.
class AuthIdentity {
  const AuthIdentity({
    required this.primaryEmail,
    required this.emailVerified,
    required this.providers,
  });

  /// Address the user should see for this account, or `null` when no provider
  /// supplied one (blank addresses count as absent).
  final String? primaryEmail;

  /// Whether ownership of [primaryEmail] is confirmed. Always `false` when
  /// [primaryEmail] is `null`, and `false` for a Facebook-only address, because
  /// Facebook returns whatever the user put into their profile.
  final bool emailVerified;

  /// Providers holding an account row for this auth user, in the enum
  /// declaration order (`google`, `apple`, `facebook`, `microsoft`).
  ///
  /// Email accounts are deliberately absent: the email IdP is not a social
  /// provider and [AuthProvider] has no `email` value.
  final List<AuthProvider> providers;
}

/// Reads the authentication providers attached to an auth user.
abstract interface class AuthIdentityGateway {
  Future<AuthIdentity> resolve(Session session, UuidValue userId);
}
