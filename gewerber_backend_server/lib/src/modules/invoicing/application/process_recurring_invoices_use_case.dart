import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../generated/protocol.dart';
import '../../business/domain/business_gateway.dart';
import '../../business/domain/business_settings_gateway.dart';
import '../domain/invoice_calculator.dart';
import '../domain/invoice_gateway.dart';
import '../domain/invoice_item_gateway.dart';
import '../domain/invoice_number_service.dart';
import '../domain/recurrence.dart';
import '../domain/tax_rule_engine.dart';

/// Materializes due recurring invoices from their source invoices.
/// A source invoice with a future [nextRecurrenceDate] is cloned into a new
/// `draft` invoice, then the source's next recurrence date is advanced.
///
/// The clone gets a fresh GoBD-safe number from the business sequence, a
/// `dueDate` of `issueDate + paymentTermsDays`, and its VAT amounts are
/// re-evaluated at materialization time (e.g. Kleinunternehmer §19 changes
/// are reflected instead of copying stale totals from the source).
///
/// Every materialized clone is audited (`invoice.recurringMaterialized`) in
/// the same transaction, attributed to the owning business without a user —
/// it is a system event.
@singleton
class ProcessRecurringInvoicesUseCase {
  ProcessRecurringInvoicesUseCase(
    this._invoices,
    this._items,
    this._businesses,
    this._businessSettings,
    this._numbers,
    this._taxRules,
    this._audit,
  );

  final InvoiceGateway _invoices;
  final InvoiceItemGateway _items;
  final BusinessGateway _businesses;
  final BusinessSettingsGateway _businessSettings;
  final InvoiceNumberService _numbers;
  final TaxRuleEngine _taxRules;
  final AuditService _audit;

  Future<int> call(Session session, {DateTime? now}) async {
    final reference = now ?? DateTime.now();
    final due = await _invoices.findDueRecurring(session, reference);
    var created = 0;

    for (final source in due) {
      final interval = source.recurrenceInterval;
      if (interval == null || source.nextRecurrenceDate == null) {
        continue;
      }
      final next = source.nextRecurrenceDate!;
      // Guard: skip if a materialized invoice for this date already exists.
      if (await _hasMaterialized(session, source, next)) {
        continue;
      }

      final sourceItems = await _items.findByInvoiceId(session, source.id!);
      final business =
          await _businesses.findById(session, source.businessId) ??
          (throw StateError(
            'Business ${source.businessId} of recurring invoice '
            '${source.id} is missing.',
          ));
      final settings = await _businessSettings.findByBusinessId(
        session,
        source.businessId,
      );

      await session.db.transaction((transaction) async {
        final number = await _numbers.nextInvoiceNumber(
          session,
          businessId: source.businessId,
          issueDate: next,
          settings: settings ?? BusinessSettings(businessId: source.businessId),
          transaction: transaction,
        );

        // Re-evaluate Kleinunternehmer/VAT at materialization time.
        final requestedItems = [
          for (final item in sourceItems)
            InvoiceItemRequest(
              description: item.description,
              quantity: item.quantity,
              unit: item.unit,
              unitPriceCents: item.unitPriceCents,
              vatRate: item.vatRate,
            ),
        ];
        final effectiveItems = _taxRules.applyKleinunternehmerOverride(
          business,
          requestedItems,
        );
        final totals = InvoiceCalculator.totals(effectiveItems, _taxRules);

        final clone = await _invoices.create(
          session,
          Invoice(
            businessId: source.businessId,
            number: number,
            type: source.type,
            customerId: source.customerId,
            issueDate: next,
            dueDate: next.add(Duration(days: source.paymentTermsDays)),
            serviceDateFrom: source.serviceDateFrom,
            serviceDateTo: source.serviceDateTo,
            locale: source.locale,
            currency: source.currency,
            subtotalCents: totals.subtotalCents,
            vatTotalCents: totals.vatTotalCents,
            totalCents: totals.totalCents,
            paymentTermsDays: source.paymentTermsDays,
            notes: source.notes,
            templateId: source.templateId,
          ),
          transaction: transaction,
        );
        await _items.insertAll(
          session,
          [
            for (var i = 0; i < effectiveItems.length; i++)
              InvoiceItem(
                invoiceId: clone.id!,
                position: sourceItems[i].position,
                description: effectiveItems[i].description,
                quantity: effectiveItems[i].quantity,
                unit: effectiveItems[i].unit,
                unitPriceCents: effectiveItems[i].unitPriceCents,
                vatRate: effectiveItems[i].vatRate,
                lineTotalCents: InvoiceCalculator.lineTotalCents(
                  effectiveItems[i],
                ),
              ),
          ],
          transaction: transaction,
        );

        final nextDate = advanceRecurrence(next, interval);
        final occurrences = source.recurrenceOccurrencesCreated + 1;
        final finished =
            nextDate.isAfter(
              source.recurrenceEndDate ?? DateTime(9999),
            ) ||
            (source.recurrenceMaxOccurrences != null &&
                occurrences >= source.recurrenceMaxOccurrences!);
        await _invoices.update(
          session,
          Invoice(
            id: source.id,
            businessId: source.businessId,
            number: source.number,
            type: source.type,
            status: source.status,
            customerId: source.customerId,
            issueDate: source.issueDate,
            dueDate: source.dueDate,
            serviceDateFrom: source.serviceDateFrom,
            serviceDateTo: source.serviceDateTo,
            locale: source.locale,
            currency: source.currency,
            subtotalCents: source.subtotalCents,
            vatTotalCents: source.vatTotalCents,
            totalCents: source.totalCents,
            paymentTermsDays: source.paymentTermsDays,
            dunningLevel: source.dunningLevel,
            notes: source.notes,
            templateId: source.templateId,
            pdfDocumentId: source.pdfDocumentId,
            recurrenceInterval: source.recurrenceInterval,
            nextRecurrenceDate: finished ? null : nextDate,
            recurrenceEndDate: source.recurrenceEndDate,
            recurrenceMaxOccurrences: source.recurrenceMaxOccurrences,
            recurrenceOccurrencesCreated: occurrences,
            createdAt: source.createdAt,
          ),
          transaction: transaction,
        );

        // System event, attributed to the owning business (no user): audited
        // atomically with the clone so the trail matches the created invoice.
        await _audit.log(
          session,
          action: 'invoice.recurringMaterialized',
          entityType: 'Invoice',
          entityId: '${clone.id}',
          changes: {
            'sourceInvoiceId': '${source.id}',
            'issueDate': next.toUtc().toIso8601String(),
            if (finished) 'scheduleFinished': 'true',
          },
          businessId: source.businessId,
          transaction: transaction,
        );
      });
      created++;
    }

    return created;
  }

  /// A clone for [next] already exists when there is a draft invoice of the
  /// same business with that issue date (the source itself excluded).
  Future<bool> _hasMaterialized(
    Session session,
    Invoice source,
    DateTime next,
  ) async {
    final drafts = await _invoices.find(
      session,
      businessId: source.businessId,
      status: InvoiceStatus.draft,
      issueDate: next,
    );
    return drafts.any(
      (c) =>
          c.id != source.id &&
          c.status == InvoiceStatus.draft &&
          c.templateId == source.templateId,
    );
  }
}
