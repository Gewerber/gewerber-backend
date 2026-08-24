import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/pagination/list_limits.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';

/// Paged variant of [ListInvoicesUseCase] that additionally returns the
/// total number of matching rows, so clients can build page indicators.
///
/// Pilot for the offset-based pagination pattern; a cursor-based variant may
/// follow for very large tenants.
@singleton
class ListInvoicesPageUseCase {
  ListInvoicesPageUseCase(this._tenantResolver, this._invoices);

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;

  Future<InvoiceListPage> call(
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
    final effectiveLimit = clampListLimit(limit);
    final effectiveOffset = offset ?? 0;

    final items = await _invoices.find(
      session,
      businessId: tenant.businessId,
      status: status,
      limit: effectiveLimit,
      offset: effectiveOffset,
    );
    final totalCount = await _invoices.count(
      session,
      businessId: tenant.businessId,
      status: status,
    );

    return InvoiceListPage(
      items: items,
      totalCount: totalCount,
      limit: effectiveLimit,
      offset: effectiveOffset,
    );
  }
}
