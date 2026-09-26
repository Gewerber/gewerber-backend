import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/domain/invoice_item_request_validator.dart';
import 'package:test/test.dart';

void main() {
  InvoiceItemRequest item({double quantity = 1, int unitPriceCents = 100}) =>
      InvoiceItemRequest(
        description: 'Position',
        quantity: quantity,
        unitPriceCents: unitPriceCents,
      );

  test('rejects non-finite quantities before they reach money math', () {
    for (final quantity in [
      double.nan,
      double.infinity,
      double.negativeInfinity,
    ]) {
      expect(
        () => InvoiceItemRequestValidator.validate(
          item(quantity: quantity),
          index: 0,
        ),
        throwsA(isA<ValidationException>()),
      );
    }
  });

  test('rejects negative quantity and unit price', () {
    expect(
      () => InvoiceItemRequestValidator.validate(
        item(quantity: -0.5),
        index: 0,
      ),
      throwsA(isA<ValidationException>()),
    );
    expect(
      () => InvoiceItemRequestValidator.validate(
        item(unitPriceCents: -1),
        index: 0,
      ),
      throwsA(isA<ValidationException>()),
    );
  });

  test('allows zero and positive values', () {
    expect(
      () => InvoiceItemRequestValidator.validateAll([
        item(quantity: 0, unitPriceCents: 0),
        item(quantity: 2.5, unitPriceCents: 1000),
      ]),
      returnsNormally,
    );
  });
}
