@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/di/service_locator.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/application/process_recurring_invoices_use_case.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given CustomerEndpoint', (sessionBuilder, endpoints) {
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
        CreateBusinessRequest(name: 'Mein Gewerbe'),
      );
      businessId = business.id!;
    });

    test('when creating a customer then customer is stored', () async {
      final request = CreateCustomerRequest(
        name: 'ACME GmbH',
        vatId: 'DE123456789',
        email: 'billing@acme.de',
        address: Address(
          street: 'Industriestr. 5',
          zip: '12345',
          city: 'Berlin',
          country: Country.deu,
        ),
      );

      final customer = await endpoints.customer.create(
        authenticatedSession,
        request,
        businessId: businessId,
      );

      expect(customer.id, isNotNull);
      expect(customer.name, 'ACME GmbH');
      expect(customer.status, CustomerStatus.active);
      expect(customer.businessId, businessId);

      final fetched = await endpoints.customer.get(
        authenticatedSession,
        customer.id!,
        businessId: businessId,
      );
      expect(fetched.id, customer.id);
    });

    test(
      'when listing customers then only own customers are returned',
      () async {
        final customer = await endpoints.customer.create(
          authenticatedSession,
          CreateCustomerRequest(name: 'ACME GmbH'),
          businessId: businessId,
        );

        final list = await endpoints.customer.list(
          authenticatedSession,
          businessId: businessId,
        );
        expect(list.any((c) => c.id == customer.id), true);
      },
    );

    test('when updating a customer then fields are changed', () async {
      final customer = await endpoints.customer.create(
        authenticatedSession,
        CreateCustomerRequest(name: 'ACME GmbH'),
        businessId: businessId,
      );

      final updated = await endpoints.customer.update(
        authenticatedSession,
        UpdateCustomerRequest(
          customerId: customer.id!,
          status: CustomerStatus.active,
          name: 'ACME GmbH & Co KG',
          email: 'new@acme.de',
        ),
        businessId: businessId,
      );

      expect(updated.name, 'ACME GmbH & Co KG');
      expect(updated.email, 'new@acme.de');
    });

    test('when name is empty then ValidationException is thrown', () async {
      expect(
        () => endpoints.customer.create(
          authenticatedSession,
          CreateCustomerRequest(name: '   '),
          businessId: businessId,
        ),
        throwsA(isA<ValidationException>()),
      );
    });
  });

  withServerpod('Given InvoiceTemplateEndpoint', (sessionBuilder, endpoints) {
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
        CreateBusinessRequest(name: 'Mein Gewerbe'),
      );
      businessId = business.id!;
    });

    test('when creating a default template then it is the default', () async {
      final template = await endpoints.invoiceTemplate.create(
        authenticatedSession,
        CreateInvoiceTemplateRequest(
          name: 'Standard',
          isDefault: true,
          headerText: 'Rechnung',
        ),
        businessId: businessId,
      );

      expect(template.id, isNotNull);
      expect(template.isDefault, true);

      final second = await endpoints.invoiceTemplate.create(
        authenticatedSession,
        CreateInvoiceTemplateRequest(name: 'Proforma', isDefault: true),
        businessId: businessId,
      );
      expect(second.isDefault, true);

      final templates = await endpoints.invoiceTemplate.list(
        authenticatedSession,
        businessId: businessId,
      );
      final first = templates.firstWhere((t) => t.id == template.id);
      expect(first.isDefault, false);
    });
  });

  withServerpod('Given InvoiceEndpoint', (sessionBuilder, endpoints) {
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
        CreateBusinessRequest(name: 'Mein Gewerbe'),
      );
      businessId = business.id!;
    });

    test('when creating an invoice then totals are computed', () async {
      final customer = await endpoints.customer.create(
        authenticatedSession,
        CreateCustomerRequest(name: 'ACME GmbH'),
        businessId: businessId,
      );

      final request = CreateInvoiceRequest(
        customerId: customer.id,
        issueDate: DateTime(2026, 8, 14),
        items: [
          InvoiceItemRequest(
            description: 'Beratung',
            quantity: 10,
            unit: InvoiceItemUnit.hour,
            unitPriceCents: 10000,
            vatRate: VatRate.standard,
          ),
        ],
      );

      final invoice = await endpoints.invoice.create(
        authenticatedSession,
        request,
        businessId: businessId,
      );

      expect(invoice.id, isNotNull);
      expect(invoice.subtotalCents, 100000);
      expect(invoice.vatTotalCents, 19000);
      expect(invoice.totalCents, 119000);
      expect(invoice.number, startsWith('2026-'));
      expect(invoice.status, InvoiceStatus.draft);
      expect(invoice.paymentTermsDays, 14);

      final items = await endpoints.invoice.getItems(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(items.length, 1);
      expect(items.first.description, 'Beratung');
      expect(items.first.lineTotalCents, 100000);
    });

    test('when business is Kleinunternehmer then VAT is none', () async {
      final kleinBusiness = await endpoints.business.create(
        authenticatedSession,
        CreateBusinessRequest(
          name: 'Kleinunternehmer',
          isKleinunternehmer: true,
        ),
      );

      final invoice = await endpoints.invoice.create(
        authenticatedSession,
        CreateInvoiceRequest(
          items: [
            InvoiceItemRequest(
              description: 'Arbeit',
              quantity: 1,
              unitPriceCents: 50000,
              vatRate: VatRate.standard,
            ),
          ],
        ),
        businessId: kleinBusiness.id,
      );

      expect(invoice.subtotalCents, 50000);
      expect(invoice.vatTotalCents, 0);
      expect(invoice.totalCents, 50000);

      final items = await endpoints.invoice.getItems(
        authenticatedSession,
        invoice.id!,
        businessId: kleinBusiness.id,
      );
      expect(items.first.vatRate, VatRate.none);
    });

    test('when updating an invoice then items are replaced', () async {
      final invoice = await endpoints.invoice.create(
        authenticatedSession,
        CreateInvoiceRequest(
          items: [
            InvoiceItemRequest(
              description: 'A',
              quantity: 1,
              unitPriceCents: 1000,
            ),
          ],
        ),
        businessId: businessId,
      );

      final updated = await endpoints.invoice.update(
        authenticatedSession,
        UpdateInvoiceRequest(
          invoiceId: invoice.id!,
          customerId: null,
          issueDate: invoice.issueDate,
          paymentTermsDays: 30,
          items: [
            InvoiceItemRequest(
              description: 'B',
              quantity: 2,
              unitPriceCents: 2000,
            ),
            InvoiceItemRequest(
              description: 'C',
              quantity: 1,
              unitPriceCents: 500,
            ),
          ],
        ),
        businessId: businessId,
      );

      expect(updated.subtotalCents, 4500);
      expect(updated.totalCents, 5355);
      expect(updated.paymentTermsDays, 30);

      final items = await endpoints.invoice.getItems(
        authenticatedSession,
        updated.id!,
        businessId: businessId,
      );
      expect(items.length, 2);
      expect(items.map((i) => i.description).toSet(), {'B', 'C'});
    });

    test('when listing invoices then only own invoices are returned', () async {
      await endpoints.invoice.create(
        authenticatedSession,
        CreateInvoiceRequest(
          items: [
            InvoiceItemRequest(
              description: 'A',
              quantity: 1,
              unitPriceCents: 1000,
            ),
          ],
        ),
        businessId: businessId,
      );

      final list = await endpoints.invoice.list(
        authenticatedSession,
        businessId: businessId,
      );
      expect(list.length, 1);
    });

    test('when deleting a draft invoice then it is removed', () async {
      final invoice = await endpoints.invoice.create(
        authenticatedSession,
        CreateInvoiceRequest(
          items: [
            InvoiceItemRequest(
              description: 'A',
              quantity: 1,
              unitPriceCents: 1000,
            ),
          ],
        ),
        businessId: businessId,
      );

      await endpoints.invoice.delete(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );

      expect(
        () => endpoints.invoice.get(
          authenticatedSession,
          invoice.id!,
          businessId: businessId,
        ),
        throwsA(isA<NotFoundException>()),
      );
    });
  });

  withServerpod('Given PaymentEndpoint', (sessionBuilder, endpoints) {
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
        CreateBusinessRequest(name: 'Mein Gewerbe'),
      );
      businessId = business.id!;
    });

    test('when recording a full payment then invoice is marked paid', () async {
      final invoice = await endpoints.invoice.create(
        authenticatedSession,
        CreateInvoiceRequest(
          items: [
            InvoiceItemRequest(
              description: 'A',
              quantity: 1,
              unitPriceCents: 10000,
            ),
          ],
        ),
        businessId: businessId,
      );

      final record = await endpoints.payment.record(
        authenticatedSession,
        RecordPaymentRequest(
          invoiceId: invoice.id!,
          amountCents: invoice.totalCents,
          method: PaymentMethod.bankTransfer,
        ),
        businessId: businessId,
      );

      expect(record.id, isNotNull);

      final status = await endpoints.payment.status(
        authenticatedSession,
        invoice.id!,
        businessId: businessId,
      );
      expect(status.isPaid, true);
      expect(status.paidTotalCents, invoice.totalCents);
    });

    test(
      'when recording a partial payment then invoice is partially paid',
      () async {
        final invoice = await endpoints.invoice.create(
          authenticatedSession,
          CreateInvoiceRequest(
            items: [
              InvoiceItemRequest(
                description: 'A',
                quantity: 1,
                unitPriceCents: 10000,
              ),
            ],
          ),
          businessId: businessId,
        );

        await endpoints.payment.record(
          authenticatedSession,
          RecordPaymentRequest(
            invoiceId: invoice.id!,
            amountCents: 4000,
          ),
          businessId: businessId,
        );

        final fetched = await endpoints.invoice.get(
          authenticatedSession,
          invoice.id!,
          businessId: businessId,
        );
        expect(fetched.status, InvoiceStatus.partiallyPaid);
      },
    );
  });

  withServerpod('Given recurring invoices', (sessionBuilder, endpoints) {
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
        CreateBusinessRequest(name: 'Mein Gewerbe'),
      );
      businessId = business.id!;
    });

    test(
      'when processing due recurring invoices then clones are created',
      () async {
        final source = await endpoints.invoice.create(
          authenticatedSession,
          CreateInvoiceRequest(
            issueDate: DateTime(2026, 7, 1),
            nextRecurrenceDate: DateTime(2026, 8, 1),
            recurrenceInterval: RecurrenceInterval.monthly,
            items: [
              InvoiceItemRequest(
                description: 'Miete',
                quantity: 1,
                unitPriceCents: 50000,
                vatRate: VatRate.none,
              ),
            ],
          ),
          businessId: businessId,
        );
        expect(source.recurrenceOccurrencesCreated, 0);

        final useCase = getIt<ProcessRecurringInvoicesUseCase>();
        final createdCount = await useCase.call(
          authenticatedSession.build(),
          now: DateTime(2026, 8, 2),
        );

        expect(createdCount, 1);

        final list = await endpoints.invoice.list(
          authenticatedSession,
          businessId: businessId,
        );
        expect(list.length, 2);

        final clones = list.where((i) => i.id != source.id).toList();
        expect(clones.length, 1);
        expect(clones.first.issueDate.toUtc(), DateTime(2026, 8, 1).toUtc());
        expect(clones.first.status, InvoiceStatus.draft);

        final fetched = await endpoints.invoice.get(
          authenticatedSession,
          source.id!,
          businessId: businessId,
        );
        expect(fetched.recurrenceOccurrencesCreated, 1);
        expect(
          fetched.nextRecurrenceDate!.toUtc(),
          DateTime(2026, 9, 1).toUtc(),
        );
      },
    );
  });
}
