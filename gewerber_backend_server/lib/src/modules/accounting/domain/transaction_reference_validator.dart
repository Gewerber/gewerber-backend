import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../../documents/domain/document_gateway.dart';
import '../../invoicing/domain/invoice_gateway.dart';

/// Validates that referenced documents/invoices belong to the business.
@singleton
class TransactionReferenceValidator {
  TransactionReferenceValidator(this._documents, this._invoices);

  final DocumentGateway _documents;
  final InvoiceGateway _invoices;

  Future<void> validate(
    Session session,
    int businessId, {
    int? receiptDocumentId,
    int? relatedInvoiceId,
  }) async {
    if (receiptDocumentId != null) {
      final document = await _documents.findById(session, receiptDocumentId);
      if (document == null || document.businessId != businessId) {
        throw NotFoundException(
          entityType: 'Document',
          entityId: '$receiptDocumentId',
        );
      }
    }
    if (relatedInvoiceId != null) {
      final invoice = await _invoices.findById(session, relatedInvoiceId);
      if (invoice == null || invoice.businessId != businessId) {
        throw NotFoundException(
          entityType: 'Invoice',
          entityId: '$relatedInvoiceId',
        );
      }
    }
  }
}
