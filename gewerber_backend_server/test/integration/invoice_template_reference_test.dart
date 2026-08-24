@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// The optional `templateId` of Create/UpdateInvoiceRequest must reference a
/// template owned by the current tenant — a foreign or nonexistent template
/// is reported as NotFoundException, never as a server error.
void main() {
  const userAId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const userBId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given invoice template reference guards', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder sessionA;
    late TestSessionBuilder sessionB;
    late int businessAId;
    late int businessBId;
    late InvoiceTemplate templateOfB;

    InvoiceItemRequest item() => InvoiceItemRequest(
      description: 'A',
      quantity: 1,
      unitPriceCents: 10000,
      vatRate: VatRate.standard,
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
      templateOfB = await endpoints.invoiceTemplate.create(
        sessionB,
        CreateInvoiceTemplateRequest(name: 'Von B'),
        businessId: businessBId,
      );
    });

    test(
      'when creating an invoice with an own template then it is linked',
      () async {
        final own = await endpoints.invoiceTemplate.create(
          sessionA,
          CreateInvoiceTemplateRequest(name: 'Von A'),
          businessId: businessAId,
        );

        final invoice = await endpoints.invoice.create(
          sessionA,
          CreateInvoiceRequest(items: [item()], templateId: own.id),
          businessId: businessAId,
        );

        expect(invoice.templateId, own.id);
      },
    );

    test(
      'when creating an invoice without a template then no check applies',
      () async {
        final invoice = await endpoints.invoice.create(
          sessionA,
          CreateInvoiceRequest(items: [item()]),
          businessId: businessAId,
        );

        expect(invoice.templateId, isNull);
      },
    );

    test(
      'when creating an invoice with a foreign template then NotFoundException',
      () async {
        await expectLater(
          () => endpoints.invoice.create(
            sessionA,
            CreateInvoiceRequest(items: [item()], templateId: templateOfB.id),
            businessId: businessAId,
          ),
          throwsA(isA<NotFoundException>()),
        );

        // The foreign template must be untouched.
        final fetched = await endpoints.invoiceTemplate.get(
          sessionB,
          templateOfB.id!,
          businessId: businessBId,
        );
        expect(fetched.id, templateOfB.id);
      },
    );

    test(
      'when creating an invoice with a nonexistent template then NotFoundException',
      () async {
        await expectLater(
          () => endpoints.invoice.create(
            sessionA,
            CreateInvoiceRequest(
              items: [item()],
              templateId: templateOfB.id! + 1000000,
            ),
            businessId: businessAId,
          ),
          throwsA(isA<NotFoundException>()),
        );
      },
    );

    test(
      'when updating a draft invoice with an own template then it is linked',
      () async {
        final own = await endpoints.invoiceTemplate.create(
          sessionA,
          CreateInvoiceTemplateRequest(name: 'Von A'),
          businessId: businessAId,
        );
        final invoice = await endpoints.invoice.create(
          sessionA,
          CreateInvoiceRequest(items: [item()]),
          businessId: businessAId,
        );

        final updated = await endpoints.invoice.update(
          sessionA,
          UpdateInvoiceRequest(
            invoiceId: invoice.id!,
            issueDate: invoice.issueDate,
            paymentTermsDays: invoice.paymentTermsDays,
            items: [item()],
            templateId: own.id,
          ),
          businessId: businessAId,
        );

        expect(updated.templateId, own.id);
      },
    );

    test(
      'when updating a draft invoice with a foreign template then NotFoundException',
      () async {
        final invoice = await endpoints.invoice.create(
          sessionA,
          CreateInvoiceRequest(items: [item()]),
          businessId: businessAId,
        );

        await expectLater(
          () => endpoints.invoice.update(
            sessionA,
            UpdateInvoiceRequest(
              invoiceId: invoice.id!,
              issueDate: invoice.issueDate,
              paymentTermsDays: invoice.paymentTermsDays,
              items: [item()],
              templateId: templateOfB.id,
            ),
            businessId: businessAId,
          ),
          throwsA(isA<NotFoundException>()),
        );

        // The draft must keep its previous (empty) template.
        final fetched = await endpoints.invoice.get(
          sessionA,
          invoice.id!,
          businessId: businessAId,
        );
        expect(fetched.templateId, isNull);
      },
    );
  });
}
