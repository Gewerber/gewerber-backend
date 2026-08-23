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

  /// Loads payment records of many invoices in one query, ordered by paidAt
  /// (then id) within each invoice.
  Future<List<PaymentRecord>> findByInvoiceIds(
    Session session,
    List<int> invoiceIds, {
    Transaction? transaction,
  });
}
