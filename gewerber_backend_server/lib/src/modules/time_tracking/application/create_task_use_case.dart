import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/project_gateway.dart';
import '../domain/task_gateway.dart';

@singleton
class CreateTaskUseCase {
  CreateTaskUseCase(
    this._tenantResolver,
    this._projects,
    this._tasks,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final ProjectGateway _projects;
  final TaskGateway _tasks;
  final AuditService _audit;

  Future<Task> call(
    Session session,
    CreateTaskRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final project = await _projects.findById(session, request.projectId);
    if (project == null || project.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'Project',
        entityId: '${request.projectId}',
      );
    }
    if (request.name.trim().isEmpty) {
      throw ValidationException(
        message: 'Task name is required.',
        field: 'name',
      );
    }

    final task = await _tasks.create(
      session,
      Task(
        businessId: tenant.businessId,
        projectId: project.id!,
        name: request.name.trim(),
        hourlyRateCents: request.hourlyRateCents,
      ),
    );
    await _audit.log(
      session,
      action: 'task.create',
      entityType: 'Task',
      entityId: '${task.id}',
      tenant: tenant,
    );
    return task;
  }
}
