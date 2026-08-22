import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../../invoicing/domain/customer_gateway.dart';
import '../domain/project_gateway.dart';

@singleton
class CreateProjectUseCase {
  CreateProjectUseCase(
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
    CreateProjectRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
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

    final project = await _projects.create(
      session,
      Project(
        businessId: tenant.businessId,
        name: request.name.trim(),
        customerId: request.customerId,
        hourlyRateCents: request.hourlyRateCents,
        notes: request.notes,
      ),
    );
    await _audit.log(
      session,
      action: 'project.create',
      entityType: 'Project',
      entityId: '${project.id}',
      tenant: tenant,
    );
    return project;
  }
}
