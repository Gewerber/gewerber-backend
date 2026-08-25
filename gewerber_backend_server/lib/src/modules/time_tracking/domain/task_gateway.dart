import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class TaskGateway {
  Future<Task> create(
    Session session,
    Task task, {
    Transaction? transaction,
  });

  Future<Task?> findById(Session session, int id);

  /// Loads every task with an id from [ids], regardless of state. Missing ids
  /// are simply absent from the result — callers must detect that.
  ///
  /// Defence-in-depth: callers deriving [ids] from tenant-scoped queries
  /// should pass [businessId] so rows of another tenant are filtered out
  /// even when a future caller forwards unvalidated ids (IDOR backstop).
  Future<List<Task>> findByIds(
    Session session,
    Set<int> ids, {
    int? businessId,
  });

  Future<Task> update(Session session, Task task);

  Future<List<Task>> findByProjectId(Session session, int projectId);

  Future<List<Task>> find(
    Session session, {
    required int businessId,
    TaskStatus? status,
    int? limit,
    int? offset,
  });
}
