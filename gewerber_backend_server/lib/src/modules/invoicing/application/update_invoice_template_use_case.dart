import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_template_gateway.dart';

@singleton
class UpdateInvoiceTemplateUseCase {
  UpdateInvoiceTemplateUseCase(
    this._tenantResolver,
    this._templates,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final InvoiceTemplateGateway _templates;
  final AuditService _audit;

  Future<InvoiceTemplate> call(
    Session session,
    UpdateInvoiceTemplateRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final existing = await _templates.findById(session, request.templateId);
    if (existing == null || existing.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'InvoiceTemplate',
        entityId: '${request.templateId}',
      );
    }
    if (request.name.trim().isEmpty) {
      throw ValidationException(
        message: 'Template name is required.',
        field: 'name',
      );
    }

    final updated = await session.db.transaction((transaction) async {
      if (request.isDefault) {
        await _templates.clearDefaultFlags(
          session,
          tenant.businessId,
          transaction: transaction,
        );
      }
      return _templates.update(
        session,
        InvoiceTemplate(
          id: existing.id,
          businessId: existing.businessId,
          name: request.name.trim(),
          isDefault: request.isDefault,
          headerText: request.headerText,
          footerText: request.footerText,
          logoDocumentId: request.logoDocumentId,
          createdAt: existing.createdAt,
        ),
      );
    });

    await _audit.log(
      session,
      action: 'invoiceTemplate.update',
      entityType: 'InvoiceTemplate',
      entityId: '${updated.id}',
      tenant: tenant,
    );
    return updated;
  }
}
