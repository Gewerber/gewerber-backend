import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/project_gateway.dart';
import '../domain/task_gateway.dart';

@singleton
class GetProjectUseCase {
  GetProjectUseCase(
    this._tenantResolver,
    this._projects,
    this._tasks,
  );

  final TenantResolver _tenantResolver;
  final ProjectGateway _projects;
  final TaskGateway _tasks;

  Future<Project> call(
    Session session,
    int projectId, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final project = await _projects.findById(session, projectId);
    if (project == null || project.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'Project',
        entityId: '$projectId',
      );
    }
    return project;
  }

  Future<List<Task>> tasks(
    Session session,
    int projectId, {
    int? businessId,
  }) async {
    await call(session, projectId, businessId: businessId);
    return _tasks.findByProjectId(session, projectId);
  }
}
