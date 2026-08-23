import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/pagination/list_limits.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/customer_gateway.dart';

/// Paged variant of [ListCustomersUseCase] that additionally returns the
/// total number of matching rows, so clients can build page indicators.
///
/// Pilot for the offset-based pagination pattern; a cursor-based variant may
/// follow for very large tenants.
@singleton
class ListCustomersPageUseCase {
  ListCustomersPageUseCase(this._tenantResolver, this._customers);

  final TenantResolver _tenantResolver;
  final CustomerGateway _customers;

  Future<CustomerListPage> call(
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
    final effectiveLimit = clampListLimit(limit);
    final effectiveOffset = offset ?? 0;

    final items = await _customers.find(
      session,
      businessId: tenant.businessId,
      status: status,
      limit: effectiveLimit,
      offset: effectiveOffset,
    );
    final totalCount = await _customers.count(
      session,
      businessId: tenant.businessId,
      status: status,
    );

    return CustomerListPage(
      items: items,
      totalCount: totalCount,
      limit: effectiveLimit,
      offset: effectiveOffset,
    );
  }
}
