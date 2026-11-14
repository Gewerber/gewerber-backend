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
    required this.primaryEmailProvider,
    required this.providers,
  });

  /// Address the user should see for this account, or `null` when no provider
  /// supplied one (blank addresses count as absent).
  final String? primaryEmail;

  /// Whether ownership of [primaryEmail] is confirmed. Always `false` when
  /// [primaryEmail] is `null`, and `false` for a Facebook-only address, because
  /// Facebook returns whatever the user put into their profile.
  final bool emailVerified;

  /// Provider that supplied [primaryEmail]. `null` when there is no address, or
  /// when it came from the email IdP ([AuthProvider] has no `email` value).
  final AuthProvider? primaryEmailProvider;

  /// Providers holding an account row for this auth user, in the enum
  /// declaration order (`google`, `apple`, `facebook`, `microsoft`).
  ///
  /// Email accounts are deliberately absent: the email IdP is not a social
  /// provider and [AuthProvider] has no `email` value.
  final List<AuthProvider> providers;
}

/// One email-bearing identity row of an auth user, as used by the admin
/// directory.
class IdentityEmailRow {
  const IdentityEmailRow({
    required this.authUserId,
    required this.email,
    required this.provider,
    required this.emailVerified,
  });

  final UuidValue authUserId;

  /// Non-blank address exactly as stored (the IdPs store it in lower case).
  final String email;

  /// `null` for the email IdP, otherwise the social provider holding the row.
  final AuthProvider? provider;

  /// Whether ownership of [email] is confirmed. Always `true` for the email IdP
  /// (the row only exists after the challenge was passed).
  final bool emailVerified;
}

/// Reads the authentication providers attached to an auth user.
abstract interface class AuthIdentityGateway {
  Future<AuthIdentity> resolve(Session session, UuidValue userId);

  /// Lists every email-bearing identity row, across the email IdP and the four
  /// social providers, for the admin user directory.
  ///
  /// [query] filters by a case-insensitive substring of the address; `null` or
  /// an empty string lists every row. Rows are ordered by `(email, authUserId)`
  /// so the caller can keyset-paginate: pass the last returned address as
  /// [afterEmail] and, for rows sharing that address, the last user id as
  /// [afterUserId]. A missing [afterUserId] keeps the legacy email-only
  /// boundary (strictly greater address).
  ///
  /// At most [limit] rows are read per identity table and the merge, dedupe and
  /// ordering happen in Dart. This is admin-scale by design: no index is added
  /// for the cross-provider listing and the per-table clamp assumes a user has
  /// at most one row per provider (account linking is not implemented). Rows
  /// with a blank or absent address are skipped — they cannot be searched for
  /// or shown in a directory that sorts by address.
  Future<List<IdentityEmailRow>> findEmails(
    Session session, {
    String? query,
    String? afterEmail,
    String? afterUserId,
    required int limit,
  });
}
