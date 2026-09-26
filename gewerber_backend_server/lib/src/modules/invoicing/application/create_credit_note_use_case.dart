import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../../business/domain/business_settings_gateway.dart';
import '../domain/invoice_credit_note_mapper.dart';
import '../domain/invoice_gateway.dart';
import '../domain/invoice_item_gateway.dart';
import '../domain/invoice_number_service.dart';
import 'invoice_creation_quota_guard.dart';

/// Creates the draft of a full storno / credit note for an issued original.
///
/// The client supplies only the original invoice, an optional issue date and
/// an optional reason. Customer, currency, service period, lines, quantities
/// and VAT are cloned from the original by [InvoiceCreditNoteMapper]; the
/// original is locked for the whole creation so cancellation/issuance cannot
/// race the snapshot. Issuance happens later through the existing
/// `invoice.markSent` operation.
@singleton
class CreateCreditNoteUseCase {
  CreateCreditNoteUseCase(
    this._tenantResolver,
    this._invoices,
    this._items,
    this._businessSettings,
    this._numbers,
    this._audit,
    this._quotaGuard,
  );

  static const _creditableStatuses = {
    InvoiceStatus.sent,
    InvoiceStatus.partiallyPaid,
    InvoiceStatus.overdue,
    InvoiceStatus.paid,
  };

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final InvoiceItemGateway _items;
  final BusinessSettingsGateway _businessSettings;
  final InvoiceNumberService _numbers;
  final AuditService _audit;
  final InvoiceCreationQuotaGuard _quotaGuard;

  Future<Invoice> call(
    Session session,
    CreateCreditNoteRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    await _quotaGuard.enforce(session, tenant);

    final settings = await _businessSettings.findByBusinessId(
      session,
      tenant.businessId,
    );

    return session.db.transaction((transaction) async {
      final original = await _invoices.findByIdForUpdate(
        session,
        request.originalInvoiceId,
        transaction: transaction,
      );
      if (original == null || original.businessId != tenant.businessId) {
        throw NotFoundException(
          entityType: 'Invoice',
          entityId: '${request.originalInvoiceId}',
        );
      }
      if (original.type != InvoiceType.invoice) {
        throw ValidationException(
          message: 'Only an ordinary invoice can be credited.',
          field: 'originalInvoiceId',
        );
      }
      if (!_creditableStatuses.contains(original.status)) {
        throw ConflictException(
          message:
              'Only issued invoices can be credited; invoice '
              '${original.number} is ${original.status.name}.',
        );
      }
      if (original.totalCents <= 0) {
        throw ConflictException(
          message: 'Only invoices with a positive total can be credited.',
        );
      }

      final issueDate = request.issueDate ?? DateTime.now();
      if (issueDate.isBefore(original.issueDate)) {
        throw ValidationException(
          message:
              'The credit note issue date cannot be before the original '
              'invoice date.',
          field: 'issueDate',
        );
      }

      final originalItems = await _items.findByInvoiceId(
        session,
        original.id!,
        transaction: transaction,
      );
      if (originalItems.isEmpty) {
        throw ConflictException(
          message:
              'Invoice ${original.number} has no items and cannot be credited.',
        );
      }

      // Storno documents draw from the same GoBD-safe invoice sequence as
      // ordinary invoices. The literal number is never reused; the original
      // is referenced through `originalInvoiceId` instead.
      final number = await _numbers.nextInvoiceNumber(
        session,
        businessId: original.businessId,
        issueDate: issueDate,
        settings: settings ?? BusinessSettings(businessId: original.businessId),
        transaction: transaction,
      );

      final created = await _invoices.create(
        session,
        InvoiceCreditNoteMapper.draft(
          original: original,
          number: number,
          issueDate: issueDate,
          reason: request.reason,
        ),
        transaction: transaction,
      );
      await _items.insertAll(
        session,
        InvoiceCreditNoteMapper.items(
          originalItems: originalItems,
          invoiceId: created.id!,
        ),
        transaction: transaction,
      );

      await _audit.log(
        session,
        action: 'invoice.creditNote.create',
        entityType: 'Invoice',
        entityId: '${created.id}',
        changes: {
          'originalInvoiceId': '${original.id}',
          'number': created.number,
          'vatTotalCents': '${created.vatTotalCents}',
        },
        tenant: tenant,
        transaction: transaction,
      );
      return created;
    });
  }
}
