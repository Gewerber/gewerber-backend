import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';

@singleton
class MarkInvoiceSentUseCase {
  MarkInvoiceSentUseCase(this._tenantResolver, this._invoices, this._audit);

  static const _creditableStatuses = {
    InvoiceStatus.sent,
    InvoiceStatus.partiallyPaid,
    InvoiceStatus.overdue,
    InvoiceStatus.paid,
  };

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final AuditService _audit;

  Future<Invoice> call(
    Session session,
    int invoiceId, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );

    // Issuance is the legal boundary of a credit note. The whole check/write
    // cycle is transactional and locks both the draft and its original, so
    // two concurrent drafts for one original cannot both become issued.
    return session.db.transaction((transaction) async {
      final invoice = await _invoices.findByIdForUpdate(
        session,
        invoiceId,
        transaction: transaction,
      );
      if (invoice == null || invoice.businessId != tenant.businessId) {
        throw NotFoundException(
          entityType: 'Invoice',
          entityId: '$invoiceId',
        );
      }
      if (invoice.status != InvoiceStatus.draft) {
        throw ConflictException(
          message: 'Only draft invoices can be marked as sent.',
        );
      }

      if (invoice.type == InvoiceType.creditNote) {
        await _validateCreditNoteIssuance(
          session,
          invoice,
          tenantBusinessId: tenant.businessId,
          transaction: transaction,
        );
      }

      final updated = await _invoices.update(
        session,
        invoice.copyWith(
          status: InvoiceStatus.sent,
          updatedAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
      await _audit.log(
        session,
        action: 'invoice.markSent',
        entityType: 'Invoice',
        entityId: '${updated.id}',
        changes: {
          'status': InvoiceStatus.sent.name,
          if (updated.originalInvoiceId != null)
            'originalInvoiceId': '${updated.originalInvoiceId}',
        },
        tenant: tenant,
        transaction: transaction,
      );
      return updated;
    });
  }

  Future<void> _validateCreditNoteIssuance(
    Session session,
    Invoice creditNote, {
    required int tenantBusinessId,
    required Transaction transaction,
  }) async {
    final originalId = creditNote.originalInvoiceId;
    if (originalId == null) {
      throw ConflictException(
        message:
            'Credit note ${creditNote.number} has no original invoice link.',
      );
    }

    final original = await _invoices.findByIdForUpdate(
      session,
      originalId,
      transaction: transaction,
    );
    if (original == null || original.businessId != tenantBusinessId) {
      throw NotFoundException(
        entityType: 'Invoice',
        entityId: '$originalId',
      );
    }
    if (original.type != InvoiceType.invoice) {
      throw ConflictException(
        message: 'Credit notes cannot reference another credit note.',
      );
    }
    if (!_creditableStatuses.contains(original.status)) {
      throw ConflictException(
        message:
            'The original invoice is ${original.status.name} and can no '
            'longer be credited.',
      );
    }

    final issued = await _invoices.findIssuedLinkedCreditNotes(
      session,
      originalId,
      transaction: transaction,
    );
    if (issued.any((invoice) => invoice.id != creditNote.id)) {
      throw ConflictException(
        message:
            'Invoice ${original.number} has already been credited by an '
            'issued credit note.',
      );
    }
  }
}
