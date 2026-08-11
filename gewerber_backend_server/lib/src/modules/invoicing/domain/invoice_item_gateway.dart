import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class InvoiceItemGateway {
  Future<List<InvoiceItem>> insertAll(
    Session session,
    List<InvoiceItem> items, {
    Transaction? transaction,
  });

  Future<List<InvoiceItem>> findByInvoiceId(Session session, int invoiceId);

  Future<void> deleteByInvoiceId(
    Session session,
    int invoiceId, {
    Transaction? transaction,
  });
}
