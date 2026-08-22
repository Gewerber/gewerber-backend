import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class TimeEntryGateway {
  Future<TimeEntry> create(
    Session session,
    TimeEntry entry, {
    Transaction? transaction,
  });

  Future<TimeEntry?> findById(Session session, int id);

  Future<TimeEntry> update(
    Session session,
    TimeEntry entry, {
    Transaction? transaction,
  });

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
