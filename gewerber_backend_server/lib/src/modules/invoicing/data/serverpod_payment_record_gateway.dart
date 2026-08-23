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

  @override
  Future<List<PaymentRecord>> findByInvoiceIds(
    Session session,
    List<int> invoiceIds, {
    Transaction? transaction,
  }) {
    if (invoiceIds.isEmpty) return Future.value(const []);
    // `paidAt` matches the per-invoice ordering of [findByInvoiceId]; the id
    // tiebreak keeps the result deterministic for identical timestamps.
    return PaymentRecord.db.find(
      session,
      where: (t) => t.invoiceId.inSet(invoiceIds.toSet()),
      orderByList: (t) => [t.paidAt.asc(), t.id.asc()],
      transaction: transaction,
    );
  }
}
