import 'dart:typed_data';

import '../../../generated/protocol.dart';

/// Aggregates everything needed to render an invoice PDF.
class InvoicePdfData {
  const InvoicePdfData({
    required this.business,
    required this.invoice,
    required this.items,
    this.customer,
    this.template,
    this.originalInvoiceNumber,
  });

  final Business business;
  final Invoice invoice;
  final List<InvoiceItem> items;
  final Customer? customer;
  final InvoiceTemplate? template;

  /// Number of the original invoice referenced by a credit note.
  final String? originalInvoiceNumber;
}

/// Renders an invoice as a PDF document.
abstract interface class InvoicePdfGenerator {
  Future<Uint8List> generate(InvoicePdfData data);
}
