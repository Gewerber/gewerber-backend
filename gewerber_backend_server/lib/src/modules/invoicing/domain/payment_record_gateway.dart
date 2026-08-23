import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class PaymentRecordGateway {
  Future<PaymentRecord> create(
    Session session,
    PaymentRecord record, {
    Transaction? transaction,
  });

  Future<List<PaymentRecord>> findByInvoiceId(
    Session session,
    int invoiceId, {
    Transaction? transaction,
  });
}
