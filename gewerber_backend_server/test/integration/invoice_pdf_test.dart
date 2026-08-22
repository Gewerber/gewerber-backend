@Tags(['integration'])
library;

import 'dart:convert';

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const otherUserId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given invoice PDF generation', (sessionBuilder, endpoints) {
    late TestSessionBuilder authenticatedSession;
    late int businessId;

    setUp(() async {
      authenticatedSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          testUserId,
          {},
        ),
      );
      final business = await endpoints.business.create(
        authenticatedSession,
        CreateBusinessRequest(
          name: 'Mein Gewerbe',
          vatId: 'DE123456789',
          address: Address(
            street: 'Musterstr. 1',
            zip: '10115',
            city: 'Berlin',
            country: Country.deu,
          ),
        ),
      );
      businessId = business.id!;
    });

    Future<Invoice> createInvoice({
      CreateInvoiceRequest? request,
      int? business,
    }) async {
      final customer = await endpoints.customer.create(
        authenticatedSession,
        CreateCustomerRequest(
          name: 'ACME GmbH',
          companyName: 'ACME GmbH',
          vatId: 'DE987654321',
          address: Address(
            street: 'Kundenweg 2',
            zip: '80331',
            city: 'München',
            country: Country.deu,
          ),
        ),
        businessId: business ?? businessId,
      );

      return endpoints.invoice.create(
        authenticatedSession,
        request ??
            CreateInvoiceRequest(
              customerId: customer.id,
              issueDate: DateTime(2026, 8, 20),
              notes: 'Vielen Dank für Ihren Auftrag.',
              items: [
                InvoiceItemRequest(
                  description: 'Beratung',
                  quantity: 10,
                  unit: InvoiceItemUnit.hour,
                  unitPriceCents: 10000,
                  vatRate: VatRate.standard,
                ),
                InvoiceItemRequest(
                  description: 'Anfahrt',
                  quantity: 1,
                  unit: InvoiceItemUnit.piece,
                  unitPriceCents: 5000,
                  vatRate: VatRate.reduced,
                ),
              ],
            ),
        businessId: business ?? businessId,
      );
    }

    test('when generating PDF then document is stored and linked', () async {
      final invoice = await createInvoice();

      final document = await endpoints.invoice.generatePdf(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );

      expect(document.id, isNotNull);
      expect(document.businessId, businessId);
      expect(document.kind, DocumentKind.invoicePdf);
      expect(document.mimeType, 'application/pdf');
      expect(document.sizeBytes, greaterThan(0));
      expect(document.storageLocation, StorageLocation.private);
      expect(document.relatedEntityType, 'Invoice');
      expect(document.relatedEntityId, '${invoice.id}');
      expect(document.fileName, 'rechnung-${invoice.number}.pdf');

      final fetched = await endpoints.invoice.get(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(fetched.pdfDocumentId, document.id);
    });

    test('when downloading generated PDF then bytes are a PDF', () async {
      final invoice = await createInvoice();

      final document = await endpoints.invoice.generatePdf(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );

      final bytes = await endpoints.document.download(
        authenticatedSession,
        document.id!,
      );

      final header = utf8.decode(
        bytes.buffer.asUint8List(bytes.offsetInBytes, 5),
        allowMalformed: true,
      );
      expect(header, startsWith('%PDF-'));
      expect(bytes.lengthInBytes, document.sizeBytes);
    });

    test('when generating twice then a new document is created', () async {
      final invoice = await createInvoice();

      final first = await endpoints.invoice.generatePdf(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      final second = await endpoints.invoice.generatePdf(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );

      expect(second.id, isNot(first.id));

      final fetched = await endpoints.invoice.get(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(fetched.pdfDocumentId, second.id);
    });

    test('when business is Kleinunternehmer then PDF is generated', () async {
      final kleinBusiness = await endpoints.business.create(
        authenticatedSession,
        CreateBusinessRequest(name: 'Kleingewerbe', isKleinunternehmer: true),
      );

      final customer = await endpoints.customer.create(
        authenticatedSession,
        CreateCustomerRequest(name: 'Kunde'),
        businessId: kleinBusiness.id,
      );
      final invoice = await endpoints.invoice.create(
        authenticatedSession,
        CreateInvoiceRequest(
          customerId: customer.id,
          items: [
            InvoiceItemRequest(
              description: 'Arbeit',
              quantity: 1,
              unitPriceCents: 50000,
            ),
          ],
        ),
        businessId: kleinBusiness.id,
      );

      final document = await endpoints.invoice.generatePdf(
        authenticatedSession,
        invoice.id!,
        businessId: kleinBusiness.id,
      );
      expect(document.kind, DocumentKind.invoicePdf);
      expect(document.sizeBytes, greaterThan(0));
    });

    test('when invoice does not exist then NotFoundException', () async {
      await expectLater(
        () => endpoints.invoice.generatePdf(
          authenticatedSession,
          999999,
          businessId: businessId,
        ),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('when other tenant generates PDF then NotFoundException', () async {
      final invoice = await createInvoice();

      final otherSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          otherUserId,
          {},
        ),
      );
      final otherBusiness = await endpoints.business.create(
        otherSession,
        CreateBusinessRequest(name: 'Anderes Gewerbe'),
      );

      await expectLater(
        () => endpoints.invoice.generatePdf(
          otherSession,
          invoice.id!,
          businessId: otherBusiness.id,
        ),
        throwsA(isA<NotFoundException>()),
      );
    });
  });
}
