import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class ProjectGateway {
  Future<Project> create(
    Session session,
    Project project, {
    Transaction? transaction,
  });

  Future<Project?> findById(Session session, int id);

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
