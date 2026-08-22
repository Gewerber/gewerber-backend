import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_context.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/project_gateway.dart';
import '../domain/task_gateway.dart';
import '../domain/time_entry_gateway.dart';

/// Starts a timer: creates a running time entry (no `stoppedAt`).
/// Only one timer may run per business.
@singleton
class StartTimerUseCase {
  StartTimerUseCase(
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
    StartTimerRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );

    final running = await _entries.findRunning(session, tenant.businessId);
    if (running != null) {
      throw ConflictException(
        message:
            'A timer is already running. Stop it before starting a new '
            'one.',
      );
    }

    await _validateReferences(
      session,
      tenant,
      request.projectId,
      request.taskId,
    );

    final entry = await _entries.create(
      session,
      TimeEntry(
        businessId: tenant.businessId,
        projectId: request.projectId,
        taskId: request.taskId,
        description: request.description,
        startedAt: request.startedAt ?? DateTime.now(),
        billable: request.billable,
      ),
    );
    await _audit.log(
      session,
      action: 'time_entry.startTimer',
      entityType: 'TimeEntry',
      entityId: '${entry.id}',
      tenant: tenant,
    );
    return entry;
  }

  Future<void> _validateReferences(
    Session session,
    TenantContext tenant,
    int? projectId,
    int? taskId,
  ) async {
    if (projectId != null) {
      final project = await _projects.findById(session, projectId);
      if (project == null || project.businessId != tenant.businessId) {
        throw NotFoundException(entityType: 'Project', entityId: '$projectId');
      }
    }
    if (taskId != null) {
      final task = await _tasks.findById(session, taskId);
      if (task == null || task.businessId != tenant.businessId) {
        throw NotFoundException(entityType: 'Task', entityId: '$taskId');
      }
    }
  }
}
