import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/time_entry_gateway.dart';

@singleton
class DeleteTimeEntryUseCase {
  DeleteTimeEntryUseCase(
    this._tenantResolver,
    this._entries,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final TimeEntryGateway _entries;
  final AuditService _audit;

  Future<void> call(
    Session session,
    int timeEntryId, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final entry = await _entries.findById(session, timeEntryId);
    if (entry == null || entry.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'TimeEntry',
        entityId: '$timeEntryId',
      );
    }
    if (entry.invoicedAt != null) {
      throw ConflictException(
        message: 'Time entries that were already invoiced cannot be deleted.',
      );
    }

    await _entries.delete(session, entry);
    await _audit.log(
      session,
      action: 'time_entry.delete',
      entityType: 'TimeEntry',
      entityId: '$timeEntryId',
      tenant: tenant,
    );
  }
}
