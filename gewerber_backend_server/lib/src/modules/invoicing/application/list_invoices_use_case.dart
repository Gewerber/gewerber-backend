import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/pagination/list_limits.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';

@singleton
class ListInvoicesUseCase {
  ListInvoicesUseCase(this._tenantResolver, this._invoices);

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;

  Future<List<Invoice>> call(
    Session session, {
    InvoiceStatus? status,
    int? limit,
    int? offset,
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    return _invoices.find(
      session,
      businessId: tenant.businessId,
      status: status,
      limit: clampListLimit(limit),
      offset: offset ?? 0,
    );
  }
}
