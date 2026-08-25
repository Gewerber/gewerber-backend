@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const userAId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const userBId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  // Fixed anchor so every bucket/window assertion is deterministic.
  final asOf = DateTime.utc(2026, 8, 20, 12);

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given DashboardEndpoint', (sessionBuilder, endpoints) {
    late TestSessionBuilder sessionA;
    late int businessId;

    setUp(() async {
      sessionA = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(userAId, {}),
      );
      final business = await endpoints.business.create(
        sessionA,
        CreateBusinessRequest(name: 'Dashboard GmbH'),
      );
      businessId = business.id!;
    });

    Future<Invoice> seedInvoice({
      InvoiceType type = InvoiceType.invoice,
      DateTime? issueDate,
      DateTime? dueDate,
      int unitPriceCents = 10000,
      int? customerId,
      bool markSent = false,
    }) async {
      final invoice = await endpoints.invoice.create(
        sessionA,
        CreateInvoiceRequest(
          type: type,
          customerId: customerId,
          issueDate: issueDate ?? DateTime.utc(2026, 7, 1),
          dueDate: dueDate,
          items: [
            InvoiceItemRequest(
              description: 'Position',
              quantity: 1,
              unitPriceCents: unitPriceCents,
            ),
          ],
        ),
        businessId: businessId,
      );
      if (markSent) {
        await endpoints.invoice.markSent(
          sessionA,
          invoice.id!,
          businessId: businessId,
        );
      }
      return invoice;
    }

    Future<AccountingTransaction> seedTransaction({
      required TransactionType type,
      required DateTime occurredAt,
      int amountCents = 1000,
    }) {
      return endpoints.accounting.create(
        sessionA,
        CreateTransactionRequest(
          type: type,
          category: type == TransactionType.income
              ? TransactionCategory.serviceRevenue
              : TransactionCategory.office,
          occurredAt: occurredAt,
          amountCents: amountCents,
        ),
        businessId: businessId,
      );
    }

    test(
      'when the business is empty then the summary is all zeros and empty',
      () async {
        final summary = await endpoints.dashboard.getSummary(
          sessionA,
          asOf: asOf,
          businessId: businessId,
        );

        expect(summary.kpis.incomeCents, 0);
        expect(summary.kpis.expenseCents, 0);
        expect(summary.kpis.profitCents, 0);
        expect(summary.kpis.totalMinutes, 0);
        expect(summary.kpis.billableMinutes, 0);
        expect(summary.kpis.roundedMinutes, 0);
        expect(summary.monthlyTrend, hasLength(6));
        for (final point in summary.monthlyTrend) {
          expect(point.incomeCents, 0);
          expect(point.expenseCents, 0);
          expect(point.profitCents, 0);
        }
        expect(summary.recentInvoices, isEmpty);
        expect(summary.recentTransactions, isEmpty);
        expect(summary.recentTimeEntries, isEmpty);
        expect(summary.receivables.openInvoicesCount, 0);
        expect(summary.receivables.openTotalCents, 0);
        expect(summary.receivables.overdueCount, 0);
        expect(summary.receivables.overdueTotalCents, 0);
        expect(summary.receivables.debtors, isEmpty);
        expect(summary.receivables.overdueInvoices, isEmpty);
      },
    );

    test(
      'when B asks then A data does not leak and foreign id is forbidden',
      () async {
        await seedTransaction(
          type: TransactionType.income,
          occurredAt: DateTime.utc(2026, 8, 2),
          amountCents: 4242,
        );

        final sessionB = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            userBId,
            {},
          ),
        );
        final businessB = await endpoints.business.create(
          sessionB,
          CreateBusinessRequest(name: 'Fremd GmbH'),
        );

        final summaryB = await endpoints.dashboard.getSummary(
          sessionB,
          asOf: asOf,
          businessId: businessB.id!,
        );
        expect(summaryB.kpis.incomeCents, 0);

        await expectLater(
          () => endpoints.dashboard.getSummary(
            sessionB,
            asOf: asOf,
            businessId: businessId,
          ),
          throwsA(isA<ForbiddenException>()),
        );
      },
    );

    test(
      'when transactions span months then buckets are per UTC month',
      () async {
        // Outside the window on purpose (window is May..Aug with 4 months).
        await seedTransaction(
          type: TransactionType.income,
          occurredAt: DateTime.utc(2026, 4, 2),
          amountCents: 7000,
        );
        await seedTransaction(
          type: TransactionType.income,
          occurredAt: DateTime.utc(2026, 7, 10),
          amountCents: 50000,
        );
        await seedTransaction(
          type: TransactionType.expense,
          occurredAt: DateTime.utc(2026, 7, 15),
          amountCents: 20000,
        );
        // Current (partial) month.
        await seedTransaction(
          type: TransactionType.income,
          occurredAt: DateTime.utc(2026, 8, 5),
          amountCents: 10000,
        );

        final summary = await endpoints.dashboard.getSummary(
          sessionA,
          trendMonths: 4,
          asOf: asOf,
          businessId: businessId,
        );

        expect(
          summary.monthlyTrend.map((p) => p.monthStart).toList(),
          [
            DateTime.utc(2026, 5),
            DateTime.utc(2026, 6),
            DateTime.utc(2026, 7),
            DateTime.utc(2026, 8),
          ],
        );

        final july = summary.monthlyTrend[2];
        expect(july.incomeCents, 50000);
        expect(july.expenseCents, 20000);
        expect(july.profitCents, 30000);

        final august = summary.monthlyTrend[3];
        expect(august.incomeCents, 10000); // current month included
        expect(august.profitCents, 10000);

        expect(summary.monthlyTrend[0].incomeCents, 0);
        expect(summary.monthlyTrend[1].expenseCents, 0);
      },
    );

    // GOLDEN invariant: summing the monthly trend reproduces
    // accounting.profitLoss over [trendFrom, trendTo].
    //
    // Window semantics differ on purpose (v1): trend buckets are half-open
    // UTC months ([monthStart, nextMonthStart)) while profitLoss treats its
    // `to` bound inclusively (`occurredAt <= to`). A transaction at exactly
    // `trendTo` therefore counts toward profitLoss but falls outside every
    // trend bucket. Practical impact is nil for v1 (the boundary instant is
    // an exact month-start midnight); when P&L switches to half-open
    // intervals, remove this divergence.
    test('GOLDEN: monthly trend totals equal accounting profitLoss', () async {
      await seedTransaction(
        type: TransactionType.income,
        occurredAt: DateTime.utc(2026, 5, 10),
        amountCents: 30000,
      );
      await seedTransaction(
        type: TransactionType.expense,
        occurredAt: DateTime.utc(2026, 6, 11),
        amountCents: 12000,
      );
      await seedTransaction(
        type: TransactionType.income,
        occurredAt: DateTime.utc(2026, 8, 19),
        amountCents: 8000,
      );

      final summary = await endpoints.dashboard.getSummary(
        sessionA,
        trendMonths: 4,
        asOf: asOf,
        businessId: businessId,
      );
      final report = await endpoints.accounting.profitLoss(
        sessionA,
        summary.trendFrom,
        summary.trendTo,
        businessId: businessId,
      );

      final trendIncome = summary.monthlyTrend.fold<int>(
        0,
        (sum, p) => sum + p.incomeCents,
      );
      final trendExpense = summary.monthlyTrend.fold<int>(
        0,
        (sum, p) => sum + p.expenseCents,
      );
      final trendProfit = summary.monthlyTrend.fold<int>(
        0,
        (sum, p) => sum + p.profitCents,
      );

      expect(trendIncome, report.incomeCents);
      expect(trendExpense, report.expenseCents);
      expect(trendProfit, report.profitCents);
      expect(trendProfit, trendIncome - trendExpense);
    });

    test(
      'when limits are out of range then they are clamped to bounds',
      () async {
        await seedTransaction(
          type: TransactionType.income,
          occurredAt: DateTime.utc(2026, 8, 1),
        );
        await seedTransaction(
          type: TransactionType.expense,
          occurredAt: DateTime.utc(2026, 8, 2),
        );

        // 0 and negative snap to the minimum (trend: 1 month, feeds: 1 row).
        final zero = await endpoints.dashboard.getSummary(
          sessionA,
          trendMonths: 0,
          recentLimit: 0,
          asOf: asOf,
          businessId: businessId,
        );
        expect(zero.monthlyTrend, hasLength(1));
        expect(zero.recentTransactions, hasLength(1));

        final negative = await endpoints.dashboard.getSummary(
          sessionA,
          trendMonths: -1,
          recentLimit: -5,
          asOf: asOf,
          businessId: businessId,
        );
        expect(negative.monthlyTrend, hasLength(1));
        expect(negative.recentTransactions, hasLength(1));

        // Huge values snap to the maximum (12 months).
        final huge = await endpoints.dashboard.getSummary(
          sessionA,
          trendMonths: 99,
          recentLimit: 99,
          overdueLimit: 99,
          debtorLimit: 99,
          asOf: asOf,
          businessId: businessId,
        );
        expect(huge.monthlyTrend, hasLength(12));
      },
    );

    test(
      'when receivables are mixed then only open sales invoices count',
      () async {
        // Draft with past due date — excluded by status.
        await seedInvoice(dueDate: DateTime.utc(2026, 7, 31));
        // Cancelled — excluded.
        final cancelled = await seedInvoice(dueDate: DateTime.utc(2026, 7, 30));
        await endpoints.invoice.cancel(
          sessionA,
          cancelled.id!,
          businessId: businessId,
        );

        // Partially paid via a seeded payment — open with remaining 7000.
        final partial = await seedInvoice(
          dueDate: DateTime.utc(2026, 9, 30), // future -> not overdue
          markSent: true,
        );
        await endpoints.payment.record(
          sessionA,
          RecordPaymentRequest(invoiceId: partial.id!, amountCents: 3000),
          businessId: businessId,
        );

        // Sent with past due date — overdue even before the hourly job runs.
        final pastDue = await seedInvoice(
          dueDate: DateTime.utc(2026, 7, 15),
          markSent: true,
        );

        // Sent without due date — open but never overdue.
        await seedInvoice(markSent: true);

        final summary = await endpoints.dashboard.getSummary(
          sessionA,
          asOf: asOf,
          businessId: businessId,
        );

        // Invoice totals are gross (default standard VAT): 10000 -> 11900.
        expect(summary.receivables.openInvoicesCount, 3);
        expect(summary.receivables.openTotalCents, 8900 + 11900 + 11900);
        expect(summary.receivables.overdueCount, 1);
        expect(summary.receivables.overdueTotalCents, 11900);
        expect(summary.receivables.overdueInvoices.single.id, pastDue.id!);
      },
    );

    test(
      'when customers owe different amounts then debtors group and sort',
      () async {
        final kundeEins = await endpoints.customer.create(
          sessionA,
          CreateCustomerRequest(name: 'Kunde Eins'),
          businessId: businessId,
        );
        final zweiGmbh = await endpoints.customer.create(
          sessionA,
          CreateCustomerRequest(name: 'Zwei GmbH'),
          businessId: businessId,
        );
        final verschwunden = await endpoints.customer.create(
          sessionA,
          CreateCustomerRequest(name: 'Verschwunden'),
          businessId: businessId,
        );
        // Nameless customer (empty personal AND company name) — seeded via
        // the DB because the endpoint rejects empty names. Must surface as
        // `null` in the summary, never as ''.
        final anonym = await Customer.db.insertRow(
          sessionA.build(),
          Customer(businessId: businessId, name: '', companyName: ''),
        );

        await seedInvoice(
          customerId: kundeEins.id,
          dueDate: DateTime.utc(2026, 9, 1),
          unitPriceCents: 5000,
          markSent: true,
        );
        // Overdue invoice anchors the oldestDueDate of Kunde Eins.
        await seedInvoice(
          customerId: kundeEins.id,
          dueDate: DateTime.utc(2026, 7, 20),
          unitPriceCents: 3000,
          markSent: true,
        );
        await seedInvoice(
          customerId: zweiGmbh.id,
          dueDate: DateTime.utc(2026, 9, 15),
          unitPriceCents: 9000,
          markSent: true,
        );
        // Customer will be deleted below -> SetNull detaches the invoice.
        await seedInvoice(
          customerId: verschwunden.id,
          dueDate: DateTime.utc(2026, 9, 10),
          unitPriceCents: 1000,
          markSent: true,
        );
        // Nameless customer still owes money — group must exist with a
        // null name (fallback on the client), not an empty string.
        await seedInvoice(
          customerId: anonym.id,
          dueDate: DateTime.utc(2026, 9, 5),
          unitPriceCents: 1000,
          markSent: true,
        );
        final db = sessionA.build();
        final row = await Customer.db.findById(db, verschwunden.id!);
        await Customer.db.deleteRow(db, row!);

        final summary = await endpoints.dashboard.getSummary(
          sessionA,
          asOf: asOf,
          businessId: businessId,
        );

        final debtors = summary.receivables.debtors;
        // Gross amounts (standard VAT): 5000->5950, 3000->3570, 9000->10710,
        // 1000->1190.
        expect(debtors.map((d) => d.customerName).toList(), [
          'Zwei GmbH', // 10710
          'Kunde Eins', // 9520
          null, // nameless customer row ("no name" — never '')
          null, // deleted customer group ("no customer")
        ]);
        expect(debtors[0].openTotalCents, 10710);
        expect(debtors[1].openTotalCents, 9520);
        expect(debtors[1].overdueTotalCents, 3570);
        expect(debtors[1].oldestDueDate, DateTime.utc(2026, 7, 20));
        expect(debtors[1].openCount, 2);
        expect(debtors[2].customerId, anonym.id);
        expect(debtors[2].openTotalCents, 1190);
        expect(debtors[3].customerId, isNull);
        expect(debtors[3].openTotalCents, 1190);

        final limited = await endpoints.dashboard.getSummary(
          sessionA,
          debtorLimit: 1,
          asOf: asOf,
          businessId: businessId,
        );
        expect(limited.receivables.debtors.single.customerName, 'Zwei GmbH');
      },
    );

    test(
      'when feeds are requested then order, limits and names are right',
      () async {
        final project = await endpoints.project.create(
          sessionA,
          CreateProjectRequest(name: 'Projekt Alpha'),
          businessId: businessId,
        );
        final task = await endpoints.task.create(
          sessionA,
          CreateTaskRequest(projectId: project.id!, name: 'Design'),
          businessId: businessId,
        );

        final withNames = await endpoints.timeEntry.create(
          sessionA,
          CreateTimeEntryRequest(
            projectId: project.id,
            taskId: task.id,
            startedAt: DateTime.utc(2026, 8, 1, 9),
            durationMinutes: 60,
          ),
          businessId: businessId,
        );
        await endpoints.timeEntry.create(
          sessionA,
          CreateTimeEntryRequest(
            startedAt: DateTime.utc(2026, 8, 2, 9),
            durationMinutes: 30,
            billable: false,
          ),
          businessId: businessId,
        );
        final latest = await endpoints.timeEntry.create(
          sessionA,
          CreateTimeEntryRequest(
            startedAt: DateTime.utc(2026, 8, 3, 9),
            durationMinutes: 90,
          ),
          businessId: businessId,
        );
        // The newest feed row is the project-less entry above.
        expect(latest.projectId, isNull);

        final txOld = await seedTransaction(
          type: TransactionType.income,
          occurredAt: DateTime.utc(2026, 8, 1),
          amountCents: 1000,
        );
        final txNew = await seedTransaction(
          type: TransactionType.expense,
          occurredAt: DateTime.utc(2026, 8, 4),
          amountCents: 2000,
        );

        var summary = await endpoints.dashboard.getSummary(
          sessionA,
          asOf: asOf,
          businessId: businessId,
        );

        // KPI minutes cover the current (partial) month; running timers excluded.
        expect(summary.kpis.totalMinutes, 180);
        expect(summary.kpis.billableMinutes, 150);
        expect(summary.kpis.roundedMinutes, 180);

        // Feeds are DESC by their natural date.
        final entryStarts = summary.recentTimeEntries
            .map((e) => e.startedAt)
            .toList();
        expect(
          entryStarts,
          orderedEquals(entryStarts.toList()..sort((a, b) => b.compareTo(a))),
        );
        final resolved = summary.recentTimeEntries.firstWhere(
          (e) => e.id == withNames.id!,
        );
        expect(resolved.projectName, 'Projekt Alpha');
        expect(resolved.taskName, 'Design');

        // A running timer appears in the feed ...
        final running = await endpoints.timeEntry.startTimer(
          sessionA,
          StartTimerRequest(),
          businessId: businessId,
        );
        expect(running.stoppedAt, isNull);

        summary = await endpoints.dashboard.getSummary(
          sessionA,
          asOf: asOf,
          businessId: businessId,
        );
        final feedRunning = summary.recentTimeEntries.firstWhere(
          (e) => e.id == running.id!,
        );
        expect(feedRunning.durationMinutes, isNull);
        // ... but contributes nothing to the minutes KPIs.
        expect(summary.kpis.totalMinutes, 180);
        expect(summary.kpis.billableMinutes, 150);

        await endpoints.timeEntry.stopTimer(sessionA, businessId: businessId);

        // Limits cap every feed.
        final limited = await endpoints.dashboard.getSummary(
          sessionA,
          recentLimit: 2,
          asOf: asOf,
          businessId: businessId,
        );
        expect(limited.recentTimeEntries, hasLength(2));
        expect(limited.recentTransactions, hasLength(2));
        // Transaction feed is DESC by occurredAt.
        expect(
          limited.recentTransactions.map((t) => t.id).toList(),
          [txNew.id, txOld.id],
        );
      },
    );

    test(
      'when only a credit note exists then receivables stay empty',
      () async {
        await seedInvoice(
          type: InvoiceType.creditNote,
          dueDate: DateTime.utc(2026, 7, 1),
          markSent: true,
        );

        final summary = await endpoints.dashboard.getSummary(
          sessionA,
          asOf: asOf,
          businessId: businessId,
        );

        // Follow-up: credit notes are not compensated server-side yet — they
        // must never inflate receivables until netting exists.
        expect(summary.receivables.openInvoicesCount, 0);
        expect(summary.receivables.openTotalCents, 0);
        expect(summary.receivables.debtors, isEmpty);
      },
    );

    test('when asOf moves then windows move with it', () async {
      await seedTransaction(
        type: TransactionType.income,
        occurredAt: DateTime.utc(2026, 7, 10),
        amountCents: 11100,
      );
      await seedTransaction(
        type: TransactionType.income,
        occurredAt: DateTime.utc(2027, 2, 10),
        amountCents: 22200,
      );

      final augustView = await endpoints.dashboard.getSummary(
        sessionA,
        trendMonths: 3,
        asOf: asOf,
        businessId: businessId,
      );
      expect(
        augustView.monthlyTrend.map((p) => p.monthStart).toList(),
        [DateTime.utc(2026, 6), DateTime.utc(2026, 7), DateTime.utc(2026, 8)],
      );
      final julyPoint = augustView.monthlyTrend[1];
      expect(julyPoint.incomeCents, 11100);
      expect(augustView.trendTo, DateTime.utc(2026, 9));
      expect(augustView.asOf, asOf);

      // Anchoring earlier drops July from every window.
      final juneView = await endpoints.dashboard.getSummary(
        sessionA,
        trendMonths: 1,
        asOf: DateTime.utc(2026, 6, 15),
        businessId: businessId,
      );
      expect(juneView.monthlyTrend.single.incomeCents, 0);
      expect(juneView.kpis.incomeCents, 0);
      expect(juneView.trendFrom, DateTime.utc(2026, 6));
    });
  });
}
