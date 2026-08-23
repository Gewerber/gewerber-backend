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
        Invoice(
          id: invoice.id,
          businessId: invoice.businessId,
          number: invoice.number,
          type: invoice.type,
          status: status,
          customerId: invoice.customerId,
          issueDate: invoice.issueDate,
          dueDate: invoice.dueDate,
          serviceDateFrom: invoice.serviceDateFrom,
          serviceDateTo: invoice.serviceDateTo,
          locale: invoice.locale,
          currency: invoice.currency,
          subtotalCents: invoice.subtotalCents,
          vatTotalCents: invoice.vatTotalCents,
          totalCents: invoice.totalCents,
          paymentTermsDays: invoice.paymentTermsDays,
          dunningLevel: invoice.dunningLevel,
          notes: invoice.notes,
          templateId: invoice.templateId,
          pdfDocumentId: invoice.pdfDocumentId,
          recurrenceInterval: invoice.recurrenceInterval,
          nextRecurrenceDate: invoice.nextRecurrenceDate,
          recurrenceEndDate: invoice.recurrenceEndDate,
          recurrenceMaxOccurrences: invoice.recurrenceMaxOccurrences,
          recurrenceOccurrencesCreated: invoice.recurrenceOccurrencesCreated,
          createdAt: invoice.createdAt,
        ),
        transaction: transaction,
      );
      return created;
    });

    await _audit.log(
      session,
      action: 'payment.record',
      entityType: 'Invoice',
      entityId: '${record.invoiceId}',
      changes: {'amountCents': '${record.amountCents}'},
      tenant: tenant,
    );
    return record;
  }
}
