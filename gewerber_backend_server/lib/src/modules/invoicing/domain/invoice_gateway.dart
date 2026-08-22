import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class InvoiceGateway {
  Future<Invoice> create(
    Session session,
    Invoice invoice, {
    Transaction? transaction,
  });

  Future<Invoice?> findById(Session session, int id);

  Future<Invoice> update(
    Session session,
    Invoice invoice, {
    Transaction? transaction,
  });

  Future<List<Invoice>> find(
    Session session, {
    required int businessId,
    InvoiceStatus? status,
    int? limit,
    int? offset,
  });

  /// Recurring source invoices that are due for materialization.
  Future<List<Invoice>> findDueRecurring(Session session, DateTime now);

  /// Marks sent/partially paid invoices whose due date has passed as overdue.
  /// Returns the number of updated invoices.
  Future<int> markOverdue(Session session, DateTime now);

  Future<Invoice> delete(
    Session session,
    Invoice invoice, {
    Transaction? transaction,
  });
}
