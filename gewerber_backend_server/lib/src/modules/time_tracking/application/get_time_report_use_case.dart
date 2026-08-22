import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../../business/domain/business_settings_gateway.dart';
import '../domain/project_gateway.dart';
import '../domain/task_gateway.dart';
import '../domain/time_entry_gateway.dart';
import '../domain/time_rounding.dart';

/// Aggregates stopped time entries of the tenant into a per project/task
/// report. Running timers are excluded.
@singleton
class GetTimeReportUseCase {
  GetTimeReportUseCase(
    this._tenantResolver,
    this._entries,
    this._projects,
    this._tasks,
    this._settings,
  );

  final TenantResolver _tenantResolver;
  final TimeEntryGateway _entries;
  final ProjectGateway _projects;
  final TaskGateway _tasks;
  final BusinessSettingsGateway _settings;

  Future<TimeReport> call(
    Session session, {
    required DateTime from,
    required DateTime to,
    int? projectId,
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    if (to.isBefore(from)) {
      throw ValidationException(
        message: 'Report start must be before its end.',
        field: 'to',
      );
    }

    final settings = await _settings.findByBusinessId(
      session,
      tenant.businessId,
    );
    final roundingMode = settings?.roundingMode ?? RoundingMode.none;
    final granularity = settings?.roundingGranularityMinutes ?? 1;

    final entries = await _entries.find(
      session,
      businessId: tenant.businessId,
      projectId: projectId,
      from: from,
      to: to,
      limit: 10000,
      offset: 0,
    );

    final groups = <String, TimeReportLine>{};
    var totalMinutes = 0;
    var billableMinutes = 0;
    var roundedMinutes = 0;

    for (final entry in entries) {
      if (entry.stoppedAt == null || entry.durationMinutes == null) {
        continue; // running timers are not part of reports
      }
      final duration = entry.durationMinutes!;
      final rounded = TimeRounding.apply(
        minutes: duration,
        mode: roundingMode,
        granularityMinutes: granularity,
      );

      totalMinutes += duration;
      if (entry.billable) billableMinutes += duration;
      roundedMinutes += rounded;

      final key = '${entry.projectId ?? -1}:${entry.taskId ?? -1}';
      final existing = groups[key];
      groups[key] = TimeReportLine(
        projectId: entry.projectId,
        projectName: null,
        taskId: entry.taskId,
        taskName: null,
        entryCount: (existing?.entryCount ?? 0) + 1,
        totalMinutes: (existing?.totalMinutes ?? 0) + duration,
        billableMinutes:
            (existing?.billableMinutes ?? 0) + (entry.billable ? duration : 0),
        roundedMinutes: (existing?.roundedMinutes ?? 0) + rounded,
      );
    }

    final projectNames = await _projectNames(session, groups);
    final taskNames = await _taskNames(session, groups);
    final lines =
        [
          for (final line in groups.values)
            line.copyWith(
              projectName: line.projectId == null
                  ? null
                  : projectNames[line.projectId],
              taskName: line.taskId == null ? null : taskNames[line.taskId],
            ),
        ]..sort(
          (a, b) => (a.projectName ?? '').compareTo(b.projectName ?? ''),
        );

    return TimeReport(
      from: from,
      to: to,
      totalMinutes: totalMinutes,
      billableMinutes: billableMinutes,
      roundedMinutes: roundedMinutes,
      lines: lines,
    );
  }

  Future<Map<int, String>> _projectNames(
    Session session,
    Map<String, TimeReportLine> groups,
  ) async {
    final ids = groups.values.map((l) => l.projectId).whereType<int>().toSet();
    final result = <int, String>{};
    for (final id in ids) {
      final project = await _projects.findById(session, id);
      if (project != null) result[id] = project.name;
    }
    return result;
  }

  Future<Map<int, String>> _taskNames(
    Session session,
    Map<String, TimeReportLine> groups,
  ) async {
    final ids = groups.values.map((l) => l.taskId).whereType<int>().toSet();
    final result = <int, String>{};
    for (final id in ids) {
      final task = await _tasks.findById(session, id);
      if (task != null) result[id] = task.name;
    }
    return result;
  }
}
