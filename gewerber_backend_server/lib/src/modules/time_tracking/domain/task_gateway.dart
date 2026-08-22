import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class TaskGateway {
  Future<Task> create(
    Session session,
    Task task, {
    Transaction? transaction,
  });

  Future<Task?> findById(Session session, int id);

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
