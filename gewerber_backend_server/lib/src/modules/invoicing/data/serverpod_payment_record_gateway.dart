import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/payment_record_gateway.dart';

@Singleton(as: PaymentRecordGateway)
class ServerpodPaymentRecordGateway implements PaymentRecordGateway {
  @override
  Future<PaymentRecord> create(
    Session session,
    PaymentRecord record, {
    Transaction? transaction,
  }) {
    return PaymentRecord.db.insertRow(
      session,
      record,
      transaction: transaction,
    );
  }

  @override
  Future<List<PaymentRecord>> findByInvoiceId(
    Session session,
    int invoiceId, {
    Transaction? transaction,
  }) {
    return PaymentRecord.db.find(
      session,
      where: (t) => t.invoiceId.equals(invoiceId),
      orderBy: (t) => t.paidAt,
      transaction: transaction,
    );
  }
}
