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

  withServerpod('Given correction invoices', (sessionBuilder, endpoints) {
    late TestSessionBuilder sessionA;
    late TestSessionBuilder sessionB;
    late int businessAId;
    late int businessBId;
    late int customerAId;

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
      final customer = await endpoints.customer.create(
        sessionA,
        CreateCustomerRequest(
          name: 'Kunde A',
          email: 'kunde-a@example.test',
        ),
        businessId: businessAId,
      );
      customerAId = customer.id!;
    });

    List<InvoiceItemRequest> mixedItems() => [
      InvoiceItemRequest(
        description: 'Beratung',
        quantity: 2,
        unit: InvoiceItemUnit.hour,
        unitPriceCents: 5000,
        vatRate: VatRate.standard,
      ),
      InvoiceItemRequest(
        description: 'Lektorat',
        quantity: 1,
        unit: InvoiceItemUnit.piece,
        unitPriceCents: 5000,
        vatRate: VatRate.reduced,
      ),
    ];

    Future<Invoice> createOriginal({
      int business = 0,
      bool sent = true,
      int? customerId,
      DateTime? issueDate,
    }) async {
      final targetBusiness = business == 0 ? businessAId : business;
      final invoice = await endpoints.invoice.create(
        business == 0 ? sessionA : sessionB,
        CreateInvoiceRequest(
          customerId: customerId ?? (business == 0 ? customerAId : null),
          issueDate: issueDate ?? DateTime(2026, 7, 1),
          dueDate: DateTime(2026, 7, 15),
          items: mixedItems(),
        ),
        businessId: targetBusiness,
      );
      if (!sent) return invoice;
      return endpoints.invoice.markSent(
        business == 0 ? sessionA : sessionB,
        invoice.id!,
        businessId: targetBusiness,
      );
    }

    Future<Invoice> createCredit(
      Invoice original, {
      TestSessionBuilder? session,
      int? businessId,
      DateTime? issueDate,
      String? reason,
    }) {
      return endpoints.invoice.createCreditNote(
        session ?? sessionA,
        CreateCreditNoteRequest(
          originalInvoiceId: original.id!,
          issueDate: issueDate,
          reason: reason,
        ),
        businessId: businessId ?? businessAId,
      );
    }

    test(
      'when creating a credit note then it is an exact linked negative draft',
      () async {
        final original = await createOriginal();

        final credit = await createCredit(original, reason: ' Falsch  ');

        expect(credit.type, InvoiceType.creditNote);
        expect(credit.status, InvoiceStatus.draft);
        expect(credit.originalInvoiceId, original.id);
        expect(credit.customerId, original.customerId);
        expect(credit.number, isNot(original.number));
        expect(credit.subtotalCents, -original.subtotalCents);
        expect(credit.vatTotalCents, -original.vatTotalCents);
        expect(credit.totalCents, -original.totalCents);
        expect(credit.dueDate, isNull);
        expect(credit.paymentTermsDays, 0);
        expect(credit.notes, 'Falsch');

        final items = await endpoints.invoice.getItems(
          sessionA,
          credit.id!,
          businessId: businessAId,
        );
        expect(items, hasLength(2));
        expect(items[0].unitPriceCents, -5000);
        expect(items[0].lineTotalCents, -10000);
        expect(items[0].vatRate, VatRate.standard);
        expect(items[1].lineTotalCents, -5000);
        expect(items[1].vatRate, VatRate.reduced);

        // Creating the draft does not change the original.
        final unchanged = await endpoints.invoice.get(
          sessionA,
          original.id!,
          businessId: businessAId,
        );
        expect(unchanged.status, InvoiceStatus.sent);
        expect(unchanged.totalCents, original.totalCents);
        expect(unchanged.originalInvoiceId, isNull);
      },
    );

    test('when crediting a foreign invoice then NotFoundException', () async {
      final foreign = await createOriginal(business: businessBId);

      await expectLater(
        () => createCredit(foreign, businessId: businessAId),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('when the original is still draft then ConflictException', () async {
      final draft = await createOriginal(sent: false);

      await expectLater(
        () => createCredit(draft),
        throwsA(isA<ConflictException>()),
      );
    });

    test('when crediting a credit note then ValidationException', () async {
      final original = await createOriginal();
      final credit = await createCredit(original);

      await expectLater(
        () => createCredit(credit),
        throwsA(isA<ValidationException>()),
      );
    });

    test(
      'when issue date precedes the original then ValidationException',
      () async {
        final original = await createOriginal();

        await expectLater(
          () => createCredit(original, issueDate: DateTime(2026, 6, 30)),
          throwsA(isA<ValidationException>()),
        );
      },
    );

    test(
      'when the generic create path requests a credit note then it is rejected',
      () async {
        await expectLater(
          () => endpoints.invoice.create(
            sessionA,
            CreateInvoiceRequest(
              type: InvoiceType.creditNote,
              items: mixedItems(),
            ),
            businessId: businessAId,
          ),
          throwsA(isA<ValidationException>()),
        );
      },
    );

    test('when two drafts exist then only the first can be issued', () async {
      final original = await createOriginal();
      final first = await createCredit(original);
      final second = await createCredit(original);

      final issued = await endpoints.invoice.markSent(
        sessionA,
        first.id!,
        businessId: businessAId,
      );
      expect(issued.status, InvoiceStatus.sent);
      expect(issued.originalInvoiceId, original.id);

      await expectLater(
        () => endpoints.invoice.markSent(
          sessionA,
          second.id!,
          businessId: businessAId,
        ),
        throwsA(isA<ConflictException>()),
      );

      // The losing draft stays a harmless draft and the original is intact.
      final secondAfter = await endpoints.invoice.get(
        sessionA,
        second.id!,
        businessId: businessAId,
      );
      expect(secondAfter.status, InvoiceStatus.draft);
      final originalAfter = await endpoints.invoice.get(
        sessionA,
        original.id!,
        businessId: businessAId,
      );
      expect(originalAfter.status, InvoiceStatus.sent);
    });

    test(
      'when a paid original is credited then payment history stays',
      () async {
        final original = await createOriginal();
        await endpoints.payment.record(
          sessionA,
          RecordPaymentRequest(
            invoiceId: original.id!,
            amountCents: original.totalCents,
          ),
          businessId: businessAId,
        );
        final credit = await createCredit(original);
        final issued = await endpoints.invoice.markSent(
          sessionA,
          credit.id!,
          businessId: businessAId,
        );
        expect(issued.status, InvoiceStatus.sent);

        final status = await endpoints.payment.status(
          sessionA,
          original.id!,
          businessId: businessAId,
        );
        expect(status.paidTotalCents, original.totalCents);
        expect(status.isPaid, isTrue);
      },
    );

    test('when business becomes Kleinunternehmer then stored VAT is still reversed', () async {
      final original = await createOriginal();
      final currentBusiness = await endpoints.business.get(
        sessionA,
        businessId: businessAId,
      );
      await endpoints.business.update(
        sessionA,
        UpdateBusinessRequest(
          businessId: businessAId,
          name: 'Gewerbe A',
          legalForm: currentBusiness.legalForm,
          isKleinunternehmer: true,
          locale: currentBusiness.locale,
          currency: currentBusiness.currency,
        ),
      );

      final credit = await createCredit(original);
      expect(credit.vatTotalCents, -original.vatTotalCents);
      expect(credit.vatTotalCents, isNot(0));
    });

    test(
      'when a credit draft exists then the original cannot be cancelled',
      () async {
        final original = await createOriginal();
        final credit = await createCredit(original);

        await expectLater(
          () => endpoints.invoice.cancel(
            sessionA,
            original.id!,
            businessId: businessAId,
          ),
          throwsA(isA<ConflictException>()),
        );

        final cancelledCredit = await endpoints.invoice.cancel(
          sessionA,
          credit.id!,
          businessId: businessAId,
        );
        expect(cancelledCredit.status, InvoiceStatus.cancelled);

        final cancelledOriginal = await endpoints.invoice.cancel(
          sessionA,
          original.id!,
          businessId: businessAId,
        );
        expect(cancelledOriginal.status, InvoiceStatus.cancelled);
      },
    );

    test(
      'when an issued credit exists then it is immutable and blocks payments',
      () async {
        final original = await createOriginal();
        final credit = await createCredit(original);
        await endpoints.invoice.markSent(
          sessionA,
          credit.id!,
          businessId: businessAId,
        );

        await expectLater(
          () => endpoints.invoice.cancel(
            sessionA,
            credit.id!,
            businessId: businessAId,
          ),
          throwsA(isA<ConflictException>()),
        );
        await expectLater(
          () => endpoints.invoice.update(
            sessionA,
            UpdateInvoiceRequest(
              invoiceId: credit.id!,
              issueDate: credit.issueDate,
              paymentTermsDays: 0,
              items: mixedItems(),
            ),
            businessId: businessAId,
          ),
          throwsA(isA<ConflictException>()),
        );
        await expectLater(
          () => endpoints.payment.record(
            sessionA,
            RecordPaymentRequest(invoiceId: credit.id!, amountCents: 1),
            businessId: businessAId,
          ),
          throwsA(isA<ValidationException>()),
        );
        await expectLater(
          () => endpoints.payment.status(
            sessionA,
            credit.id!,
            businessId: businessAId,
          ),
          throwsA(isA<ValidationException>()),
        );
        await expectLater(
          () => endpoints.payment.record(
            sessionA,
            RecordPaymentRequest(invoiceId: original.id!, amountCents: 100),
            businessId: businessAId,
          ),
          throwsA(isA<ValidationException>()),
        );
        await expectLater(
          () => endpoints.reminder.send(
            sessionA,
            credit.id!,
            businessId: businessAId,
          ),
          throwsA(isA<ConflictException>()),
        );
        await expectLater(
          () => endpoints.reminder.send(
            sessionA,
            original.id!,
            businessId: businessAId,
          ),
          throwsA(isA<ConflictException>()),
        );
      },
    );

    test(
      'when deleting an original with a linked credit then ConflictException',
      () async {
        final original = await createOriginal();
        await createCredit(original);

        await expectLater(
          () => endpoints.invoice.delete(
            sessionA,
            original.id!,
            businessId: businessAId,
          ),
          throwsA(isA<ConflictException>()),
        );
      },
    );

    test(
      'when exporting a credit note then XRechnung references the original',
      () async {
        final original = await createOriginal();
        final credit = await createCredit(original);
        await endpoints.invoice.markSent(
          sessionA,
          credit.id!,
          businessId: businessAId,
        );

        final xml = await endpoints.invoice.exportXrechnung(
          sessionA,
          credit.id!,
          businessId: businessAId,
        );

        expect(xml, contains('<ram:TypeCode>381</ram:TypeCode>'));
        expect(xml, contains('<ram:InvoiceReferencedDocument>'));
        expect(xml, contains('<ram:ID>${original.number}</ram:ID>'));
        final grandTotal = (credit.totalCents / 100).toStringAsFixed(2);
        expect(
          xml,
          contains('<ram:GrandTotalAmount>$grandTotal</ram:GrandTotalAmount>'),
        );
      },
    );

    test(
      'when a credit note is created then the audit trail records the link',
      () async {
        final original = await createOriginal();
        final credit = await createCredit(original);

        final entries = await AuditEntry.db.find(
          sessionA.build(),
          where: (t) =>
              t.entityId.equals('${credit.id}') &
              t.action.equals('invoice.creditNote.create'),
        );
        expect(entries, hasLength(1));
        expect(entries.single.changes?['originalInvoiceId'], '${original.id}');
        expect(
          entries.single.changes?['vatTotalCents'],
          '${credit.vatTotalCents}',
        );
      },
    );
  });
}
