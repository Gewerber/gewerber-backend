import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/business_scoped_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/cancel_recurring_schedule_use_case.dart';
import '../application/create_recurring_schedule_use_case.dart';
import '../application/get_recurring_schedule_use_case.dart';
import '../application/list_recurring_schedules_use_case.dart';
import '../application/update_recurring_schedule_use_case.dart';

/// Management of recurring invoice schedules.
///
/// A schedule is the recurrence configuration of a source invoice; due
/// schedules are materialized into new draft invoices by the
/// `process-recurring-invoices` background job.
class RecurringScheduleEndpoint extends BusinessScopedEndpoint {
  /// Attaches a recurring schedule to an invoice. The next issue date is
  /// recalculated from the invoice's issue date when not given explicitly.
  Future<Invoice> create(
    Session session,
    CreateRecurringScheduleRequest request, {
    int? businessId,
  }) {
    return getIt<CreateRecurringScheduleUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  /// Returns the schedule (i.e. its source invoice) or `NotFoundException`
  /// when it does not exist.
  Future<Invoice> get(Session session, int invoiceId, {int? businessId}) {
    return getIt<GetRecurringScheduleUseCase>().call(
      session,
      invoiceId,
      businessId: businessId,
    );
  }

  /// Lists all schedules of the tenant, upcoming next issue first.
  Future<List<Invoice>> list(
    Session session, {
    int? limit,
    int? offset,
    int? businessId,
  }) {
    return getIt<ListRecurringSchedulesUseCase>().call(
      session,
      limit: limit,
      offset: offset,
      businessId: businessId,
    );
  }

  /// Updates schedule settings (`null` fields keep their current value).
  Future<Invoice> update(
    Session session,
    UpdateRecurringScheduleRequest request, {
    int? businessId,
  }) {
    return getIt<UpdateRecurringScheduleUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  /// Cancels the schedule; already materialized invoices are kept.
  Future<Invoice> cancel(Session session, int invoiceId, {int? businessId}) {
    return getIt<CancelRecurringScheduleUseCase>().call(
      session,
      invoiceId,
      businessId: businessId,
    );
  }
}
