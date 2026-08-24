import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../domain/invoice_gateway.dart';

/// System job (no tenant scope): marks sent/partially paid invoices whose due
/// date has passed as `overdue`.
///
/// Every affected business is audited as a system event
/// (`invoice.markOverdue`) with the `businessId` filled and the updated row
/// count — no user attribution, the job runs unattended.
@singleton
class MarkOverdueInvoicesUseCase {
  MarkOverdueInvoicesUseCase(this._invoices, this._audit);

  final InvoiceGateway _invoices;
  final AuditService _audit;

  /// Returns the total number of marked invoices across all businesses.
  Future<int> call(Session session, {DateTime? now}) async {
    final reference = now ?? DateTime.now();
    final updatedByBusiness = await _invoices.markOverdue(session, reference);

    var total = 0;
    for (final entry in updatedByBusiness.entries) {
      await _audit.log(
        session,
        action: 'invoice.markOverdue',
        entityType: 'Invoice',
        changes: {
          'count': '${entry.value}',
          'reference': reference.toUtc().toIso8601String(),
        },
        businessId: entry.key,
      );
      total += entry.value;
    }
    return total;
  }
}
