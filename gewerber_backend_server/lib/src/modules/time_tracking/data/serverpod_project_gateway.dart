import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/project_gateway.dart';

@Singleton(as: ProjectGateway)
class ServerpodProjectGateway implements ProjectGateway {
  @override
  Future<Project> create(
    Session session,
    Project project, {
    Transaction? transaction,
  }) {
    return Project.db.insertRow(session, project, transaction: transaction);
  }

  @override
  Future<Project?> findById(Session session, int id) {
    return Project.db.findById(session, id);
  }

  @override
  Future<List<Project>> findByIds(
    Session session,
    Set<int> ids, {
    int? businessId,
  }) {
    if (ids.isEmpty) return Future.value(const []);
    return Project.db.find(
      session,
      where: (t) => businessId == null
          ? t.id.inSet(ids)
          : t.id.inSet(ids) & t.businessId.equals(businessId),
    );
  }

  @override
  Future<Project> update(Session session, Project project) {
    return Project.db.updateRow(session, project);
  }

  @override
  Future<List<Project>> find(
    Session session, {
    required int businessId,
    ProjectStatus? status,
    int? limit,
    int? offset,
  }) {
    return Project.db.find(
      session,
      where: (t) => status == null
          ? t.businessId.equals(businessId)
          : t.businessId.equals(businessId) & t.status.equals(status),
      orderByList: (t) => [t.createdAt.desc()],
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<Project> delete(
    Session session,
    Project project, {
    Transaction? transaction,
  }) {
    return Project.db.deleteRow(session, project, transaction: transaction);
  }
}
