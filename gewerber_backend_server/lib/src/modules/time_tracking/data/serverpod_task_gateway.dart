import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/task_gateway.dart';

@Singleton(as: TaskGateway)
class ServerpodTaskGateway implements TaskGateway {
  @override
  Future<Task> create(
    Session session,
    Task task, {
    Transaction? transaction,
  }) {
    return Task.db.insertRow(session, task, transaction: transaction);
  }

  @override
  Future<Task?> findById(Session session, int id) {
    return Task.db.findById(session, id);
  }

  @override
  Future<List<Task>> findByIds(Session session, Set<int> ids) {
    if (ids.isEmpty) return Future.value(const []);
    return Task.db.find(session, where: (t) => t.id.inSet(ids));
  }

  @override
  Future<Task> update(Session session, Task task) {
    return Task.db.updateRow(session, task);
  }

  @override
  Future<List<Task>> findByProjectId(Session session, int projectId) {
    return Task.db.find(
      session,
      where: (t) => t.projectId.equals(projectId),
      orderBy: (t) => t.createdAt,
    );
  }

  @override
  Future<List<Task>> find(
    Session session, {
    required int businessId,
    TaskStatus? status,
    int? limit,
    int? offset,
  }) {
    return Task.db.find(
      session,
      where: (t) => status == null
          ? t.businessId.equals(businessId)
          : t.businessId.equals(businessId) & t.status.equals(status),
      orderByList: (t) => [t.createdAt.desc()],
      limit: limit,
      offset: offset,
    );
  }
}
