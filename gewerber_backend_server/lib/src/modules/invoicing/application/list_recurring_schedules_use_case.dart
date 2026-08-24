import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/pagination/list_limits.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';

/// Lists all recurring schedules of the current tenant, upcoming next issue
/// first.
@singleton
class ListRecurringSchedulesUseCase {
  ListRecurringSchedulesUseCase(this._tenantResolver, this._invoices);

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;

  Future<List<Invoice>> call(
    Session session, {
    int? limit,
    int? offset,
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    return _invoices.findRecurring(
      session,
      businessId: tenant.businessId,
      limit: clampListLimit(limit),
      offset: offset ?? 0,
    );
  }
}
