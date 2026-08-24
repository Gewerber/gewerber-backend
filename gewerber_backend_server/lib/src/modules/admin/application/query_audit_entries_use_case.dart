import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/admin_audit_gateway.dart';
import '../domain/admin_list_limits.dart';

/// Newest-first read access to the audit trail for moderators.
@singleton
class QueryAuditEntriesUseCase {
  const QueryAuditEntriesUseCase(this._auditGateway);

  final AdminAuditGateway _auditGateway;

  Future<AdminAuditPage> call(
    Session session, {
    UuidValue? actorUserId,
    String? action,
    DateTime? since,
    int? limit,
  }) async {
    final effectiveLimit = clampAdminListLimit(limit);
    final items = await _auditGateway.query(
      session,
      actorUserId: actorUserId,
      action: action,
      since: since,
      limit: effectiveLimit,
    );
    return AdminAuditPage(items: items, limit: effectiveLimit);
  }
}
