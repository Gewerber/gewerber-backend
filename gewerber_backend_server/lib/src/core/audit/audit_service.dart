import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';
import '../tenant/tenant_context.dart';

@singleton
class AuditService {
  Future<void> log(
    Session session, {
    required String action,
    required String entityType,
    String? entityId,
    Map<String, String>? changes,
    TenantContext? tenant,
  }) async {
    await AuditEntry.db.insertRow(
      session,
      AuditEntry(
        businessId: tenant?.businessId,
        userId: tenant?.userId,
        action: action,
        entityType: entityType,
        entityId: entityId,
        changes: changes,
      ),
    );
  }
}
