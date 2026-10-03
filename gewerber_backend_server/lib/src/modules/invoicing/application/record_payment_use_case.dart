import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';
import '../domain/payment_record_gateway.dart';

@singleton
class RecordPaymentUseCase {
  RecordPaymentUseCase(
    this._tenantResolver,
    this._invoices,
    this._payments,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final PaymentRecordGateway _payments;
  final AuditService _audit;

  Future<PaymentRecord> call(
    Session session,
    RecordPaymentRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    if (request.amountCents <= 0) {
      throw ValidationException(
        message: 'Payment amount must be positive.',
        field: 'amountCents',
      );
    }

    // The whole read-modify-write cycle runs inside one transaction and the
    // invoice row is locked (`SELECT ... FOR UPDATE`), so concurrent payments
    // on the same invoice are serialized and cannot double-count the paid
    // total (TOCTOU).
    final record = await session.db.transaction((transaction) async {
      final invoice = await _invoices.findByIdForUpdate(
        session,
        request.invoiceId,
        transaction: transaction,
      );
      if (invoice == null || invoice.businessId != tenant.businessId) {
        throw NotFoundException(
          entityType: 'Invoice',
          entityId: '${request.invoiceId}',
        );
      }
      if (invoice.type == InvoiceType.creditNote) {
        throw ValidationException(
          message: 'Payments cannot be recorded against a credit note.',
          field: 'invoiceId',
        );
      }
      if (invoice.status == InvoiceStatus.cancelled) {
        throw ValidationException(
          message: 'Cannot record payment on a cancelled invoice.',
          field: 'invoiceId',
        );
      }
      final issuedCredits = await _invoices.findIssuedLinkedCreditNotes(
        session,
        invoice.id!,
        transaction: transaction,
      );
      if (issuedCredits.isNotEmpty) {
        throw ValidationException(
          message:
              'Invoice ${invoice.number} has been credited and cannot accept '
              'new payments.',
          field: 'invoiceId',
        );
      }

      final existingTotal = (await _payments.findByInvoiceId(
        session,
        request.invoiceId,
        transaction: transaction,
      )).fold(0, (sum, p) => sum + p.amountCents);
      final paidTotal = existingTotal + request.amountCents;

      if (paidTotal > invoice.totalCents) {
        throw ValidationException(
          message:
              'Payment of $paidTotal cents would exceed the invoice total '
              'of ${invoice.totalCents} cents '
              '(${invoice.totalCents - existingTotal} cents remaining).',
          field: 'amountCents',
        );
      }

      final created = await _payments.create(
        session,
        PaymentRecord(
          invoiceId: invoice.id!,
          paidAt: request.paidAt ?? DateTime.now(),
          amountCents: request.amountCents,
          method: request.method,
          reference: request.reference,
        ),
        transaction: transaction,
      );

      final status = paidTotal >= invoice.totalCents
          ? InvoiceStatus.paid
          : InvoiceStatus.partiallyPaid;
      await _invoices.update(
        session,
        invoice.copyWith(
          status: status,
          updatedAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );

      // Same transaction as the locked read-modify-write cycle: a rolled
      // back payment never leaves an audit entry behind.
      await _audit.log(
        session,
        action: 'payment.record',
        entityType: 'Invoice',
        entityId: '${created.invoiceId}',
        changes: {'amountCents': '${created.amountCents}'},
        tenant: tenant,
        transaction: transaction,
      );
      return created;
    });

    return record;
  }
}
