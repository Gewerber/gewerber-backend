import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class InvoiceItemGateway {
  Future<List<InvoiceItem>> insertAll(
    Session session,
    List<InvoiceItem> items, {
    Transaction? transaction,
  });

  Future<List<InvoiceItem>> findByInvoiceId(Session session, int invoiceId);

  /// Loads items of many invoices in one query, ordered by invoice, then
  /// position, then id.
  Future<List<InvoiceItem>> findByInvoiceIds(
    Session session,
    List<int> invoiceIds,
  );

  Future<void> deleteByInvoiceId(
    Session session,
    int invoiceId, {
    Transaction? transaction,
  });
}
