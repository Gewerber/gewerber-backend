import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_template_gateway.dart';

@singleton
class CreateInvoiceTemplateUseCase {
  CreateInvoiceTemplateUseCase(
    this._tenantResolver,
    this._templates,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final InvoiceTemplateGateway _templates;
  final AuditService _audit;

  Future<InvoiceTemplate> call(
    Session session,
    CreateInvoiceTemplateRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    if (request.name.trim().isEmpty) {
      throw ValidationException(
        message: 'Template name is required.',
        field: 'name',
      );
    }

    final template = await session.db.transaction((transaction) async {
      if (request.isDefault) {
        await _templates.clearDefaultFlags(
          session,
          tenant.businessId,
          transaction: transaction,
        );
      }
      return _templates.create(
        session,
        InvoiceTemplate(
          businessId: tenant.businessId,
          name: request.name.trim(),
          isDefault: request.isDefault,
          headerText: request.headerText,
          footerText: request.footerText,
          logoDocumentId: request.logoDocumentId,
        ),
        transaction: transaction,
      );
    });

    await _audit.log(
      session,
      action: 'invoiceTemplate.create',
      entityType: 'InvoiceTemplate',
      entityId: '${template.id}',
      tenant: tenant,
    );
    return template;
  }
}
