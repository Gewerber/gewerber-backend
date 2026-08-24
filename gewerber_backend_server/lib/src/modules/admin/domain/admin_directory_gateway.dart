import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

/// Read access to the user directory (auth + profile) for admin workflows.
abstract interface class AdminDirectoryGateway {
  /// Keyset-paginated user search ordered by email. [query] filters by a
  /// case-insensitive substring of the email address; pass an empty string or
  /// `null` to list all users.
  Future<List<AdminUserSummary>> searchUsers(
    Session session, {
    String? query,
    String? afterEmail,
    required int limit,
  });

  /// Loads the dossier data of one user: profile (or null when never
  /// created / soft-deleted accounts keep their row), the email account
  /// (null for users registered through other identity providers) and the
  /// global admin role.
  Future<AdminUserDossier> getUserDossier(Session session, UuidValue userId);
}
