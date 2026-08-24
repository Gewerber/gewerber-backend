import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../admin/admin_context.dart';
import '../admin/admin_role_resolver.dart';
import '../di/service_locator.dart';

/// Base class for global-administration endpoints (`modules/admin`).
///
/// Every method must start with [requireAdmin], which resolves the caller's
/// global role from the `admin_user` allowlist:
/// - `moderator` satisfies read-only calls,
/// - `admin` is required for mutations.
///
/// Mutations must additionally write an `AuditEntry` via [AuditService] with
/// the acting admin as actor.
abstract class AdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @doNotGenerate
  Future<AdminContext> requireAdmin(
    Session session, {
    required AdminRole minRole,
  }) {
    return getIt<AdminRoleResolver>().requireAdmin(session, minRole: minRole);
  }
}
