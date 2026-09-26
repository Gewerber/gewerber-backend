import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/admin/admin_context.dart';
import '../../../core/audit/audit_service.dart';
import '../../../generated/protocol.dart';
import '../../invoicing/domain/invoice_gateway.dart';
import '../domain/require_confirm.dart';

/// Admin-side cancellation of an invoice. Only open states may be cancelled
/// (`sent`, `partiallyPaid`, `overdue`); drafts are deleted by their owners
/// and paid invoices are immutable (GoBD). Credit notes are never cancelled —
/// a storno is issued through the dedicated credit-note flow.
@singleton
class CancelInvoiceAsAdminUseCase {
  CancelInvoiceAsAdminUseCase(this._invoices, this._audit);

  final InvoiceGateway _invoices;
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
    // concurrent cancellations and credit-note issuance on the same original.
    return session.db.transaction((transaction) async {
      final invoice = await _invoices.findByIdForUpdate(
        session,
        invoiceId,
        transaction: transaction,
      );
      if (invoice == null) {
        throw NotFoundException(entityType: 'Invoice', entityId: '$invoiceId');
      }
      if (invoice.type == InvoiceType.creditNote) {
        throw ConflictException(
          message:
              'Credit note ${invoice.number} cannot be cancelled by an admin.',
        );
      }
      if (!cancellableStatuses.contains(invoice.status)) {
        throw ConflictException(
          message:
              'Invoice ${invoice.number} cannot be cancelled in status '
              '${invoice.status.name}. Only sent, partiallyPaid or overdue '
              'invoices can be cancelled by an admin.',
        );
      }
      final linked = await _invoices.findLinkedCreditNotes(
        session,
        invoice.id!,
        transaction: transaction,
      );
      final activeLinked = linked
          .where((credit) => credit.status != InvoiceStatus.cancelled)
          .toList();
      if (activeLinked.isNotEmpty) {
        throw ConflictException(
          message:
              'Invoice ${invoice.number} is linked to a credit note and '
              'cannot be cancelled.',
        );
      }

      final previousStatus = invoice.status;
      final updated = await _invoices.update(
        session,
        invoice.copyWith(
          status: InvoiceStatus.cancelled,
          updatedAt: DateTime.now().toUtc(),
        ),
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
