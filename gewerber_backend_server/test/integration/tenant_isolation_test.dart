@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const userAId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const userBId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given two businesses', (sessionBuilder, endpoints) {
    late TestSessionBuilder sessionA;
    late TestSessionBuilder sessionB;
    late int businessAId;
    late int businessBId;
    late Invoice invoiceA;
    late Customer customerA;

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

      customerA = await endpoints.customer.create(
        sessionA,
        CreateCustomerRequest(name: 'Kunde von A'),
        businessId: businessAId,
      );
      invoiceA = await endpoints.invoice.create(
        sessionA,
        CreateInvoiceRequest(
          customerId: customerA.id,
          items: [
            InvoiceItemRequest(
              description: 'A',
              quantity: 1,
              unitPriceCents: 1000,
            ),
          ],
        ),
        businessId: businessAId,
      );
    });

    test('when B lists with own business then no data of A leaks', () async {
      final invoices = await endpoints.invoice.list(
        sessionB,
        businessId: businessBId,
      );
      expect(invoices, isEmpty);

      final customers = await endpoints.customer.list(
        sessionB,
        businessId: businessBId,
      );
      expect(customers, isEmpty);

      final templates = await endpoints.invoiceTemplate.list(
        sessionB,
        businessId: businessBId,
      );
      expect(templates, isEmpty);
    });

    test('when B passes business of A then ForbiddenException', () async {
      await expectLater(
        () => endpoints.invoice.list(sessionB, businessId: businessAId),
        throwsA(isA<ForbiddenException>()),
      );
      await expectLater(
        () => endpoints.customer.list(sessionB, businessId: businessAId),
        throwsA(isA<ForbiddenException>()),
      );
    });

    test('when B reads entity of A by id then NotFoundException', () async {
      await expectLater(
        () => endpoints.invoice.get(
          sessionB,
          invoiceA.id!,
          businessId: businessBId,
        ),
        throwsA(isA<NotFoundException>()),
      );
      await expectLater(
        () => endpoints.customer.get(
          sessionB,
          customerA.id!,
          businessId: businessBId,
        ),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('when B mutates entity of A then NotFoundException', () async {
      await expectLater(
        () => endpoints.invoice.update(
          sessionB,
          UpdateInvoiceRequest(
            invoiceId: invoiceA.id!,
            issueDate: invoiceA.issueDate,
            paymentTermsDays: 14,
            items: [
              InvoiceItemRequest(
                description: 'hacked',
                quantity: 1,
                unitPriceCents: 1,
              ),
            ],
          ),
          businessId: businessBId,
        ),
        throwsA(isA<NotFoundException>()),
      );
      await expectLater(
        () => endpoints.invoice.delete(
          sessionB,
          invoiceA.id!,
          businessId: businessBId,
        ),
        throwsA(isA<NotFoundException>()),
      );

      // The invoice must still exist for A.
      final fetched = await endpoints.invoice.get(
        sessionA,
        invoiceA.id!,
        businessId: businessAId,
      );
      expect(fetched.id, invoiceA.id);
    });
  });
}
