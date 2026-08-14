import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../../business/domain/business_gateway.dart';
import '../../business/domain/business_settings_gateway.dart';
import '../domain/customer_gateway.dart';
import '../domain/invoice_calculator.dart';
import '../domain/invoice_gateway.dart';
import '../domain/invoice_item_gateway.dart';
import '../domain/invoice_mapper.dart';
import '../domain/invoice_number_service.dart';
import '../domain/tax_rule_engine.dart';

@singleton
class CreateInvoiceUseCase {
  CreateInvoiceUseCase(
    this._tenantResolver,
    this._invoices,
    this._items,
    this._businesses,
    this._businessSettings,
    this._customers,
    this._numbers,
    this._taxRules,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final InvoiceItemGateway _items;
  final BusinessGateway _businesses;
  final BusinessSettingsGateway _businessSettings;
  final CustomerGateway _customers;
  final InvoiceNumberService _numbers;
  final TaxRuleEngine _taxRules;
  final AuditService _audit;

  Future<Invoice> call(
    Session session,
    CreateInvoiceRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    if (request.items.isEmpty) {
      throw ValidationException(
        message: 'At least one invoice item is required.',
        field: 'items',
      );
    }

    final business =
        await _businesses.findById(session, tenant.businessId) ??
        (throw NotFoundException(
          entityType: 'Business',
          entityId: '${tenant.businessId}',
        ));

    final effectiveItems = [
      for (final item in request.items)
        business.isKleinunternehmer
            ? InvoiceItemRequest(
                description: item.description,
                quantity: item.quantity,
                unit: item.unit,
                unitPriceCents: item.unitPriceCents,
                vatRate: VatRate.none,
              )
            : item,
    ];

    final customer = request.customerId == null
        ? null
        : await _customers.findById(session, request.customerId!);
    if (request.customerId != null && customer == null) {
      throw NotFoundException(
        entityType: 'Customer',
        entityId: '${request.customerId}',
      );
    }

    final settings = await _businessSettings.findByBusinessId(
      session,
      tenant.businessId,
    );
    final issueDate = request.issueDate ?? DateTime.now();
    final paymentTermsDays =
        request.paymentTermsDays ?? settings?.paymentTermsDays ?? 14;
    final totals = InvoiceCalculator.totals(effectiveItems, _taxRules);

    final invoice = await session.db.transaction((transaction) async {
      final number = await _numbers.nextInvoiceNumber(
        session,
        businessId: tenant.businessId,
        issueDate: issueDate,
        settings: settings ?? BusinessSettings(businessId: tenant.businessId),
        transaction: transaction,
      );

      final created = await _invoices.create(
        session,
        Invoice(
          businessId: tenant.businessId,
          number: number,
          type: request.type,
          customerId: request.customerId,
          issueDate: issueDate,
          dueDate: request.dueDate,
          serviceDateFrom: request.serviceDateFrom,
          serviceDateTo: request.serviceDateTo,
          locale: request.locale,
          currency: request.currency,
          subtotalCents: totals.subtotalCents,
          vatTotalCents: totals.vatTotalCents,
          totalCents: totals.totalCents,
          paymentTermsDays: paymentTermsDays,
          notes: request.notes,
          templateId: request.templateId,
          recurrenceInterval: request.recurrenceInterval,
          nextRecurrenceDate: request.nextRecurrenceDate,
          recurrenceEndDate: request.recurrenceEndDate,
          recurrenceMaxOccurrences: request.recurrenceMaxOccurrences,
        ),
        transaction: transaction,
      );

      await _items.insertAll(
        session,
        InvoiceMapper.items(effectiveItems, invoiceId: created.id!),
        transaction: transaction,
      );
      return created;
    });

    await _audit.log(
      session,
      action: 'invoice.create',
      entityType: 'Invoice',
      entityId: '${invoice.id}',
      tenant: tenant,
    );
    return invoice;
  }
}
