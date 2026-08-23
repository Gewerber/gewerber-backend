import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_context.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../../invoicing/application/create_invoice_use_case.dart';
import '../domain/project_gateway.dart';
import '../domain/task_gateway.dart';
import '../domain/time_entry_gateway.dart';

/// Converts billable, not-yet-invoiced time entries into a new draft invoice.
///
/// Two modes:
/// - **Period mode** (default): [CreateTimeEntriesInvoiceRequest.timeEntryIds]
///   is `null` or empty — every billable, uninvoiced, stopped entry of the
///   project within `[from, to]` is billed (legacy behaviour).
/// - **Per-entry mode**: a non-empty [CreateTimeEntriesInvoiceRequest.timeEntryIds]
///   bills ONLY the referenced entries. Every id is validated against the
///   current tenant, the requested project and its billable state:
///   unknown ids, foreign-tenant rows, running/non-billable and already
///   invoiced entries are rejected together in one [ValidationException].
///
/// Entries are grouped by task; the hourly rate is taken from the task with
/// the project rate as fallback. The converted entries are marked with
/// `invoicedAt` so they cannot be billed twice.
@singleton
class CreateTimeEntriesInvoiceUseCase {
  CreateTimeEntriesInvoiceUseCase(
    this._tenantResolver,
    this._projects,
    this._tasks,
    this._entries,
    this._createInvoice,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final ProjectGateway _projects;
  final TaskGateway _tasks;
  final TimeEntryGateway _entries;
  final CreateInvoiceUseCase _createInvoice;
  final AuditService _audit;

  Future<Invoice> call(
    Session session,
    CreateTimeEntriesInvoiceRequest request, {
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

    final explicitIds = request.timeEntryIds;
    final stopped = (explicitIds == null || explicitIds.isEmpty)
        ? await _findByPeriod(session, tenant, request)
        : await _findByExplicitIds(session, tenant, request, explicitIds);
    if (stopped.isEmpty) {
      throw ValidationException(
        message:
            'There are no billable, uninvoiced time entries for this '
            'project in the given period.',
        field: 'projectId',
      );
    }

    final groups = <int?, List<TimeEntry>>{};
    for (final entry in stopped) {
      groups.putIfAbsent(entry.taskId, () => []).add(entry);
    }

    final items = <InvoiceItemRequest>[];
    for (final group in groups.entries) {
      final task = group.key == null
          ? null
          : await _tasks.findById(session, group.key!);
      final rateCents = task?.hourlyRateCents ?? project.hourlyRateCents;
      if (rateCents == null) {
        throw ValidationException(
          message:
              'No hourly rate configured for project "${project.name}"'
              '${task != null ? ' / task "${task.name}"' : ''}.',
          field: 'hourlyRateCents',
        );
      }

      final minutes = group.value.fold<int>(
        0,
        (sum, e) => sum + e.durationMinutes!,
      );
      final hours = minutes / 60;
      final label = task == null
          ? project.name
          : '${project.name} – ${task.name}';
      items.add(
        InvoiceItemRequest(
          description:
              '$label (${group.value.length} '
              '${group.value.length == 1 ? 'Eintrag' : 'Einträge'}, '
              '${_formatHours(minutes)})',
          quantity: hours,
          unit: InvoiceItemUnit.hour,
          unitPriceCents: rateCents,
          vatRate: VatRate.standard,
        ),
      );
    }

    final invoice = await _createInvoice(
      session,
      CreateInvoiceRequest(
        customerId: request.customerId ?? project.customerId,
        issueDate: request.issueDate,
        items: items,
      ),
      businessId: tenant.businessId,
    );

    // One batched UPDATE instead of one statement per entry.
    await _entries.markInvoiced(
      session,
      {for (final entry in stopped) entry.id!},
      DateTime.now(),
    );

    await _audit.log(
      session,
      action: 'time_entry.createInvoice',
      entityType: 'Invoice',
      entityId: '${invoice.id}',
      changes: {
        'timeEntries': '${stopped.length}',
        if (explicitIds != null && explicitIds.isNotEmpty) 'mode': 'selected',
      },
      tenant: tenant,
    );
    return invoice;
  }

  /// Legacy period mode: every billable, uninvoiced, stopped entry of the
  /// project within the requested period.
  Future<List<TimeEntry>> _findByPeriod(
    Session session,
    TenantContext tenant,
    CreateTimeEntriesInvoiceRequest request,
  ) async {
    final entries = await _entries.find(
      session,
      businessId: tenant.businessId,
      projectId: request.projectId,
      from: request.from,
      to: request.to,
      billable: true,
      uninvoicedOnly: true,
      limit: 10000,
      offset: 0,
    );
    return entries
        .where((e) => e.stoppedAt != null && e.durationMinutes != null)
        .toList();
  }

  /// Per-entry mode: loads exactly the requested ids and validates every one
  /// of them. Any violation aborts the whole call with a [ValidationException]
  /// that names each offending id and its reason — the call never falls back
  /// to silently billing a subset.
  Future<List<TimeEntry>> _findByExplicitIds(
    Session session,
    TenantContext tenant,
    CreateTimeEntriesInvoiceRequest request,
    List<int> requestedIds,
  ) async {
    final uniqueIds = requestedIds.toSet();
    final loaded = await _entries.findByIds(session, uniqueIds);
    final byId = {for (final entry in loaded) entry.id!: entry};

    final problems = <String>[];
    for (final id in uniqueIds) {
      final entry = byId[id];
      if (entry == null) {
        problems.add('$id: does not exist');
      } else if (entry.businessId != tenant.businessId) {
        problems.add('$id: belongs to another business');
      } else if (entry.projectId != request.projectId) {
        problems.add('$id: belongs to another project');
      } else if (entry.stoppedAt == null || entry.durationMinutes == null) {
        problems.add('$id: timer is still running');
      } else if (!entry.billable) {
        problems.add('$id: is not billable');
      } else if (entry.invoicedAt != null) {
        problems.add('$id: already invoiced');
      }
    }
    if (problems.isNotEmpty) {
      throw ValidationException(
        message:
            'The following selected time entries cannot be invoiced: '
            '${problems.join('; ')}.',
        field: 'timeEntryIds',
      );
    }

    return [
      for (final id in uniqueIds)
        // Null-safe: every id passed the validation above, so the lookup
        // always succeeds.
        byId[id]!,
    ];
  }

  String _formatHours(int minutes) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    if (h == 0) return '${m}min';
    if (m == 0) return '${h}h';
    return '${h}h ${m}min';
  }
}
