import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class TimeEntryGateway {
  Future<TimeEntry> create(
    Session session,
    TimeEntry entry, {
    Transaction? transaction,
  });

  Future<TimeEntry?> findById(Session session, int id);

  /// Loads every entry with an id from [ids], regardless of state. Missing
  /// ids are simply absent from the result — callers must detect that.
  Future<List<TimeEntry>> findByIds(Session session, Set<int> ids);

  Future<TimeEntry> update(
    Session session,
    TimeEntry entry, {
    Transaction? transaction,
  });

  /// Marks every entry in [ids] as invoiced at [invoicedAt] using a single
  /// batched `UPDATE ... WHERE id IN (...)` inside a transaction.
  Future<void> markInvoiced(Session session, Set<int> ids, DateTime invoicedAt);

  /// The currently running timer of a business, if any.
  Future<TimeEntry?> findRunning(Session session, int businessId);

  Future<List<TimeEntry>> find(
    Session session, {
    required int businessId,
    int? projectId,
    int? taskId,
    DateTime? from,
    DateTime? to,
    bool? billable,
    bool uninvoicedOnly = false,
    int? limit,
    int? offset,
  });

  Future<TimeEntry> delete(
    Session session,
    TimeEntry entry, {
    Transaction? transaction,
  });
}
