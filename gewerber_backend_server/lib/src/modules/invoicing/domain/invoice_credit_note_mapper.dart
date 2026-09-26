import '../../../generated/protocol.dart';

/// Pure builder for a full storno / credit note (§14 UStG).
///
/// The credit note is an exact contra document of the original: customer,
/// currency, service period, line descriptions/units/quantities and the
/// original's stored VAT rates are copied, while every monetary amount is
/// the exact signed inverse. The builder deliberately does **not** call the
/// tax rule engine — the original's persisted VAT must be reversed even when
/// the business or customer changed their §19/VAT status in the meantime.
class InvoiceCreditNoteMapper {
  const InvoiceCreditNoteMapper._();

  static Invoice draft({
    required Invoice original,
    required String number,
    required DateTime issueDate,
    String? reason,
  }) {
    final originalId = original.id;
    if (originalId == null) {
      throw StateError('Cannot credit an invoice without a persisted id.');
    }
    _validateOriginal(original);

    final notes = reason?.trim();
    return Invoice(
      businessId: original.businessId,
      number: number,
      type: InvoiceType.creditNote,
      status: InvoiceStatus.draft,
      customerId: original.customerId,
      originalInvoiceId: originalId,
      issueDate: issueDate,
      dueDate: null,
      serviceDateFrom: original.serviceDateFrom,
      serviceDateTo: original.serviceDateTo,
      locale: original.locale,
      currency: original.currency,
      subtotalCents: -original.subtotalCents,
      vatTotalCents: -original.vatTotalCents,
      totalCents: -original.totalCents,
      paymentTermsDays: 0,
      notes: notes == null || notes.isEmpty ? null : notes,
      templateId: original.templateId,
    );
  }

  static List<InvoiceItem> items({
    required List<InvoiceItem> originalItems,
    required int invoiceId,
  }) {
    for (final item in originalItems) {
      if (!item.quantity.isFinite ||
          item.quantity < 0 ||
          item.unitPriceCents < 0 ||
          item.lineTotalCents < 0) {
        throw ConflictException(
          message:
              'Invoice item ${item.position} has inconsistent negative values '
              'and cannot be credited automatically.',
        );
      }
    }
    return [
      for (final item in originalItems)
        InvoiceItem(
          invoiceId: invoiceId,
          position: item.position,
          description: item.description,
          quantity: item.quantity,
          unit: item.unit,
          unitPriceCents: -item.unitPriceCents,
          vatRate: item.vatRate,
          lineTotalCents: -item.lineTotalCents,
        ),
    ];
  }

  /// Guards the exact-reversal invariant against malformed historical rows:
  /// negating an already-negative value would silently alter the storno.
  static void _validateOriginal(Invoice original) {
    if (original.subtotalCents < 0 ||
        original.vatTotalCents < 0 ||
        original.totalCents < 0) {
      throw ConflictException(
        message:
            'Invoice ${original.number} has inconsistent negative totals and '
            'cannot be credited automatically.',
      );
    }
  }
}
