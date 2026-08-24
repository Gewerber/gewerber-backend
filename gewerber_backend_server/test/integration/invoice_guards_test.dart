@Tags(['integration'])
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/di/service_locator.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/application/mark_overdue_invoices_use_case.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const userAId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const userBId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given invoice ownership guards', (sessionBuilder, endpoints) {
    late TestSessionBuilder sessionA;
    late TestSessionBuilder sessionB;
    late int businessAId;
    late int businessBId;
    late Customer customerOfB;

    setUp(() async {
      sessionA = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(userAId, {}),
      );
      sessionB = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(userBId, {}),
      );
      final businessA = await endpoints.business.create(
        sessionA,
        CreateBusinessRequest(name: 'Gewerbe A'),
      );
      businessAId = businessA.id!;
      final businessB = await endpoints.business.create(
        sessionB,
        CreateBusinessRequest(name: 'Gewerbe B'),
      );
      businessBId = businessB.id!;
      customerOfB = await endpoints.customer.create(
        sessionB,
        CreateCustomerRequest(name: 'Kunde von B'),
        businessId: businessBId,
      );
    });

    InvoiceItemRequest item({
      String description = 'A',
      int unitPriceCents = 10000,
      VatRate vatRate = VatRate.standard,
    }) => InvoiceItemRequest(
      description: description,
      quantity: 1,
      unitPriceCents: unitPriceCents,
      vatRate: vatRate,
    );

    Future<Invoice> createDraftInvoice(
      TestSessionBuilder session,
      int businessId, {
      DateTime? dueDate,
      List<InvoiceItemRequest>? items,
    }) {
      return endpoints.invoice.create(
        session,
        CreateInvoiceRequest(
          issueDate: DateTime(2026, 7, 15),
          dueDate: dueDate,
          items: items ?? [item()],
        ),
        businessId: businessId,
      );
    }

    UpdateInvoiceRequest updateRequest(
      Invoice invoice, {
      int? customerId,
      List<InvoiceItemRequest>? items,
    }) => UpdateInvoiceRequest(
      invoiceId: invoice.id!,
      customerId: customerId,
      issueDate: invoice.issueDate,
      paymentTermsDays: invoice.paymentTermsDays,
      items: items ?? [item()],
    );

    test(
      'when creating an invoice with a foreign customer then NotFoundException',
      () async {
        await expectLater(
          () => endpoints.invoice.create(
            sessionA,
            CreateInvoiceRequest(
              customerId: customerOfB.id,
              items: [item()],
            ),
            businessId: businessAId,
          ),
          throwsA(isA<NotFoundException>()),
        );

        // The foreign customer must be untouched.
        final fetched = await endpoints.customer.get(
          sessionB,
          customerOfB.id!,
          businessId: businessBId,
        );
        expect(fetched.id, customerOfB.id);
      },
    );

    test(
      'when updating a draft invoice with a foreign customer then NotFoundException',
      () async {
        final invoice = await createDraftInvoice(sessionA, businessAId);

        await expectLater(
          () => endpoints.invoice.update(
            sessionA,
            updateRequest(invoice, customerId: customerOfB.id),
            businessId: businessAId,
          ),
          throwsA(isA<NotFoundException>()),
        );

        // The invoice must keep its previous (empty) customer.
        final fetched = await endpoints.invoice.get(
          sessionA,
          invoice.id!,
          businessId: businessAId,
        );
        expect(fetched.customerId, isNull);
      },
    );

    test(
      'when updating a draft invoice with an own customer then it is linked',
      () async {
        final customer = await endpoints.customer.create(
          sessionA,
          CreateCustomerRequest(name: 'Kunde von A'),
          businessId: businessAId,
        );
        final invoice = await createDraftInvoice(sessionA, businessAId);

        final updated = await endpoints.invoice.update(
          sessionA,
          updateRequest(invoice, customerId: customer.id),
          businessId: businessAId,
        );

        expect(updated.customerId, customer.id);
      },
    );

    test('when editing a sent invoice then ConflictException', () async {
      final invoice = await createDraftInvoice(sessionA, businessAId);
      await endpoints.invoice.markSent(
        sessionA,
        invoice.id!,
        businessId: businessAId,
      );

      await expectLater(
        () => endpoints.invoice.update(
          sessionA,
          updateRequest(invoice, items: [item(description: 'hacked')]),
          businessId: businessAId,
        ),
        throwsA(isA<ConflictException>()),
      );
    });

    test('when editing a cancelled invoice then ConflictException', () async {
      final invoice = await createDraftInvoice(sessionA, businessAId);
      await endpoints.invoice.cancel(
        sessionA,
        invoice.id!,
        businessId: businessAId,
      );

      await expectLater(
        () => endpoints.invoice.update(
          sessionA,
          updateRequest(invoice, items: [item(description: 'hacked')]),
          businessId: businessAId,
        ),
        throwsA(isA<ConflictException>()),
      );
    });

    test(
      'when a Kleinunternehmer updates items then VAT stays none (§19)',
      () async {
        final kuBusiness = await endpoints.business.create(
          sessionA,
          CreateBusinessRequest(
            name: 'Kleinunternehmer',
            isKleinunternehmer: true,
          ),
        );
        final invoice = await createDraftInvoice(
          sessionA,
          kuBusiness.id!,
          items: [item(unitPriceCents: 50000)],
        );
        expect(invoice.vatTotalCents, 0);

        // Even when the client explicitly requests standard VAT rates.
        final updated = await endpoints.invoice.update(
          sessionA,
          updateRequest(
            invoice,
            items: [
              InvoiceItemRequest(
                description: 'Arbeit',
                quantity: 2,
                unitPriceCents: 25000,
                vatRate: VatRate.standard,
              ),
            ],
          ),
          businessId: kuBusiness.id!,
        );

        expect(updated.subtotalCents, 50000);
        expect(updated.vatTotalCents, 0);
        expect(updated.totalCents, 50000);

        final items = await endpoints.invoice.getItems(
          sessionA,
          invoice.id!,
          businessId: kuBusiness.id!,
        );
        expect(items.first.vatRate, VatRate.none);
      },
    );

    test('when deleting a sent invoice then ConflictException', () async {
      final invoice = await createDraftInvoice(sessionA, businessAId);
      await endpoints.invoice.markSent(
        sessionA,
        invoice.id!,
        businessId: businessAId,
      );

      await expectLater(
        () => endpoints.invoice.delete(
          sessionA,
          invoice.id!,
          businessId: businessAId,
        ),
        throwsA(isA<ConflictException>()),
      );
    });

    test('when deleting a paid invoice then ConflictException', () async {
      final invoice = await createDraftInvoice(sessionA, businessAId);
      await endpoints.invoice.markSent(
        sessionA,
        invoice.id!,
        businessId: businessAId,
      );
      await endpoints.payment.record(
        sessionA,
        RecordPaymentRequest(
          invoiceId: invoice.id!,
          amountCents: invoice.totalCents,
        ),
        businessId: businessAId,
      );

      await expectLater(
        () => endpoints.invoice.delete(
          sessionA,
          invoice.id!,
          businessId: businessAId,
        ),
        throwsA(isA<ConflictException>()),
      );
    });

    test(
      'when deleting a partially paid invoice then ConflictException',
      () async {
        final invoice = await createDraftInvoice(sessionA, businessAId);
        await endpoints.invoice.markSent(
          sessionA,
          invoice.id!,
          businessId: businessAId,
        );
        await endpoints.payment.record(
          sessionA,
          RecordPaymentRequest(invoiceId: invoice.id!, amountCents: 1000),
          businessId: businessAId,
        );

        final fetched = await endpoints.invoice.get(
          sessionA,
          invoice.id!,
          businessId: businessAId,
        );
        expect(fetched.status, InvoiceStatus.partiallyPaid);

        await expectLater(
          () => endpoints.invoice.delete(
            sessionA,
            invoice.id!,
            businessId: businessAId,
          ),
          throwsA(isA<ConflictException>()),
        );
      },
    );

    test('when deleting an overdue invoice then ConflictException', () async {
      final invoice = await createDraftInvoice(
        sessionA,
        businessAId,
        dueDate: DateTime(2026, 8, 1),
      );
      await endpoints.invoice.markSent(
        sessionA,
        invoice.id!,
        businessId: businessAId,
      );
      await getIt<MarkOverdueInvoicesUseCase>().call(
        sessionA.build(),
        now: DateTime(2026, 8, 20),
      );

      final fetched = await endpoints.invoice.get(
        sessionA,
        invoice.id!,
        businessId: businessAId,
      );
      expect(fetched.status, InvoiceStatus.overdue);

      await expectLater(
        () => endpoints.invoice.delete(
          sessionA,
          invoice.id!,
          businessId: businessAId,
        ),
        throwsA(isA<ConflictException>()),
      );
    });

    test(
      'when deleting a cancelled invoice then it is removed',
      () async {
        final invoice = await createDraftInvoice(sessionA, businessAId);
        await endpoints.invoice.cancel(
          sessionA,
          invoice.id!,
          businessId: businessAId,
        );

        await endpoints.invoice.delete(
          sessionA,
          invoice.id!,
          businessId: businessAId,
        );

        await expectLater(
          () => endpoints.invoice.get(
            sessionA,
            invoice.id!,
            businessId: businessAId,
          ),
          throwsA(isA<NotFoundException>()),
        );
      },
    );
  });

  withServerpod('Given template logo guards', (sessionBuilder, endpoints) {
    late TestSessionBuilder sessionA;
    late TestSessionBuilder sessionB;
    late int businessAId;
    late int businessBId;

    Future<Document> uploadLogo(
      TestSessionBuilder session,
      int businessId,
      String fileName,
    ) => endpoints.document.upload(
      session,
      UploadDocumentRequest(
        businessId: businessId,
        kind: DocumentKind.logo,
        fileName: fileName,
        data: ByteData.sublistView(utf8.encode('png-bytes')),
      ),
    );

    setUp(() async {
      sessionA = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(userAId, {}),
      );
      sessionB = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(userBId, {}),
      );
      final businessA = await endpoints.business.create(
        sessionA,
        CreateBusinessRequest(name: 'Gewerbe A'),
      );
      businessAId = businessA.id!;
      final businessB = await endpoints.business.create(
        sessionB,
        CreateBusinessRequest(name: 'Gewerbe B'),
      );
      businessBId = businessB.id!;
    });

    test(
      'when creating a template with an own logo document then it is stored',
      () async {
        final logo = await uploadLogo(sessionA, businessAId, 'logo-a.png');

        final template = await endpoints.invoiceTemplate.create(
          sessionA,
          CreateInvoiceTemplateRequest(
            name: 'Standard',
            logoDocumentId: logo.id,
          ),
          businessId: businessAId,
        );

        expect(template.logoDocumentId, logo.id);
      },
    );

    test(
      'when creating a template with a foreign logo document then NotFoundException',
      () async {
        final foreignLogo = await uploadLogo(
          sessionB,
          businessBId,
          'logo-b.png',
        );

        await expectLater(
          () => endpoints.invoiceTemplate.create(
            sessionA,
            CreateInvoiceTemplateRequest(
              name: 'Standard',
              logoDocumentId: foreignLogo.id,
            ),
            businessId: businessAId,
          ),
          throwsA(isA<NotFoundException>()),
        );

        final templates = await endpoints.invoiceTemplate.list(
          sessionA,
          businessId: businessAId,
        );
        expect(templates, isEmpty);
      },
    );

    test(
      'when updating a template with a foreign logo document then NotFoundException',
      () async {
        final ownLogo = await uploadLogo(sessionA, businessAId, 'logo-a.png');
        final foreignLogo = await uploadLogo(
          sessionB,
          businessBId,
          'logo-b.png',
        );
        final template = await endpoints.invoiceTemplate.create(
          sessionA,
          CreateInvoiceTemplateRequest(
            name: 'Standard',
            logoDocumentId: ownLogo.id,
          ),
          businessId: businessAId,
        );

        await expectLater(
          () => endpoints.invoiceTemplate.update(
            sessionA,
            UpdateInvoiceTemplateRequest(
              templateId: template.id!,
              name: 'Standard',
              isDefault: false,
              logoDocumentId: foreignLogo.id,
            ),
            businessId: businessAId,
          ),
          throwsA(isA<NotFoundException>()),
        );

        final fetched = await endpoints.invoiceTemplate.get(
          sessionA,
          template.id!,
          businessId: businessAId,
        );
        expect(fetched.logoDocumentId, ownLogo.id);
      },
    );

    test(
      'when updating a template with an own logo document then it is stored',
      () async {
        final newLogo = await uploadLogo(sessionA, businessAId, 'logo-new.png');
        final template = await endpoints.invoiceTemplate.create(
          sessionA,
          CreateInvoiceTemplateRequest(name: 'Standard'),
          businessId: businessAId,
        );

        final updated = await endpoints.invoiceTemplate.update(
          sessionA,
          UpdateInvoiceTemplateRequest(
            templateId: template.id!,
            name: 'Standard',
            isDefault: false,
            logoDocumentId: newLogo.id,
          ),
          businessId: businessAId,
        );

        expect(updated.logoDocumentId, newLogo.id);
      },
    );
  });
}
