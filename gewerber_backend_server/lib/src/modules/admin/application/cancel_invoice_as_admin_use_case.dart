import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/admin/admin_context.dart';
import '../../../core/audit/audit_service.dart';
import '../../../generated/protocol.dart';
import '../domain/require_confirm.dart';

/// Admin-side cancellation of an invoice. Only open states may be cancelled
/// (`sent`, `partiallyPaid`, `overdue`); drafts are deleted by their owners
/// and paid invoices are immutable (GoBD).
@singleton
class CancelInvoiceAsAdminUseCase {
  CancelInvoiceAsAdminUseCase(this._audit);

  final AuditService _audit;

  static const Set<InvoiceStatus> cancellableStatuses = {
    InvoiceStatus.sent,
    InvoiceStatus.partiallyPaid,
    InvoiceStatus.overdue,
  };

  Future<Invoice> call(
    Session session, {
    required AdminContext actor,
    required int invoiceId,
    required String reason,
    required bool confirm,
  }) async {
    requireConfirm(confirm);
    if (reason.trim().isEmpty) {
      throw ValidationException(
        message: 'A cancellation reason is required.',
        field: 'reason',
      );
    }

    // Mutation and audit entry share one transaction — the trail can never
    // describe a change that did not happen. The row lock serializes
    // concurrent cancellations on the same invoice.
    return session.db.transaction((transaction) async {
      final invoice = await Invoice.db.findById(
        session,
        invoiceId,
        lockMode: LockMode.forUpdate,
        transaction: transaction,
      );
      if (invoice == null) {
        throw NotFoundException(entityType: 'Invoice', entityId: '$invoiceId');
      }
      if (!cancellableStatuses.contains(invoice.status)) {
        throw ConflictException(
          message:
              'Invoice ${invoice.number} cannot be cancelled in status '
              '${invoice.status.name}. Only sent, partiallyPaid or overdue '
              'invoices can be cancelled by an admin.',
        );
      }

      final previousStatus = invoice.status;
      invoice
        ..status = InvoiceStatus.cancelled
        ..updatedAt = DateTime.now().toUtc();
      final updated = await Invoice.db.updateRow(
        session,
        invoice,
        transaction: transaction,
      );

      await _audit.log(
        session,
        action: 'admin.invoiceCancel',
        entityType: 'Invoice',
        entityId: '${updated.id}',
        changes: {
          'from': previousStatus.name,
          'to': InvoiceStatus.cancelled.name,
          'reason': reason.trim(),
          'businessId': '${updated.businessId}',
        },
        userId: actor.userId,
        transaction: transaction,
      );
      return updated;
    });
  }
}
