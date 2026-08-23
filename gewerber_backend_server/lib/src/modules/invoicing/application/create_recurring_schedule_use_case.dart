import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';
import '../domain/recurrence.dart';

/// Attaches a recurring schedule to an invoice of the current tenant, turning
/// it into the source of future materialized invoices.
///
/// When no explicit [CreateRecurringScheduleRequest.nextRecurrenceDate] is
/// given, the next issue date is recalculated as one interval after the
/// invoice's `issueDate` (so the source itself is not immediately duplicated).
@singleton
class CreateRecurringScheduleUseCase {
  CreateRecurringScheduleUseCase(
    this._tenantResolver,
    this._invoices,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final AuditService _audit;

  Future<Invoice> call(
    Session session,
    CreateRecurringScheduleRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final invoice = await _invoices.findById(session, request.invoiceId);
    if (invoice == null || invoice.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'Invoice',
        entityId: '${request.invoiceId}',
      );
    }
    if (invoice.recurrenceInterval != null) {
      throw ConflictException(
        message:
            'Invoice ${invoice.number} already has a recurring schedule. '
            'Cancel it before creating a new one.',
      );
    }

    final next =
        request.nextRecurrenceDate ??
        advanceRecurrence(invoice.issueDate, request.interval);
    _validateBounds(
      next: next,
      endDate: request.recurrenceEndDate,
      maxOccurrences: request.recurrenceMaxOccurrences,
    );

    final updated = await _invoices.update(
      session,
      invoice.copyWith(
        recurrenceInterval: request.interval,
        nextRecurrenceDate: next,
        recurrenceEndDate: request.recurrenceEndDate,
        recurrenceMaxOccurrences: request.recurrenceMaxOccurrences,
        recurrenceOccurrencesCreated: 0,
      ),
    );

    await _audit.log(
      session,
      action: 'recurringSchedule.create',
      entityType: 'RecurringSchedule',
      entityId: '${updated.id}',
      changes: {'interval': request.interval.name},
      tenant: tenant,
    );
    return updated;
  }

  void _validateBounds({
    required DateTime next,
    required DateTime? endDate,
    required int? maxOccurrences,
  }) {
    if (endDate != null && !endDate.isAfter(next)) {
      throw ValidationException(
        message: 'The recurrence end date must be after the next issue date.',
        field: 'recurrenceEndDate',
      );
    }
    if (maxOccurrences != null && maxOccurrences < 1) {
      throw ValidationException(
        message: 'The maximum number of occurrences must be at least 1.',
        field: 'recurrenceMaxOccurrences',
      );
    }
  }
}
