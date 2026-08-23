import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_context.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/project_gateway.dart';
import '../domain/task_gateway.dart';
import '../domain/time_entry_gateway.dart';

/// Creates a manual time entry with a fixed duration.
@singleton
class CreateTimeEntryUseCase {
  CreateTimeEntryUseCase(
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
    CreateTimeEntryRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
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

    final entry = await _createEntry(session, tenant, request);
    await _audit.log(
      session,
      action: 'time_entry.create',
      entityType: 'TimeEntry',
      entityId: '${entry.id}',
      tenant: tenant,
    );
    return entry;
  }

  /// Creates the manual entry. The unique index
  /// (`time_entry_business_running_idx`, `(businessId, stoppedAt)` with
  /// NULLS NOT DISTINCT) also forbids two stopped entries with byte-identical
  /// end times in one business — for manual input that is a user input
  /// problem, so it is surfaced as a [ValidationException] instead of a 500.
  Future<TimeEntry> _createEntry(
    Session session,
    TenantContext tenant,
    CreateTimeEntryRequest request,
  ) async {
    try {
      return await _entries.create(
        session,
        TimeEntry(
          businessId: tenant.businessId,
          projectId: request.projectId,
          taskId: request.taskId,
          description: request.description,
          startedAt: request.startedAt,
          stoppedAt: request.startedAt.add(
            Duration(minutes: request.durationMinutes),
          ),
          durationMinutes: request.durationMinutes,
          billable: request.billable,
        ),
      );
    } on DatabaseQueryException catch (e) {
      if (e.constraintName == 'time_entry_business_running_idx') {
        throw ValidationException(
          message:
              'A time entry with this exact end time already exists in this '
              'business. Adjust the start time or duration.',
        );
      }
      rethrow;
    }
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
