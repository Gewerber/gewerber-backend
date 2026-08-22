import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';
import '../domain/payment_record_gateway.dart';

@singleton
class GetPaymentStatusUseCase {
  GetPaymentStatusUseCase(
    this._tenantResolver,
    this._invoices,
    this._payments,
  );

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final PaymentRecordGateway _payments;

  Future<InvoicePaymentStatus> call(
    Session session,
    int invoiceId, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final invoice = await _invoices.findById(session, invoiceId);
    if (invoice == null || invoice.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'Invoice',
        entityId: '$invoiceId',
      );
    }

    final payments = await _payments.findByInvoiceId(session, invoiceId);
    final paidTotal = payments.fold(0, (sum, p) => sum + p.amountCents);
    final remaining = (invoice.totalCents - paidTotal) < 0
        ? 0
        : invoice.totalCents - paidTotal;
    return InvoicePaymentStatus(
      invoiceId: invoiceId,
      paidTotalCents: paidTotal,
      remainingCents: remaining,
      isPaid: paidTotal >= invoice.totalCents,
      payments: payments,
    );
  }
}
