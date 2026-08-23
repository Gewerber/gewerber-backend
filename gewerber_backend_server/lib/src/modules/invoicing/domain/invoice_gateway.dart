import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class InvoiceGateway {
  Future<Invoice> create(
    Session session,
    Invoice invoice, {
    Transaction? transaction,
  });

  Future<Invoice?> findById(Session session, int id);

  /// Finds an invoice by [id] and locks its row (`SELECT ... FOR UPDATE`)
  /// until the surrounding [transaction] completes. Must be called inside a
  /// transaction; serializes concurrent updates on the same invoice.
  Future<Invoice?> findByIdForUpdate(
    Session session,
    int id, {
    required Transaction transaction,
  });

  Future<Invoice> update(
    Session session,
    Invoice invoice, {
    Transaction? transaction,
  });

  Future<List<Invoice>> find(
    Session session, {
    required int businessId,
    InvoiceStatus? status,
    DateTime? issueDate,
    int? limit,
    int? offset,
  });

  /// Recurring source invoices that are due for materialization.
  Future<List<Invoice>> findDueRecurring(Session session, DateTime now);

  /// All invoices of the business that carry an active recurring schedule
  /// (`recurrenceInterval` set), upcoming next issue first.
  Future<List<Invoice>> findRecurring(
    Session session, {
    required int businessId,
    int? limit,
    int? offset,
  });

  /// Marks sent/partially paid invoices whose due date has passed as overdue.
  /// Returns the number of updated invoices.
  Future<int> markOverdue(Session session, DateTime now);

  /// Counts invoices matching the same filter as [find], ignoring
  /// limit/offset — used to build paginated list pages.
  Future<int> count(
    Session session, {
    required int businessId,
    InvoiceStatus? status,
  });

  Future<Invoice> delete(
    Session session,
    Invoice invoice, {
    Transaction? transaction,
  });
}
