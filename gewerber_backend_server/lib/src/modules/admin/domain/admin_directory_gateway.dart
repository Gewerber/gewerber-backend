import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

/// Read access to the user directory (auth + profile) for admin workflows.
abstract interface class AdminDirectoryGateway {
  /// Keyset-paginated user search ordered by `(email, userId)`. [query] filters
  /// by a case-insensitive substring of any identity address; pass an empty
  /// string or `null` to list all users with an address. Users without any
  /// email identity are not listed (nothing to search or display).
  ///
  /// [afterEmail] and [afterUserId] are the keyset boundary of the previous
  /// page. A cursor without [afterUserId] keeps the legacy email-only behavior
  /// (strictly greater address).
  Future<List<AdminUserSummary>> searchUsers(
    Session session, {
    String? query,
    String? afterEmail,
    String? afterUserId,
    required int limit,
  });

  /// Loads the dossier data of one user: profile (or null when never
  /// created / soft-deleted accounts keep their row), the provider-agnostic
  /// identity (email and social providers, both possibly absent) and the
  /// global admin role.
  Future<AdminUserDossier> getUserDossier(Session session, UuidValue userId);
}
