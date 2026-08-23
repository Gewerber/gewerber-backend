import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';
import '../domain/recurrence.dart';

/// Updates an existing recurring schedule of the current tenant.
///
/// Fields left `null` in the request keep their current value. To lift a
/// limit entirely, set the matching `clear…` flag ([UpdateRecurringScheduleRequest
/// .clearRecurrenceEndDate] / [UpdateRecurringScheduleRequest
/// .clearMaxOccurrences]); a flag takes precedence over the field's value.
/// When the interval changes and no explicit [UpdateRecurringScheduleRequest
/// .nextRecurrenceDate] is given, the next issue date is recalculated from the
/// currently scheduled date (or, for finished schedules, one interval after
/// the source's issue date) using the new interval.
@singleton
class UpdateRecurringScheduleUseCase {
  UpdateRecurringScheduleUseCase(
    this._tenantResolver,
    this._invoices,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final AuditService _audit;

  Future<Invoice> call(
    Session session,
    UpdateRecurringScheduleRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final invoice = await _invoices.findById(session, request.invoiceId);
    if (invoice == null || invoice.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'RecurringSchedule',
        entityId: '${request.invoiceId}',
      );
    }
    final currentInterval = invoice.recurrenceInterval;
    if (currentInterval == null) {
      throw NotFoundException(
        entityType: 'RecurringSchedule',
        entityId: '${request.invoiceId}',
      );
    }

    final interval = request.interval ?? currentInterval;
    DateTime? next;
    if (request.nextRecurrenceDate != null) {
      next = request.nextRecurrenceDate!;
    } else if (interval != currentInterval) {
      // Recalculate: one new-interval step from the currently scheduled date,
      // anchored on the issue date when the schedule already finished.
      final base =
          invoice.nextRecurrenceDate ??
          advanceRecurrence(invoice.issueDate, currentInterval);
      next = advanceRecurrence(base, interval);
    } else {
      next = invoice.nextRecurrenceDate;
    }

    // A clear flag wins over the field's value: it removes the limit
    // regardless of what the request carries in the field itself.
    final endDate = request.clearRecurrenceEndDate
        ? null
        : (request.recurrenceEndDate ?? invoice.recurrenceEndDate);
    if (next != null && endDate != null && !endDate.isAfter(next)) {
      throw ValidationException(
        message: 'The recurrence end date must be after the next issue date.',
        field: 'recurrenceEndDate',
      );
    }
    final maxOccurrences = request.clearMaxOccurrences
        ? null
        : (request.recurrenceMaxOccurrences ??
              invoice.recurrenceMaxOccurrences);
    if (maxOccurrences != null && maxOccurrences < 1) {
      throw ValidationException(
        message: 'The maximum number of occurrences must be at least 1.',
        field: 'recurrenceMaxOccurrences',
      );
    }

    final updated = await _invoices.update(
      session,
      invoice.copyWith(
        recurrenceInterval: interval,
        nextRecurrenceDate: next,
        recurrenceEndDate: endDate,
        recurrenceMaxOccurrences: maxOccurrences,
      ),
    );

    await _audit.log(
      session,
      action: 'recurringSchedule.update',
      entityType: 'RecurringSchedule',
      entityId: '${updated.id}',
      changes: {'interval': interval.name},
      tenant: tenant,
    );
    return updated;
  }
}
