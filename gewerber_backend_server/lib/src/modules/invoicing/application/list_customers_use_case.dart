import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/customer_gateway.dart';

@singleton
class ListCustomersUseCase {
  ListCustomersUseCase(this._tenantResolver, this._customers);

  final TenantResolver _tenantResolver;
  final CustomerGateway _customers;

  Future<List<Customer>> call(
    Session session, {
    CustomerStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    return _customers.find(
      session,
      businessId: tenant.businessId,
      status: status,
      limit: limit ?? 100,
      offset: offset ?? 0,
    );
  }
}
