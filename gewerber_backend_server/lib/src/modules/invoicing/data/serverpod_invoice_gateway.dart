import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';

@Singleton(as: InvoiceGateway)
class ServerpodInvoiceGateway implements InvoiceGateway {
  @override
  Future<Invoice> create(
    Session session,
    Invoice invoice, {
    Transaction? transaction,
  }) {
    return Invoice.db.insertRow(session, invoice, transaction: transaction);
  }

  @override
  Future<Invoice?> findById(Session session, int id) {
    return Invoice.db.findById(session, id);
  }

  @override
  Future<Invoice> update(
    Session session,
    Invoice invoice, {
    Transaction? transaction,
  }) {
    return Invoice.db.updateRow(session, invoice, transaction: transaction);
  }

  @override
  Future<List<Invoice>> find(
    Session session, {
    required int businessId,
    InvoiceStatus? status,
    int? limit,
    int? offset,
  }) {
    return Invoice.db.find(
      session,
      where: (t) => status == null
          ? t.businessId.equals(businessId)
          : t.businessId.equals(businessId) & t.status.equals(status),
      orderByList: (t) => [t.issueDate.desc()],
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<List<Invoice>> findDueRecurring(Session session, DateTime now) {
    return Invoice.db.find(
      session,
      where: (t) =>
          t.nextRecurrenceDate.notEquals(null) & (t.nextRecurrenceDate <= now),
      limit: 100,
    );
  }

  @override
  Future<int> markOverdue(Session session, DateTime now) async {
    final updated = await Invoice.db.updateWhere(
      session,
      where: (t) =>
          (t.status.equals(InvoiceStatus.sent) |
              t.status.equals(InvoiceStatus.partiallyPaid)) &
          t.dueDate.notEquals(null) &
          (t.dueDate < now),
      columnValues: (t) => [
        t.status(InvoiceStatus.overdue),
        t.updatedAt(DateTime.now()),
      ],
    );
    return updated.length;
  }

  @override
  Future<Invoice> delete(
    Session session,
    Invoice invoice, {
    Transaction? transaction,
  }) {
    return Invoice.db.deleteRow(session, invoice, transaction: transaction);
  }
}
