import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

/// Displayed-address precedence of the social identity providers, highest
/// precedence first.
///
/// The email IdP is not a social provider (`AuthProvider` has no `email`
/// value) and always ranks before every social provider; it is represented by
/// `null` in [AuthIdentity.primaryEmailProvider] and [IdentityEmailRow.provider]
/// and resolved by [identityProviderRank].
const List<AuthProvider> identityPrecedence = [
  AuthProvider.google,
  AuthProvider.apple,
  AuthProvider.microsoft,
  AuthProvider.facebook,
];

/// Returns the precedence rank of [provider] for choosing a user's displayed
/// email address: `0` for the email IdP (`null`), and the 1-based index in
/// [identityPrecedence] (`1..4`) for a social provider. Lower rank wins.
int identityProviderRank(AuthProvider? provider) {
  if (provider == null) return 0;
  final index = identityPrecedence.indexOf(provider);
  return index == -1 ? identityPrecedence.length + 1 : index + 1;
}

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
  /// Every provider query applies the same `(email, authUserId)` keyset
  /// boundary and is **not** clamped per identity table (5 queries per page,
  /// admin scale): reading all rows after the cursor across all five tables lets
  /// the Dart merge see every identity row of the candidate users on a page and
  /// collapse each `authUserId` into a single entry at its highest-precedence
  /// address ([identityPrecedence]), guaranteeing exactly-once per `authUserId`
  /// across the paginated walk. Rows with a blank or absent address are skipped
  /// — they cannot be searched for or shown in a directory that sorts by
  /// address.
  Future<List<IdentityEmailRow>> findEmails(
    Session session, {
    String? query,
    String? afterEmail,
    String? afterUserId,
    required int limit,
  });

  /// Purges every authentication identity and refresh token of [userId].
  ///
  /// Deleted in the passed [transaction] (created by the caller when given, so
  /// a failure rolls the whole account deletion back):
  /// - the email IdP row (`EmailAccount`) and the four social provider rows
  ///   (`GoogleAccount`, `AppleAccount`, `FacebookAccount`,
  ///   `MicrosoftAccount`),
  /// - the `AuthUser`'s refresh tokens (`RefreshToken`).
  ///
  /// Deliberately **not** touched:
  /// - the `AuthUser` row itself: the `UserProfile` tombstone, the admin
  ///   directory and the audit trail depend on it, and the `deletedAt` marker
  ///   must stay enforceable (a deleted account keeps rejecting logins and
  ///   writes; see `throwAccountDeleted`).
  /// - live opaque `Session` rows (`ServerSideSession`): they hold no personal
  ///   data beyond the user id and are not a login path — access tokens are
  ///   short-lived JWTs that expire on their own, and revocation broadcast to
  ///   clients is the auth module's own concern (`AuthSessions`), not a
  ///   deletion requirement.
  ///
  /// Deleting the identities is safe with `AuthUser` kept: every identity table
  /// and `RefreshToken` has an `ON DELETE CASCADE` foreign key to
  /// `serverpod_auth_core_user`, so the row deletes succeed regardless of the
  /// parent. `AuthUserProfile` (an `serverpod_auth_core` table with the same
  /// cascade) is not written by this gateway; nothing in the OSS server creates
  /// it, and any row it holds would outlive the identities harmlessly.
  Future<void> deleteAll(
    Session session,
    UuidValue userId, {
    Transaction? transaction,
  });
}
