import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/project_gateway.dart';
import '../domain/task_gateway.dart';
import '../domain/time_entry_gateway.dart';

/// Updates a stopped time entry. Running timers cannot be edited — stop the
/// timer first.
@singleton
class UpdateTimeEntryUseCase {
  UpdateTimeEntryUseCase(
    this._tenantResolver,
    this._entries,
    this._projects,
    this._tasks,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final TimeEntryGateway _entries;
  final ProjectGateway _projects;
  final TaskGateway _tasks;
  final AuditService _audit;

  Future<TimeEntry> call(
    Session session,
    UpdateTimeEntryRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final entry = await _entries.findById(session, request.timeEntryId);
    if (entry == null || entry.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'TimeEntry',
        entityId: '${request.timeEntryId}',
      );
    }
    if (entry.stoppedAt == null) {
      throw ConflictException(
        message: 'Running timers cannot be edited. Stop the timer first.',
      );
    }
    if (request.durationMinutes <= 0) {
      throw ValidationException(
        message: 'Duration must be positive.',
        field: 'durationMinutes',
      );
    }
    await _validateReferences(
      session,
      tenant.businessId,
      request.projectId,
      request.taskId,
    );

    final updated = await _entries.update(
      session,
      entry.copyWith(
        projectId: request.projectId,
        taskId: request.taskId,
        description: request.description,
        startedAt: request.startedAt,
        stoppedAt: request.startedAt.add(
          Duration(minutes: request.durationMinutes),
        ),
        durationMinutes: request.durationMinutes,
        billable: request.billable,
        updatedAt: DateTime.now(),
      ),
    );
    await _audit.log(
      session,
      action: 'time_entry.update',
      entityType: 'TimeEntry',
      entityId: '${updated.id}',
      tenant: tenant,
    );
    return updated;
  }

  Future<void> _validateReferences(
    Session session,
    int businessId,
    int? projectId,
    int? taskId,
  ) async {
    if (projectId != null) {
      final project = await _projects.findById(session, projectId);
      if (project == null || project.businessId != businessId) {
        throw NotFoundException(entityType: 'Project', entityId: '$projectId');
      }
    }
    if (taskId != null) {
      final task = await _tasks.findById(session, taskId);
      if (task == null || task.businessId != businessId) {
        throw NotFoundException(entityType: 'Task', entityId: '$taskId');
      }
    }
  }
}
