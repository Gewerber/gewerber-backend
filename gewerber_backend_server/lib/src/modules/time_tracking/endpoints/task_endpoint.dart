import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/business_scoped_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/create_task_use_case.dart';
import '../application/list_tasks_use_case.dart';
import '../application/update_task_use_case.dart';

class TaskEndpoint extends BusinessScopedEndpoint {
  Future<Task> create(
    Session session,
    CreateTaskRequest request, {
    int? businessId,
  }) {
    return getIt<CreateTaskUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  Future<Task> update(
    Session session,
    UpdateTaskRequest request, {
    int? businessId,
  }) {
    return getIt<UpdateTaskUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  Future<List<Task>> list(
    Session session, {
    int? projectId,
    TaskStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) {
    return getIt<ListTasksUseCase>().call(
      session,
      projectId: projectId,
      status: status,
      limit: limit,
      offset: offset,
      businessId: businessId,
    );
  }
}
