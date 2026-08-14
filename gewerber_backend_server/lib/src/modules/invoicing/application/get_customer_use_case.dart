import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/customer_gateway.dart';

@singleton
class GetCustomerUseCase {
  GetCustomerUseCase(this._tenantResolver, this._customers);

  final TenantResolver _tenantResolver;
  final CustomerGateway _customers;

  Future<Customer> call(
    Session session,
    int customerId, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final customer = await _customers.findById(session, customerId);
    if (customer == null || customer.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'Customer',
        entityId: '$customerId',
      );
    }
    return customer;
  }
}
