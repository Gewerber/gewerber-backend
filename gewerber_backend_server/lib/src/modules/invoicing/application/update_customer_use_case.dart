import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/customer_gateway.dart';

@singleton
class UpdateCustomerUseCase {
  UpdateCustomerUseCase(this._tenantResolver, this._customers, this._audit);

  final TenantResolver _tenantResolver;
  final CustomerGateway _customers;
  final AuditService _audit;

  Future<Customer> call(
    Session session,
    UpdateCustomerRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final existing = await _customers.findById(session, request.customerId);
    if (existing == null || existing.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'Customer',
        entityId: '${request.customerId}',
      );
    }
    if (request.name.trim().isEmpty) {
      throw ValidationException(
        message: 'Customer name is required.',
        field: 'name',
      );
    }

    final updated = await _customers.update(
      session,
      Customer(
        id: existing.id,
        businessId: existing.businessId,
        status: request.status,
        name: request.name.trim(),
        companyName: request.companyName,
        vatId: request.vatId,
        email: request.email,
        phone: request.phone,
        address: request.address,
        notes: request.notes,
        createdAt: existing.createdAt,
      ),
    );
    await _audit.log(
      session,
      action: 'customer.update',
      entityType: 'Customer',
      entityId: '${updated.id}',
      tenant: tenant,
    );
    return updated;
  }
}
