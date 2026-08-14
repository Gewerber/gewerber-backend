import '../../../generated/protocol.dart';
import 'invoice_calculator.dart';

/// Converts request DTOs into persistent entities.
class InvoiceMapper {
  const InvoiceMapper._();

  static List<InvoiceItem> items(
    List<InvoiceItemRequest> requests, {
    required int invoiceId,
  }) {
    return [
      for (var i = 0; i < requests.length; i++)
        InvoiceItem(
          invoiceId: invoiceId,
          position: i,
          description: requests[i].description,
          quantity: requests[i].quantity,
          unit: requests[i].unit,
          unitPriceCents: requests[i].unitPriceCents,
          vatRate: requests[i].vatRate,
          lineTotalCents: InvoiceCalculator.lineTotalCents(requests[i]),
        ),
    ];
  }
}
