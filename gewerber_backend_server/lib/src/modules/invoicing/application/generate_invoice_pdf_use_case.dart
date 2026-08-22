import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/session_auth.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../../business/domain/business_gateway.dart';
import '../../documents/domain/document_gateway.dart';
import '../domain/customer_gateway.dart';
import '../domain/invoice_gateway.dart';
import '../domain/invoice_item_gateway.dart';
import '../domain/invoice_pdf_generator.dart';
import '../domain/invoice_template_gateway.dart';

/// Generates the PDF for an invoice, stores it as a private document and
/// links it to the invoice via `pdfDocumentId`.
@singleton
class GenerateInvoicePdfUseCase {
  GenerateInvoicePdfUseCase(
    this._tenantResolver,
    this._invoices,
    this._items,
    this._customers,
    this._businesses,
    this._templates,
    this._documents,
    this._pdfGenerator,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;
  final InvoiceItemGateway _items;
  final CustomerGateway _customers;
  final BusinessGateway _businesses;
  final InvoiceTemplateGateway _templates;
  final DocumentGateway _documents;
  final InvoicePdfGenerator _pdfGenerator;
  final AuditService _audit;

  Future<Document> call(
    Session session,
    int invoiceId, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );

    final invoice = await _invoices.findById(session, invoiceId);
    if (invoice == null || invoice.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'Invoice',
        entityId: '$invoiceId',
      );
    }

    final business = await _businesses.findById(session, tenant.businessId);
    if (business == null) {
      throw NotFoundException(
        entityType: 'Business',
        entityId: '${tenant.businessId}',
      );
    }

    final items = await _items.findByInvoiceId(session, invoiceId);
    final customer = invoice.customerId == null
        ? null
        : await _customers.findById(session, invoice.customerId!);
    final template = invoice.templateId == null
        ? null
        : await _templates.findById(session, invoice.templateId!);

    final pdfBytes = await _pdfGenerator.generate(
      InvoicePdfData(
        business: business,
        invoice: invoice,
        items: items,
        customer: customer,
        template: template,
      ),
    );

    final extension = '.pdf';
    final path =
        'business/${tenant.businessId}/${DocumentKind.invoicePdf.name}/'
        'invoice-${invoice.number.replaceAll('/', '_')}'
        '-${Uuid().toString()}$extension';

    await session.storage.storeFile(
      storageId: StorageLocation.private.name,
      path: path,
      byteData: ByteData.sublistView(pdfBytes),
    );

    final document = await _documents.create(
      session,
      Document(
        businessId: tenant.businessId,
        kind: DocumentKind.invoicePdf,
        fileName: 'rechnung-${invoice.number}.pdf',
        mimeType: 'application/pdf',
        sizeBytes: pdfBytes.length,
        storageLocation: StorageLocation.private,
        storagePath: path,
        relatedEntityType: 'Invoice',
        relatedEntityId: '$invoiceId',
        uploadedById: session.authUserId,
      ),
    );

    await _invoices.update(
      session,
      invoice.copyWith(pdfDocumentId: document.id),
    );

    await _audit.log(
      session,
      action: 'invoice.generatePdf',
      entityType: 'Invoice',
      entityId: '$invoiceId',
      changes: {'pdfDocumentId': '${document.id}'},
      tenant: tenant,
    );
    return document;
  }
}
