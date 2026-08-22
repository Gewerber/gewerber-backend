import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/project_gateway.dart';

@singleton
class ListProjectsUseCase {
  ListProjectsUseCase(this._tenantResolver, this._projects);

  final TenantResolver _tenantResolver;
  final ProjectGateway _projects;

  Future<List<Project>> call(
    Session session, {
    ProjectStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    return _projects.find(
      session,
      businessId: tenant.businessId,
      status: status,
      limit: limit ?? 100,
      offset: offset ?? 0,
    );
  }
}
