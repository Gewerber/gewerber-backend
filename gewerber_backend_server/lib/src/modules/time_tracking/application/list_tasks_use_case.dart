import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/pagination/list_limits.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/project_gateway.dart';
import '../domain/task_gateway.dart';

@singleton
class ListTasksUseCase {
  ListTasksUseCase(
    this._tenantResolver,
    this._projects,
    this._tasks,
  );

  final TenantResolver _tenantResolver;
  final ProjectGateway _projects;
  final TaskGateway _tasks;

  Future<List<Task>> call(
    Session session, {
    int? projectId,
    TaskStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    if (projectId != null) {
      final project = await _projects.findById(session, projectId);
      if (project == null || project.businessId != tenant.businessId) {
        throw NotFoundException(
          entityType: 'Project',
          entityId: '$projectId',
        );
      }
      return _tasks.findByProjectId(session, projectId);
    }
    return _tasks.find(
      session,
      businessId: tenant.businessId,
      status: status,
      limit: clampListLimit(limit),
      offset: offset ?? 0,
    );
  }
}
