import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_template_gateway.dart';

@singleton
class GetInvoiceTemplateUseCase {
  GetInvoiceTemplateUseCase(this._tenantResolver, this._templates);

  final TenantResolver _tenantResolver;
  final InvoiceTemplateGateway _templates;

  Future<InvoiceTemplate> call(
    Session session,
    int templateId, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final template = await _templates.findById(session, templateId);
    if (template == null || template.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'InvoiceTemplate',
        entityId: '$templateId',
      );
    }
    return template;
  }
}
