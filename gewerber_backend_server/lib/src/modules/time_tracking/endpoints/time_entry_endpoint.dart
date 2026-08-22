import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/business_scoped_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/create_time_entries_invoice_use_case.dart';
import '../application/create_time_entry_use_case.dart';
import '../application/delete_time_entry_use_case.dart';
import '../application/get_time_entry_use_case.dart';
import '../application/get_time_report_use_case.dart';
import '../application/list_time_entries_use_case.dart';
import '../application/start_timer_use_case.dart';
import '../application/stop_timer_use_case.dart';
import '../application/update_time_entry_use_case.dart';

class TimeEntryEndpoint extends BusinessScopedEndpoint {
  /// Starts a timer. Only one timer may run per business.
  Future<TimeEntry> startTimer(
    Session session,
    StartTimerRequest request, {
    int? businessId,
  }) {
    return getIt<StartTimerUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  /// Stops the running timer and stores the (rounded) duration.
  Future<TimeEntry> stopTimer(Session session, {int? businessId}) {
    return getIt<StopTimerUseCase>().call(session, businessId: businessId);
  }

  /// Creates a manual time entry.
  Future<TimeEntry> create(
    Session session,
    CreateTimeEntryRequest request, {
    int? businessId,
  }) {
    return getIt<CreateTimeEntryUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  Future<TimeEntry> get(Session session, int timeEntryId, {int? businessId}) {
    return getIt<GetTimeEntryUseCase>().call(
      session,
      timeEntryId,
      businessId: businessId,
    );
  }

  Future<TimeEntry> update(
    Session session,
    UpdateTimeEntryRequest request, {
    int? businessId,
  }) {
    return getIt<UpdateTimeEntryUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  Future<List<TimeEntry>> list(
    Session session, {
    int? projectId,
    int? taskId,
    DateTime? from,
    DateTime? to,
    bool? billable,
    int? limit,
    int? offset,
    int? businessId,
  }) {
    return getIt<ListTimeEntriesUseCase>().call(
      session,
      projectId: projectId,
      taskId: taskId,
      from: from,
      to: to,
      billable: billable,
      limit: limit,
      offset: offset,
      businessId: businessId,
    );
  }

  Future<void> delete(Session session, int timeEntryId, {int? businessId}) {
    return getIt<DeleteTimeEntryUseCase>().call(
      session,
      timeEntryId,
      businessId: businessId,
    );
  }

  /// Aggregates stopped time entries of the period into a report.
  Future<TimeReport> report(
    Session session,
    DateTime from,
    DateTime to, {
    int? projectId,
    int? businessId,
  }) {
    return getIt<GetTimeReportUseCase>().call(
      session,
      from: from,
      to: to,
      projectId: projectId,
      businessId: businessId,
    );
  }

  /// Converts billable, uninvoiced time entries of a project into a draft
  /// invoice.
  Future<Invoice> createInvoice(
    Session session,
    CreateTimeEntriesInvoiceRequest request, {
    int? businessId,
  }) {
    return getIt<CreateTimeEntriesInvoiceUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }
}
