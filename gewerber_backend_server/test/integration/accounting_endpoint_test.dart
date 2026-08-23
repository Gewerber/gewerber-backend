@Tags(['integration'])
library;

import 'dart:convert';
import 'dart:typed_data';

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

  withServerpod('Given Accounting', (sessionBuilder, endpoints) {
    late TestSessionBuilder sessionA;
    late int businessId;

    setUp(() async {
      sessionA = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(userAId, {}),
      );
      final business = await endpoints.business.create(
        sessionA,
        CreateBusinessRequest(name: 'Mein Gewerbe'),
      );
      businessId = business.id!;
    });

    Future<AccountingTransaction> createExpense({
      int amountCents = 5000,
      TransactionCategory category = TransactionCategory.office,
      DateTime? occurredAt,
    }) {
      return endpoints.accounting.create(
        sessionA,
        CreateTransactionRequest(
          type: TransactionType.expense,
          category: category,
          description: 'Büromaterial',
          occurredAt: occurredAt ?? DateTime(2026, 8, 10),
          amountCents: amountCents,
        ),
        businessId: businessId,
      );
    }

    test('when creating transactions then they are stored', () async {
      final income = await endpoints.accounting.create(
        sessionA,
        CreateTransactionRequest(
          type: TransactionType.income,
          category: TransactionCategory.serviceRevenue,
          description: 'Beratung August',
          occurredAt: DateTime(2026, 8, 1),
          amountCents: 100000,
        ),
        businessId: businessId,
      );
      final expense = await createExpense();

      expect(income.id, isNotNull);
      expect(expense.id, isNotNull);

      final list = await endpoints.accounting.list(
        sessionA,
        businessId: businessId,
      );
      expect(list.length, 2);

      final incomes = await endpoints.accounting.list(
        sessionA,
        type: TransactionType.income,
        businessId: businessId,
      );
      expect(incomes.length, 1);
      expect(incomes.first.category, TransactionCategory.serviceRevenue);
    });

    test('when amount is negative then ValidationException', () async {
      await expectLater(
        () => endpoints.accounting.create(
          sessionA,
          CreateTransactionRequest(
            type: TransactionType.expense,
            category: TransactionCategory.office,
            occurredAt: DateTime(2026, 8, 10),
            amountCents: -5,
          ),
          businessId: businessId,
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test(
      'when category does not match type then ValidationException',
      () async {
        await expectLater(
          () => endpoints.accounting.create(
            sessionA,
            CreateTransactionRequest(
              type: TransactionType.income,
              category: TransactionCategory.office,
              occurredAt: DateTime(2026, 8, 10),
              amountCents: 100,
            ),
            businessId: businessId,
          ),
          throwsA(isA<ValidationException>()),
        );
      },
    );

    test('when attaching a receipt then it is linked', () async {
      final receipt = await endpoints.document.upload(
        sessionA,
        UploadDocumentRequest(
          businessId: businessId,
          kind: DocumentKind.receipt,
          fileName: 'beleg.pdf',
          data: ByteData.sublistView(utf8.encode('fake pdf')),
        ),
      );

      final transaction = await endpoints.accounting.create(
        sessionA,
        CreateTransactionRequest(
          type: TransactionType.expense,
          category: TransactionCategory.office,
          occurredAt: DateTime(2026, 8, 10),
          amountCents: 1234,
          receiptDocumentId: receipt.id,
        ),
        businessId: businessId,
      );
      expect(transaction.receiptDocumentId, receipt.id);
    });

    test(
      'when receipt belongs to another tenant then NotFoundException',
      () async {
        final sessionB = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            userBId,
            {},
          ),
        );
        final businessB = await endpoints.business.create(
          sessionB,
          CreateBusinessRequest(name: 'Gewerbe B'),
        );
        final foreignReceipt = await endpoints.document.upload(
          sessionB,
          UploadDocumentRequest(
            businessId: businessB.id!,
            kind: DocumentKind.receipt,
            fileName: 'fremd.pdf',
            data: ByteData.sublistView(utf8.encode('x')),
          ),
        );

        await expectLater(
          () => endpoints.accounting.create(
            sessionA,
            CreateTransactionRequest(
              type: TransactionType.expense,
              category: TransactionCategory.office,
              occurredAt: DateTime(2026, 8, 10),
              amountCents: 100,
              receiptDocumentId: foreignReceipt.id,
            ),
            businessId: businessId,
          ),
          throwsA(isA<NotFoundException>()),
        );
      },
    );

    test('when linking an own related invoice then it is stored', () async {
      final invoice = await endpoints.invoice.create(
        sessionA,
        CreateInvoiceRequest(
          items: [
            InvoiceItemRequest(
              description: 'Beratung',
              quantity: 1,
              unitPriceCents: 10000,
            ),
          ],
        ),
        businessId: businessId,
      );

      final transaction = await endpoints.accounting.create(
        sessionA,
        CreateTransactionRequest(
          type: TransactionType.income,
          category: TransactionCategory.serviceRevenue,
          occurredAt: DateTime(2026, 8, 12),
          amountCents: 11900,
          relatedInvoiceId: invoice.id,
        ),
        businessId: businessId,
      );
      expect(transaction.relatedInvoiceId, invoice.id);
    });

    test(
      'when related invoice belongs to another tenant then NotFoundException',
      () async {
        final sessionB = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            userBId,
            {},
          ),
        );
        final businessB = await endpoints.business.create(
          sessionB,
          CreateBusinessRequest(name: 'Gewerbe B'),
        );
        final foreignInvoice = await endpoints.invoice.create(
          sessionB,
          CreateInvoiceRequest(
            items: [
              InvoiceItemRequest(
                description: 'Fremd',
                quantity: 1,
                unitPriceCents: 5000,
              ),
            ],
          ),
          businessId: businessB.id!,
        );

        await expectLater(
          () => endpoints.accounting.create(
            sessionA,
            CreateTransactionRequest(
              type: TransactionType.income,
              category: TransactionCategory.serviceRevenue,
              occurredAt: DateTime(2026, 8, 12),
              amountCents: 100,
              relatedInvoiceId: foreignInvoice.id,
            ),
            businessId: businessId,
          ),
          throwsA(isA<NotFoundException>()),
        );
      },
    );

    test(
      'when updating with a receipt of another tenant then NotFoundException',
      () async {
        final transaction = await createExpense();
        final sessionB = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            userBId,
            {},
          ),
        );
        final businessB = await endpoints.business.create(
          sessionB,
          CreateBusinessRequest(name: 'Gewerbe B'),
        );
        final foreignReceipt = await endpoints.document.upload(
          sessionB,
          UploadDocumentRequest(
            businessId: businessB.id!,
            kind: DocumentKind.receipt,
            fileName: 'fremd.pdf',
            data: ByteData.sublistView(utf8.encode('x')),
          ),
        );

        await expectLater(
          () => endpoints.accounting.update(
            sessionA,
            UpdateTransactionRequest(
              transactionId: transaction.id!,
              type: TransactionType.expense,
              category: TransactionCategory.office,
              description: 'Büromaterial',
              occurredAt: DateTime(2026, 8, 10),
              amountCents: 5000,
              receiptDocumentId: foreignReceipt.id,
            ),
            businessId: businessId,
          ),
          throwsA(isA<NotFoundException>()),
        );

        // The transaction must keep its previous (empty) receipt.
        final fetched = await endpoints.accounting.get(
          sessionA,
          transaction.id!,
          businessId: businessId,
        );
        expect(fetched.receiptDocumentId, isNull);
      },
    );

    test(
      'when updating with a related invoice of another tenant then NotFoundException',
      () async {
        final transaction = await createExpense();
        final sessionB = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            userBId,
            {},
          ),
        );
        final businessB = await endpoints.business.create(
          sessionB,
          CreateBusinessRequest(name: 'Gewerbe B'),
        );
        final foreignInvoice = await endpoints.invoice.create(
          sessionB,
          CreateInvoiceRequest(
            items: [
              InvoiceItemRequest(
                description: 'Fremd',
                quantity: 1,
                unitPriceCents: 5000,
              ),
            ],
          ),
          businessId: businessB.id!,
        );

        await expectLater(
          () => endpoints.accounting.update(
            sessionA,
            UpdateTransactionRequest(
              transactionId: transaction.id!,
              type: TransactionType.expense,
              category: TransactionCategory.office,
              description: 'Büromaterial',
              occurredAt: DateTime(2026, 8, 10),
              amountCents: 5000,
              relatedInvoiceId: foreignInvoice.id,
            ),
            businessId: businessId,
          ),
          throwsA(isA<NotFoundException>()),
        );

        // The transaction must keep its previous (empty) reference.
        final fetched = await endpoints.accounting.get(
          sessionA,
          transaction.id!,
          businessId: businessId,
        );
        expect(fetched.relatedInvoiceId, isNull);
      },
    );

    test('when updating and deleting then changes apply', () async {
      final transaction = await createExpense();

      final updated = await endpoints.accounting.update(
        sessionA,
        UpdateTransactionRequest(
          transactionId: transaction.id!,
          type: TransactionType.expense,
          category: TransactionCategory.advertising,
          description: 'Werbung',
          occurredAt: DateTime(2026, 8, 11),
          amountCents: 7777,
        ),
        businessId: businessId,
      );
      expect(updated.category, TransactionCategory.advertising);
      expect(updated.amountCents, 7777);

      await endpoints.accounting.delete(
        sessionA,
        transaction.id!,
        businessId: businessId,
      );
      await expectLater(
        () => endpoints.accounting.get(
          sessionA,
          transaction.id!,
          businessId: businessId,
        ),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('when requesting P&L then totals and lines are computed', () async {
      await endpoints.accounting.create(
        sessionA,
        CreateTransactionRequest(
          type: TransactionType.income,
          category: TransactionCategory.serviceRevenue,
          occurredAt: DateTime(2026, 8, 1),
          amountCents: 100000,
        ),
        businessId: businessId,
      );
      await endpoints.accounting.create(
        sessionA,
        CreateTransactionRequest(
          type: TransactionType.income,
          category: TransactionCategory.salesRevenue,
          occurredAt: DateTime(2026, 8, 5),
          amountCents: 50000,
        ),
        businessId: businessId,
      );
      await createExpense(amountCents: 20000);
      await createExpense(
        amountCents: 3000,
        category: TransactionCategory.telecommunication,
      );

      final report = await endpoints.accounting.profitLoss(
        sessionA,
        DateTime(2026, 8, 1),
        DateTime(2026, 8, 31),
        businessId: businessId,
      );

      expect(report.incomeCents, 150000);
      expect(report.expenseCents, 23000);
      expect(report.profitCents, 127000);

      expect(report.incomeLines.length, 2);
      final serviceLine = report.incomeLines.firstWhere(
        (l) => l.category == TransactionCategory.serviceRevenue,
      );
      expect(serviceLine.amountCents, 100000);
      expect(serviceLine.count, 1);

      expect(report.expenseLines.length, 2);
      final officeLine = report.expenseLines.firstWhere(
        (l) => l.category == TransactionCategory.office,
      );
      expect(officeLine.amountCents, 20000);
    });

    test('when exporting CSV then rows match the transactions', () async {
      await endpoints.accounting.create(
        sessionA,
        CreateTransactionRequest(
          type: TransactionType.income,
          category: TransactionCategory.serviceRevenue,
          description: 'Projekt; Phase 1',
          occurredAt: DateTime(2026, 8, 1),
          amountCents: 119000,
        ),
        businessId: businessId,
      );

      final csv = await endpoints.accounting.exportCsv(
        sessionA,
        businessId: businessId,
      );

      final lines = csv.trim().split('\n');
      expect(lines.length, 2);
      expect(lines.first, 'Datum;Typ;Kategorie;Beschreibung;Betrag;Währung');
      expect(lines.last, contains('"Projekt; Phase 1"'));
      expect(lines.last, contains('1190,00'));
      expect(lines.last, startsWith('01.08.2026;income;serviceRevenue'));
    });

    test('when B lists transactions then A data does not leak', () async {
      await createExpense();

      final sessionB = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(userBId, {}),
      );
      final businessB = await endpoints.business.create(
        sessionB,
        CreateBusinessRequest(name: 'Gewerbe B'),
      );

      final list = await endpoints.accounting.list(
        sessionB,
        businessId: businessB.id,
      );
      expect(list, isEmpty);
    });
  });
}
