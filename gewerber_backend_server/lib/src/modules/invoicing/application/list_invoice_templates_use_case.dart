import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/pagination/list_limits.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_template_gateway.dart';

@singleton
class ListInvoiceTemplatesUseCase {
  ListInvoiceTemplatesUseCase(this._tenantResolver, this._templates);

  final TenantResolver _tenantResolver;
  final InvoiceTemplateGateway _templates;

  Future<List<InvoiceTemplate>> call(
    Session session, {
    int? businessId,
    int? limit,
    int? offset,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    return _templates.findByBusinessId(
      session,
      tenant.businessId,
      limit: clampListLimit(limit),
      offset: offset ?? 0,
    );
  }
}
