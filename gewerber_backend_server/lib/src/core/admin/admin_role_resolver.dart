import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import 'admin_context.dart';

/// Resolves global administrator roles from the `admin_user` allowlist.
///
/// Implemented in `modules/admin/data`; endpoints depend on this interface
/// only (same pattern as [TenantResolver]).
abstract interface class AdminRoleResolver {
  /// Returns the admin context for [userId], or `null` when the user has no
  /// global role.
  Future<AdminContext?> findByUser(Session session, UuidValue userId);

  /// Resolves the authenticated user's admin context or throws a generated
  /// [ForbiddenException] when unauthenticated, not an admin, or below
  /// [minRole].
  Future<AdminContext> requireAdmin(
    Session session, {
    required AdminRole minRole,
  });
}
