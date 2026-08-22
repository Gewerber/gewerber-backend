import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/time_entry_gateway.dart';

@Singleton(as: TimeEntryGateway)
class ServerpodTimeEntryGateway implements TimeEntryGateway {
  @override
  Future<TimeEntry> create(
    Session session,
    TimeEntry entry, {
    Transaction? transaction,
  }) {
    return TimeEntry.db.insertRow(session, entry, transaction: transaction);
  }

  @override
  Future<TimeEntry?> findById(Session session, int id) {
    return TimeEntry.db.findById(session, id);
  }

  @override
  Future<TimeEntry> update(
    Session session,
    TimeEntry entry, {
    Transaction? transaction,
  }) {
    return TimeEntry.db.updateRow(session, entry, transaction: transaction);
  }

  @override
  Future<TimeEntry?> findRunning(Session session, int businessId) async {
    final running = await TimeEntry.db.find(
      session,
      where: (t) => t.businessId.equals(businessId) & t.stoppedAt.equals(null),
      limit: 1,
    );
    return running.firstOrNull;
  }

  @override
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
  }) {
    return TimeEntry.db.find(
      session,
      where: (t) {
        var expression = t.businessId.equals(businessId);
        if (projectId != null) {
          expression = expression & t.projectId.equals(projectId);
        }
        if (taskId != null) {
          expression = expression & t.taskId.equals(taskId);
        }
        if (from != null) {
          expression = expression & (t.startedAt >= from);
        }
        if (to != null) {
          expression = expression & (t.startedAt <= to);
        }
        if (billable != null) {
          expression = expression & t.billable.equals(billable);
        }
        if (uninvoicedOnly) {
          expression = expression & t.invoicedAt.equals(null);
        }
        return expression;
      },
      orderByList: (t) => [t.startedAt.desc()],
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<TimeEntry> delete(
    Session session,
    TimeEntry entry, {
    Transaction? transaction,
  }) {
    return TimeEntry.db.deleteRow(session, entry, transaction: transaction);
  }
}
