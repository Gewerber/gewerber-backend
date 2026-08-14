import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/payment_record_gateway.dart';

@singleton
class GetPaymentStatusUseCase {
  GetPaymentStatusUseCase(this._tenantResolver, this._payments);

  final TenantResolver _tenantResolver;
  final PaymentRecordGateway _payments;

  Future<InvoicePaymentStatus> call(
    Session session,
    int invoiceId, {
    int? businessId,
  }) async {
    await _tenantResolver.resolve(session, businessId: businessId);
    final payments = await _payments.findByInvoiceId(session, invoiceId);
    final paidTotal = payments.fold(0, (sum, p) => sum + p.amountCents);
    return InvoicePaymentStatus(
      invoiceId: invoiceId,
      paidTotalCents: paidTotal,
      remainingCents: paidTotal,
      isPaid: paidTotal > 0,
      payments: payments,
    );
  }
}
