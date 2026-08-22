import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/task_gateway.dart';

@singleton
class UpdateTaskUseCase {
  UpdateTaskUseCase(
    this._tenantResolver,
    this._tasks,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final TaskGateway _tasks;
  final AuditService _audit;

  Future<Task> call(
    Session session,
    UpdateTaskRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final task = await _tasks.findById(session, request.taskId);
    if (task == null || task.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'Task',
        entityId: '${request.taskId}',
      );
    }
    if (request.name.trim().isEmpty) {
      throw ValidationException(
        message: 'Task name is required.',
        field: 'name',
      );
    }

    final updated = await _tasks.update(
      session,
      task.copyWith(
        name: request.name.trim(),
        status: request.status,
        hourlyRateCents: request.hourlyRateCents,
        updatedAt: DateTime.now(),
      ),
    );
    await _audit.log(
      session,
      action: 'task.update',
      entityType: 'Task',
      entityId: '${updated.id}',
      tenant: tenant,
    );
    return updated;
  }
}
