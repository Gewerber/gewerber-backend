import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/admin_audit_gateway.dart';

@Singleton(as: AdminAuditGateway)
class ServerpodAdminAuditGateway implements AdminAuditGateway {
  const ServerpodAdminAuditGateway();

  @override
  Future<List<AdminAuditEntry>> query(
    Session session, {
    UuidValue? actorUserId,
    String? action,
    DateTime? since,
    required int limit,
  }) async {
    final rows = await AuditEntry.db.find(
      session,
      where: (t) {
        var expression = Constant.bool(true) as Expression;
        if (actorUserId != null) {
          expression &= t.userId.equals(actorUserId);
        }
        if (action != null && action.trim().isNotEmpty) {
          expression &= t.action.equals(action.trim());
        }
        if (since != null) {
          expression &= t.createdAt >= since;
        }
        return expression;
      },
      // Secondary sort by id keeps the order stable for entries written in
      // the same transaction (same timestamp) — required for keyset paging.
      orderByList: (t) => [t.createdAt.desc(), t.id.desc()],
      limit: limit,
    );

    return rows
        .map(
          (row) => AdminAuditEntry(
            id: row.id,
            businessId: row.businessId,
            userId: row.userId,
            action: row.action,
            entityType: row.entityType,
            entityId: row.entityId,
            changes: row.changes,
            createdAt: row.createdAt,
          ),
        )
        .toList();
  }
}
