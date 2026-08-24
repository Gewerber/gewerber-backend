import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/admin/admin_context.dart';
import '../../../core/admin/admin_role_resolver.dart';
import '../../../core/tenant/session_auth.dart';
import '../../../generated/protocol.dart';

@Singleton(as: AdminRoleResolver)
class ServerpodAdminRoleResolver implements AdminRoleResolver {
  const ServerpodAdminRoleResolver();

  @override
  Future<AdminContext?> findByUser(Session session, UuidValue userId) async {
    final row = await AdminUser.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
    if (row == null) return null;
    return AdminContext(userId: userId, role: row.role);
  }

  @override
  Future<AdminContext> requireAdmin(
    Session session, {
    required AdminRole minRole,
  }) async {
    final userId = session.authUserId;
    if (userId == null) {
      throw ForbiddenException(message: 'Not authenticated.');
    }
    final context = await findByUser(session, userId);
    if (context == null) {
      throw ForbiddenException(message: 'Administrator role required.');
    }
    if (!context.role.satisfies(minRole)) {
      throw ForbiddenException(
        message:
            'Insufficient administrator role: '
            '${minRole.name} required, ${context.role.name} granted.',
      );
    }
    return context;
  }
}
