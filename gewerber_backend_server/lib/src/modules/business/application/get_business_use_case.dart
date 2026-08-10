import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/business_gateway.dart';

@singleton
class GetBusinessUseCase {
  GetBusinessUseCase(this._tenantResolver, this._businesses);

  final TenantResolver _tenantResolver;
  final BusinessGateway _businesses;

  Future<Business> call(Session session, {int? businessId}) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final business = await _businesses.findById(session, tenant.businessId);
    if (business == null) {
      throw NotFoundException(
        entityType: 'Business',
        entityId: '${tenant.businessId}',
      );
    }
    return business;
  }
}
