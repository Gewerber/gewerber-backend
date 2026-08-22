import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/business_scoped_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/create_project_use_case.dart';
import '../application/delete_project_use_case.dart';
import '../application/get_project_use_case.dart';
import '../application/list_projects_use_case.dart';
import '../application/update_project_use_case.dart';

class ProjectEndpoint extends BusinessScopedEndpoint {
  Future<Project> create(
    Session session,
    CreateProjectRequest request, {
    int? businessId,
  }) {
    return getIt<CreateProjectUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  Future<Project> get(Session session, int projectId, {int? businessId}) {
    return getIt<GetProjectUseCase>().call(
      session,
      projectId,
      businessId: businessId,
    );
  }

  Future<List<Task>> getTasks(
    Session session,
    int projectId, {
    int? businessId,
  }) {
    return getIt<GetProjectUseCase>().tasks(
      session,
      projectId,
      businessId: businessId,
    );
  }

  Future<Project> update(
    Session session,
    UpdateProjectRequest request, {
    int? businessId,
  }) {
    return getIt<UpdateProjectUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  Future<List<Project>> list(
    Session session, {
    ProjectStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) {
    return getIt<ListProjectsUseCase>().call(
      session,
      status: status,
      limit: limit,
      offset: offset,
      businessId: businessId,
    );
  }

  Future<void> delete(Session session, int projectId, {int? businessId}) {
    return getIt<DeleteProjectUseCase>().call(
      session,
      projectId,
      businessId: businessId,
    );
  }
}
