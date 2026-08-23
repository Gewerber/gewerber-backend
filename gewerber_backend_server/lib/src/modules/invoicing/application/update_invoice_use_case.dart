import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../../business/domain/business_gateway.dart';
import '../domain/customer_gateway.dart';
import '../domain/invoice_calculator.dart';
import '../domain/invoice_gateway.dart';
import '../domain/invoice_item_gateway.dart';
import '../domain/invoice_mapper.dart';
import '../domain/invoice_template_gateway.dart';
import '../domain/tax_rule_engine.dart';

@singleton
class UpdateInvoiceUseCase {
  UpdateInvoiceUseCase(
    this._tenantResolver,
    this._invoices,
    this._items,
    this._businesses,
    this._customers,
    this._templates,
    this._taxRules,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final InvoiceItemGateway _items;
  final BusinessGateway _businesses;
  final CustomerGateway _customers;
  final InvoiceTemplateGateway _templates;
  final TaxRuleEngine _taxRules;
  final AuditService _audit;

  Future<Invoice> call(
    Session session,
    UpdateInvoiceRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final existing = await _invoices.findById(session, request.invoiceId);
    if (existing == null || existing.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'Invoice',
        entityId: '${request.invoiceId}',
      );
    }
    if (existing.status != InvoiceStatus.draft) {
      throw ConflictException(
        message: 'Only draft invoices can be edited.',
      );
    }
    if (request.items.isEmpty) {
      throw ValidationException(
        message: 'At least one invoice item is required.',
        field: 'items',
      );
    }
    if (request.customerId != null) {
      final customer = await _customers.findById(session, request.customerId!);
      if (customer == null || customer.businessId != tenant.businessId) {
        throw NotFoundException(
          entityType: 'Customer',
          entityId: '${request.customerId}',
        );
      }
    }

    // Optional reference, but it must belong to the current tenant.
    if (request.templateId != null) {
      final template = await _templates.findById(session, request.templateId!);
      if (template == null || template.businessId != tenant.businessId) {
        throw NotFoundException(
          entityType: 'InvoiceTemplate',
          entityId: '${request.templateId}',
        );
      }
    }

    final business =
        await _businesses.findById(session, tenant.businessId) ??
        (throw NotFoundException(
          entityType: 'Business',
          entityId: '${tenant.businessId}',
        ));

    // Kleinunternehmer §19: VAT must not be charged regardless of the
    // requested item rates (same override as in CreateInvoiceUseCase).
    final effectiveItems = _taxRules.applyKleinunternehmerOverride(
      business,
      request.items,
    );

    final totals = InvoiceCalculator.totals(effectiveItems, _taxRules);
    final updated = await session.db.transaction((transaction) async {
      final invoice = await _invoices.update(
        session,
        Invoice(
          id: existing.id,
          businessId: existing.businessId,
          number: existing.number,
          type: existing.type,
          status: existing.status,
          customerId: request.customerId,
          issueDate: request.issueDate,
          dueDate: request.dueDate,
          serviceDateFrom: request.serviceDateFrom,
          serviceDateTo: request.serviceDateTo,
          locale: existing.locale,
          currency: existing.currency,
          subtotalCents: totals.subtotalCents,
          vatTotalCents: totals.vatTotalCents,
          totalCents: totals.totalCents,
          paymentTermsDays: request.paymentTermsDays,
          dunningLevel: existing.dunningLevel,
          notes: request.notes,
          templateId: request.templateId,
          pdfDocumentId: existing.pdfDocumentId,
          recurrenceInterval: request.recurrenceInterval,
          nextRecurrenceDate: request.nextRecurrenceDate,
          recurrenceEndDate: request.recurrenceEndDate,
          recurrenceMaxOccurrences: request.recurrenceMaxOccurrences,
          recurrenceOccurrencesCreated: existing.recurrenceOccurrencesCreated,
          createdAt: existing.createdAt,
        ),
        transaction: transaction,
      );

      await _items.deleteByInvoiceId(
        session,
        invoice.id!,
        transaction: transaction,
      );
      await _items.insertAll(
        session,
        InvoiceMapper.items(effectiveItems, invoiceId: invoice.id!),
        transaction: transaction,
      );
      return invoice;
    });

    await _audit.log(
      session,
      action: 'invoice.update',
      entityType: 'Invoice',
      entityId: '${updated.id}',
      tenant: tenant,
    );
    return updated;
  }
}
