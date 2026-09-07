import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/entitlement/invoice_quota_policy.dart';
import '../../../core/tenant/tenant_context.dart';
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
import '../domain/invoice_template_gateway.dart';
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
    this._templates,
    this._numbers,
    this._taxRules,
    this._audit,
    this._quotaPolicy,
  );

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final InvoiceItemGateway _items;
  final BusinessGateway _businesses;
  final BusinessSettingsGateway _businessSettings;
  final CustomerGateway _customers;
  final InvoiceTemplateGateway _templates;
  final InvoiceNumberService _numbers;
  final TaxRuleEngine _taxRules;
  final AuditService _audit;
  final InvoiceQuotaPolicy _quotaPolicy;

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

    // Free-tier monthly quota. Enforced on CREATE, not on issuance
    // (`markSent`): every created invoice — even a draft — immediately
    // consumes a GoBD-safe sequential number from the invoice number
    // sequence, and creation is the single choke point for all user-facing
    // invoice generation (manual create, time-entry billing; the background
    // recurring-materialization job writes through its own path and is not
    // quota-gated here). Gating issuance instead would let a free account
    // hoard unlimited numbered drafts. All statuses count (cancelled rows
    // keep their number for GoBD continuity).
    await _enforceMonthlyQuota(session, tenant);

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
    // requested item rates.
    final effectiveItems = _taxRules.applyKleinunternehmerOverride(
      business,
      request.items,
    );

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

      // Same transaction as the change: the audit trail can never describe
      // an invoice that was rolled back (and vice versa).
      await _audit.log(
        session,
        action: 'invoice.create',
        entityType: 'Invoice',
        entityId: '${created.id}',
        tenant: tenant,
        transaction: transaction,
      );
      return created;
    });

    return invoice;
  }

  /// Runs the free-tier monthly quota check for [tenant].
  ///
  /// Zero-cost when the commercial entitlements flag is off (the OSS
  /// default): no capability lookup, no count query, no behavior change.
  Future<void> _enforceMonthlyQuota(
    Session session,
    TenantContext tenant,
  ) async {
    if (!_quotaPolicy.enforcementEnabled) return;

    final limit = await _quotaPolicy.monthlyInvoiceLimit(
      session,
      userId: tenant.userId,
      businessId: tenant.businessId,
    );
    if (limit == null) return; // Unlimited capability granted.

    // Current UTC calendar month; `createdAt` is stored as a timestamp and
    // the window is half-open so the boundary day is counted exactly once.
    final now = DateTime.now().toUtc();
    final monthStart = DateTime.utc(now.year, now.month);
    final nextMonthStart = DateTime.utc(now.year, now.month + 1);

    final createdThisMonth = await _invoices.countCreatedBetween(
      session,
      businessId: tenant.businessId,
      createdAfter: monthStart,
      createdBefore: nextMonthStart,
    );
    if (createdThisMonth >= limit) {
      throw InvoiceLimitReachedException(
        message:
            'Monthly invoice limit of $limit reached for the current plan.',
        limit: limit,
      );
    }
  }
}
