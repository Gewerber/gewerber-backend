import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/pagination/list_limits.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/time_entry_gateway.dart';

@singleton
class ListTimeEntriesUseCase {
  ListTimeEntriesUseCase(this._tenantResolver, this._entries);

  final TenantResolver _tenantResolver;
  final TimeEntryGateway _entries;

  Future<List<TimeEntry>> call(
    Session session, {
    int? projectId,
    int? taskId,
    DateTime? from,
    DateTime? to,
    bool? billable,
    int? limit,
    int? offset,
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    return _entries.find(
      session,
      businessId: tenant.businessId,
      projectId: projectId,
      taskId: taskId,
      from: from,
      to: to,
      billable: billable,
      limit: clampListLimit(limit),
      offset: offset ?? 0,
    );
  }
}
