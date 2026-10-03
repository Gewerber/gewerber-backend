import '../../../generated/protocol.dart';

/// Input validation for client-supplied invoice lines.
///
/// Ordinary invoices never carry negative monetary values: a storno is
/// created exclusively through the dedicated credit-note flow, where the
/// server itself clones the original with signed-negative amounts. Rejecting
/// negative or non-finite input here keeps `invoice.create` from bypassing
/// that flow with a malformed, unlinked negative invoice.
class InvoiceItemRequestValidator {
  const InvoiceItemRequestValidator._();

  static void validateAll(List<InvoiceItemRequest> items) {
    for (var i = 0; i < items.length; i++) {
      validate(items[i], index: i);
    }
  }

  static void validate(InvoiceItemRequest item, {required int index}) {
    if (!item.quantity.isFinite) {
      throw ValidationException(
        message: 'Invoice item quantity must be a finite number.',
        field: 'items[$index].quantity',
      );
    }
    if (item.quantity < 0) {
      throw ValidationException(
        message: 'Invoice item quantity must not be negative.',
        field: 'items[$index].quantity',
      );
    }
    if (item.unitPriceCents < 0) {
      throw ValidationException(
        message: 'Invoice item unit price must not be negative.',
        field: 'items[$index].unitPriceCents',
      );
    }
  }
}
