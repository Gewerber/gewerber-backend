import '../../../generated/protocol.dart';
import 'tax_rule_engine.dart';

/// Pure money math for invoices. All amounts are integer cents.
class InvoiceCalculator {
  const InvoiceCalculator._();

  static int lineTotalCents(InvoiceItemRequest item) {
    return (item.quantity * item.unitPriceCents).round();
  }

  static int vatCentsForLine(int lineTotalCents, int percent) {
    return (lineTotalCents * percent / 100).round();
  }

  static ({int subtotalCents, int vatTotalCents, int totalCents}) totals(
    List<InvoiceItemRequest> items,
    TaxRuleEngine taxRules,
  ) {
    var subtotal = 0;
    var vatTotal = 0;
    for (final item in items) {
      final lineTotal = lineTotalCents(item);
      subtotal += lineTotal;
      vatTotal += vatCentsForLine(lineTotal, taxRules.percentFor(item.vatRate));
    }
    return (
      subtotalCents: subtotal,
      vatTotalCents: vatTotal,
      totalCents: subtotal + vatTotal,
    );
  }
}
