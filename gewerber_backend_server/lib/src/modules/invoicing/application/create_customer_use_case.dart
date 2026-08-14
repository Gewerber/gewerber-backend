import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/customer_gateway.dart';

@singleton
class CreateCustomerUseCase {
  CreateCustomerUseCase(this._tenantResolver, this._customers, this._audit);

  final TenantResolver _tenantResolver;
  final CustomerGateway _customers;
  final AuditService _audit;

  Future<Customer> call(
    Session session,
    CreateCustomerRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    _validate(request);
    final customer = await _customers.create(
      session,
      Customer(
        businessId: tenant.businessId,
        name: request.name.trim(),
        companyName: request.companyName,
        vatId: request.vatId,
        email: request.email,
        phone: request.phone,
        address: request.address,
        notes: request.notes,
      ),
    );
    await _audit.log(
      session,
      action: 'customer.create',
      entityType: 'Customer',
      entityId: '${customer.id}',
      tenant: tenant,
    );
    return customer;
  }

  void _validate(CreateCustomerRequest request) {
    if (request.name.trim().isEmpty) {
      throw ValidationException(
        message: 'Customer name is required.',
        field: 'name',
      );
    }
  }
}
