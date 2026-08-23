import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/invoice_item_gateway.dart';

@Singleton(as: InvoiceItemGateway)
class ServerpodInvoiceItemGateway implements InvoiceItemGateway {
  @override
  Future<List<InvoiceItem>> insertAll(
    Session session,
    List<InvoiceItem> items, {
    Transaction? transaction,
  }) {
    return InvoiceItem.db.insert(session, items, transaction: transaction);
  }

  @override
  Future<List<InvoiceItem>> findByInvoiceId(
    Session session,
    int invoiceId,
  ) {
    return InvoiceItem.db.find(
      session,
      where: (t) => t.invoiceId.equals(invoiceId),
      orderBy: (t) => t.position,
    );
  }

  @override
  Future<List<InvoiceItem>> findByInvoiceIds(
    Session session,
    List<int> invoiceIds,
  ) {
    if (invoiceIds.isEmpty) return Future.value(const []);
    // `position` matches the per-invoice ordering of [findByInvoiceId]; the
    // id tiebreak keeps the result deterministic for duplicate positions.
    return InvoiceItem.db.find(
      session,
      where: (t) => t.invoiceId.inSet(invoiceIds.toSet()),
      orderByList: (t) => [t.position.asc(), t.id.asc()],
    );
  }

  @override
  Future<void> deleteByInvoiceId(
    Session session,
    int invoiceId, {
    Transaction? transaction,
  }) {
    return InvoiceItem.db.deleteWhere(
      session,
      where: (t) => t.invoiceId.equals(invoiceId),
      transaction: transaction,
    );
  }
}
