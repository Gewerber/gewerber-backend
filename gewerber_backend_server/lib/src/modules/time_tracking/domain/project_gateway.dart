import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class ProjectGateway {
  Future<Project> create(
    Session session,
    Project project, {
    Transaction? transaction,
  });

  Future<Project?> findById(Session session, int id);

  /// Loads every project with an id from [ids], regardless of state. Missing
  /// ids are simply absent from the result — callers must detect that.
  ///
  /// Defence-in-depth: callers deriving [ids] from tenant-scoped queries
  /// should pass [businessId] so rows of another tenant are filtered out
  /// even when a future caller forwards unvalidated ids (IDOR backstop).
  Future<List<Project>> findByIds(
    Session session,
    Set<int> ids, {
    int? businessId,
  });

  Future<Project> update(Session session, Project project);

  Future<List<Project>> find(
    Session session, {
    required int businessId,
    ProjectStatus? status,
    int? limit,
    int? offset,
  });

  Future<Project> delete(
    Session session,
    Project project, {
    Transaction? transaction,
  });
}
