import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/admin_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/query_audit_entries_use_case.dart';

/// Read access to the audit trail for moderators.
class AdminAuditEndpoint extends AdminEndpoint {
  /// Newest-first audit entries, optionally filtered by acting user, action
  /// (exact match) and lower time bound. Limited pages, no cursor — use
  /// `since` of the oldest returned entry to page further.
  Future<AdminAuditPage> auditQuery(
    Session session, {
    UuidValue? actorUserId,
    String? action,
    DateTime? since,
    int? limit,
  }) async {
    await requireAdmin(session, minRole: AdminRole.moderator);
    return getIt<QueryAuditEntriesUseCase>().call(
      session,
      actorUserId: actorUserId,
      action: action,
      since: since,
      limit: limit,
    );
  }
}
