import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../tenant/tenant_context.dart';

@singleton
class AuditService {
  /// Persists one [AuditEntry].
  ///
  /// Pass [transaction] to write the entry atomically with the change it
  /// describes: if the surrounding transaction rolls back, the audit entry
  /// rolls back with it — the trail can never describe a change that did
  /// not happen.
  ///
  /// Tenant/user attribution is taken from [tenant]; for events without a
  /// tenant context (system jobs, user-scoped actions) use [businessId]
  /// and/or [userId] directly. Explicit values are ignored when a [tenant]
  /// is given.
  Future<void> log(
    Session session, {
    required String action,
    required String entityType,
    String? entityId,
    Map<String, String>? changes,
    TenantContext? tenant,
    int? businessId,
    UuidValue? userId,
    Transaction? transaction,
  }) async {
    await AuditEntry.db.insertRow(
      session,
      AuditEntry(
        businessId: tenant?.businessId ?? businessId,
        userId: tenant?.userId ?? userId,
        action: action,
        entityType: entityType,
        entityId: entityId,
        changes: changes,
      ),
      transaction: transaction,
    );
  }
}
