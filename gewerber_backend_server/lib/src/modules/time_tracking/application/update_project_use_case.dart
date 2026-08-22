import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../../invoicing/domain/customer_gateway.dart';
import '../domain/project_gateway.dart';

@singleton
class UpdateProjectUseCase {
  UpdateProjectUseCase(
    this._tenantResolver,
    this._projects,
    this._customers,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final ProjectGateway _projects;
  final CustomerGateway _customers;
  final AuditService _audit;

  Future<Project> call(
    Session session,
    UpdateProjectRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final project = await _projects.findById(session, request.projectId);
    if (project == null || project.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'Project',
        entityId: '${request.projectId}',
      );
    }
    if (request.name.trim().isEmpty) {
      throw ValidationException(
        message: 'Project name is required.',
        field: 'name',
      );
    }
    if (request.hourlyRateCents != null && request.hourlyRateCents! < 0) {
      throw ValidationException(
        message: 'Hourly rate must not be negative.',
        field: 'hourlyRateCents',
      );
    }
    if (request.customerId != null) {
      final customer = await _customers.findById(session, request.customerId!);
      if (customer == null || customer.businessId != tenant.businessId) {
        throw NotFoundException(
          entityType: 'Customer',
          entityId: '${request.customerId}',
        );
      }
    }

    final updated = await _projects.update(
      session,
      project.copyWith(
        name: request.name.trim(),
        status: request.status,
        customerId: request.customerId,
        hourlyRateCents: request.hourlyRateCents,
        notes: request.notes,
        updatedAt: DateTime.now(),
      ),
    );
    await _audit.log(
      session,
      action: 'project.update',
      entityType: 'Project',
      entityId: '${updated.id}',
      tenant: tenant,
    );
    return updated;
  }
}
