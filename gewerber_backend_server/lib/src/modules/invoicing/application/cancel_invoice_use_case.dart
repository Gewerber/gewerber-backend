import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';

@singleton
class CancelInvoiceUseCase {
  CancelInvoiceUseCase(this._tenantResolver, this._invoices, this._audit);

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

    // Cancellation and storno are separate semantics. The row lock keeps
    // "cancel original" atomic with credit-note creation/issuance, which lock
    // the same original row.
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

      if (invoice.type == InvoiceType.creditNote) {
        if (invoice.status != InvoiceStatus.draft) {
          throw ConflictException(
            message:
                'Issued credit notes are immutable and cannot be cancelled. '
                'A draft credit note can be cancelled to discard it.',
          );
        }
      } else {
        if (invoice.status == InvoiceStatus.paid ||
            invoice.status == InvoiceStatus.cancelled) {
          throw ConflictException(
            message: 'Cannot cancel a paid or already cancelled invoice.',
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
                'Invoice ${invoice.number} is linked to a credit note. '
                'Cancel or delete the credit note draft first, or issue it.',
          );
        }
      }

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
        action: 'invoice.cancel',
        entityType: 'Invoice',
        entityId: '${updated.id}',
        changes: {'status': InvoiceStatus.cancelled.name},
        tenant: tenant,
        transaction: transaction,
      );
      return updated;
    });
  }
}
