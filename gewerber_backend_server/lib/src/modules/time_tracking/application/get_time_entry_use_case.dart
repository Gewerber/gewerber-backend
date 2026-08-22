import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/time_entry_gateway.dart';

@singleton
class GetTimeEntryUseCase {
  GetTimeEntryUseCase(this._tenantResolver, this._entries);

  final TenantResolver _tenantResolver;
  final TimeEntryGateway _entries;

  Future<TimeEntry> call(
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
    return entry;
  }
}
