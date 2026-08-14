import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/business_scoped_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/get_payment_status_use_case.dart';
import '../application/record_payment_use_case.dart';

class PaymentEndpoint extends BusinessScopedEndpoint {
  Future<PaymentRecord> record(
    Session session,
    RecordPaymentRequest request, {
    int? businessId,
  }) {
    return getIt<RecordPaymentUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  Future<InvoicePaymentStatus> status(
    Session session,
    int invoiceId, {
    int? businessId,
  }) {
    return getIt<GetPaymentStatusUseCase>().call(
      session,
      invoiceId,
      businessId: businessId,
    );
  }
}
