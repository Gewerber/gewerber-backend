import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/project_gateway.dart';

@singleton
class DeleteProjectUseCase {
  DeleteProjectUseCase(
    this._tenantResolver,
    this._projects,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final ProjectGateway _projects;
  final AuditService _audit;

  Future<void> call(
    Session session,
    int projectId, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final project = await _projects.findById(session, projectId);
    if (project == null || project.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'Project',
        entityId: '$projectId',
      );
    }

    await _projects.delete(session, project);
    await _audit.log(
      session,
      action: 'project.delete',
      entityType: 'Project',
      entityId: '$projectId',
      tenant: tenant,
    );
  }
}
