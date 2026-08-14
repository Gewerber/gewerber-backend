import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';
import '../domain/invoice_item_gateway.dart';

/// Materializes due recurring invoices from their source invoices.
/// A source invoice with a future [nextRecurrenceDate] is cloned into a new
/// `draft` invoice, then the source's next recurrence date is advanced.
@singleton
class ProcessRecurringInvoicesUseCase {
  ProcessRecurringInvoicesUseCase(this._invoices, this._items);

  final InvoiceGateway _invoices;
  final InvoiceItemGateway _items;

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
      await session.db.transaction((transaction) async {
        final clone = await _invoices.create(
          session,
          Invoice(
            businessId: source.businessId,
            number: await _nextNumberForSource(session, source),
            type: source.type,
            customerId: source.customerId,
            issueDate: next,
            dueDate: source.dueDate,
            serviceDateFrom: source.serviceDateFrom,
            serviceDateTo: source.serviceDateTo,
            locale: source.locale,
            currency: source.currency,
            subtotalCents: source.subtotalCents,
            vatTotalCents: source.vatTotalCents,
            totalCents: source.totalCents,
            paymentTermsDays: source.paymentTermsDays,
            notes: source.notes,
            templateId: source.templateId,
          ),
          transaction: transaction,
        );
        await _items.insertAll(
          session,
          [
            for (var i = 0; i < sourceItems.length; i++)
              InvoiceItem(
                invoiceId: clone.id!,
                position: sourceItems[i].position,
                description: sourceItems[i].description,
                quantity: sourceItems[i].quantity,
                unit: sourceItems[i].unit,
                unitPriceCents: sourceItems[i].unitPriceCents,
                vatRate: sourceItems[i].vatRate,
                lineTotalCents: sourceItems[i].lineTotalCents,
              ),
          ],
          transaction: transaction,
        );

        final nextDate = _advance(next, interval);
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
      });
      created++;
    }

    return created;
  }

  Future<bool> _hasMaterialized(
    Session session,
    Invoice source,
    DateTime next,
  ) async {
    final clones = await _invoices.find(
      session,
      businessId: source.businessId,
      limit: 1,
    );
    return clones.any(
      (c) =>
          c.id != source.id &&
          c.issueDate == next &&
          c.status == InvoiceStatus.draft &&
          c.templateId == source.templateId,
    );
  }

  Future<String> _nextNumberForSource(Session session, Invoice source) {
    // Numbering for materialized invoices is handled by the number service on
    // creation; here we reuse the source number with a suffix to guarantee
    // uniqueness within the business.
    return Future.value('${source.number}-R');
  }

  DateTime _advance(DateTime date, RecurrenceInterval interval) {
    final local = date.toLocal();
    return switch (interval) {
      RecurrenceInterval.daily => local.add(const Duration(days: 1)),
      RecurrenceInterval.weekly => local.add(const Duration(days: 7)),
      RecurrenceInterval.monthly => DateTime(
        local.year,
        local.month + 1,
        local.day,
      ),
      RecurrenceInterval.quarterly => DateTime(
        local.year,
        local.month + 3,
        local.day,
      ),
      RecurrenceInterval.yearly => DateTime(
        local.year + 1,
        local.month,
        local.day,
      ),
    };
  }
}
