import 'dart:math' as math;

import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../../accounting/domain/transaction_gateway.dart';
import '../../business/domain/business_settings_gateway.dart';
import '../../invoicing/domain/customer_gateway.dart';
import '../../invoicing/domain/invoice_gateway.dart';
import '../../invoicing/domain/payment_record_gateway.dart';
import '../../time_tracking/domain/project_gateway.dart';
import '../../time_tracking/domain/task_gateway.dart';
import '../../time_tracking/domain/time_entry_gateway.dart';
import '../../time_tracking/domain/time_rounding.dart';
import '../domain/month_bucketing.dart';

/// Builds the tenant-scoped dashboard summary.
///
/// Architect decisions (v1) — fixed here so callers can rely on them:
/// - Monthly trend buckets are computed in **UTC** (see `month_bucketing`);
///   locale-aware month boundaries are deliberately out of scope for v1.
/// - [asOf] is an escape hatch for deterministic tests; production callers
///   omit it so everything anchors at "now".
/// - Receivables consider **sales invoices only** (`type == invoice`);
///   credit notes are not compensated server-side yet, so they neither reduce
///   open totals nor appear in receivables (follow-up issue pending).
/// - v1 limitation: open-receivable totals/count are derived from at most
///   [_maxOpenInvoices] oldest-due invoices; a business exceeding that cap
///   under-reports its receivables.
///
/// Query budget: a constant number of hard-capped queries (~12 incl. batched
/// name lookups), independent of data volume — no N+1.
@singleton
class GetDashboardSummaryUseCase {
  GetDashboardSummaryUseCase(
    this._tenantResolver,
    this._settings,
    this._transactions,
    this._invoices,
    this._payments,
    this._customers,
    this._entries,
    this._projects,
    this._tasks,
  );

  static const int defaultTrendMonths = 6;
  static const int minTrendMonths = 1;
  static const int maxTrendMonths = 12;
  static const int defaultRecentLimit = 5;
  static const int maxRecentLimit = 50;
  static const int defaultOverdueLimit = 20;
  static const int maxOverdueLimit = 100;
  static const int defaultDebtorLimit = 10;
  static const int maxDebtorLimit = 50;

  /// Hard cap for the open-receivables fetch (`ORDER BY dueDate ASC`), see
  /// the v1 limitation note above.
  static const int _maxOpenInvoices = 500;

  /// Matches the P&L row cap so bucket aggregation cannot silently diverge
  /// from [ProfitLossReport] semantics on huge datasets.
  static const int _maxTransactions = 10000;
  static const int _maxTimeEntries = 10000;

  final TenantResolver _tenantResolver;
  final BusinessSettingsGateway _settings;
  final TransactionGateway _transactions;
  final InvoiceGateway _invoices;
  final PaymentRecordGateway _payments;
  final CustomerGateway _customers;
  final TimeEntryGateway _entries;
  final ProjectGateway _projects;
  final TaskGateway _tasks;

  /// Snaps a client-provided count onto its bounds: absent values fall back
  /// to [fallback], everything below [min]/above [max] is clamped to the
  /// nearest boundary (so `0`, `-1` and huge numbers all stay safe).
  static int _clamp(int? value, int fallback, int min, int max) =>
      math.min(max, math.max(min, value ?? fallback));

  Future<DashboardSummary> call(
    Session session, {
    int? trendMonths,
    int? recentLimit,
    int? overdueLimit,
    int? debtorLimit,
    DateTime? asOf,
    int? businessId,
  }) async {
    // 1. Tenant (member read access; a foreign businessId -> Forbidden).
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );

    final now = (asOf ?? DateTime.now()).toUtc();
    final months = _clamp(
      trendMonths,
      defaultTrendMonths,
      minTrendMonths,
      maxTrendMonths,
    );
    final feedLimit = _clamp(
      recentLimit,
      defaultRecentLimit,
      1,
      maxRecentLimit,
    );
    final overdueCap = _clamp(
      overdueLimit,
      defaultOverdueLimit,
      1,
      maxOverdueLimit,
    );
    final debtorCap = _clamp(
      debtorLimit,
      defaultDebtorLimit,
      1,
      maxDebtorLimit,
    );

    final bucketStarts = lastUtcMonthStarts(now, months);
    final trendFrom = bucketStarts.first;
    final trendTo = utcMonthEnd(bucketStarts.last);
    final currentMonthStart = bucketStarts.last;

    // 2. Business rounding rules (same semantics as timeEntry.report).
    final settings = await _settings.findByBusinessId(
      session,
      tenant.businessId,
    );
    final roundingMode = settings?.roundingMode ?? RoundingMode.none;
    final granularity = settings?.roundingGranularityMinutes ?? 1;

    // 3. Transactions of the whole trend window, capped like profitLoss. The
    //    gateway's upper bound is inclusive; half-open bucket windows are
    //    enforced during aggregation below.
    final windowTransactions = await _transactions.find(
      session,
      businessId: tenant.businessId,
      from: trendFrom,
      to: trendTo,
      limit: _maxTransactions,
      offset: 0,
    );

    // 4. Open receivables: sales invoices with outstanding money, oldest due
    //    first. Credit notes are excluded on purpose (see class doc).
    final openInvoices = await _invoices.findOpenOrderedByDueDate(
      session,
      businessId: tenant.businessId,
      limit: _maxOpenInvoices,
    );

    // 5. One batched payments lookup for every open invoice.
    final paymentsByInvoice = await _loadPayments(session, openInvoices);

    // Batched name lookups (single query each, regardless of feed size).
    final debtorIds = openInvoices
        .map((invoice) => invoice.customerId)
        .whereType<int>()
        .toSet();
    final customersById = debtorIds.isEmpty
        ? const <int, Customer>{}
        : {
            for (final customer in await _customers.findByIds(
              session,
              debtorIds,
            ))
              customer.id!: customer,
          };

    // 6-8. Recent-activity feeds (independent, constant-bounded).
    final recentInvoicesFuture = _invoices.findPageBefore(
      session,
      businessId: tenant.businessId,
      limit: feedLimit,
    );
    final recentTransactionsFuture = _transactions.find(
      session,
      businessId: tenant.businessId,
      limit: feedLimit,
      offset: 0,
    );
    final recentEntriesFuture = _entries.find(
      session,
      businessId: tenant.businessId,
      limit: feedLimit,
      offset: 0,
    );
    // KPI minutes need *all* stopped entries of the current month, which the
    // capped feed cannot guarantee — one extra bounded range query.
    final monthEntriesFuture = _entries.find(
      session,
      businessId: tenant.businessId,
      from: currentMonthStart,
      to: trendTo,
      limit: _maxTimeEntries,
      offset: 0,
    );

    final recentInvoices = await recentInvoicesFuture;
    final recentTransactions = await recentTransactionsFuture;
    final recentEntries = await recentEntriesFuture;
    final monthEntries = await monthEntriesFuture;

    final projectNames = await _projectNames(
      session,
      tenant.businessId,
      [...recentEntries, ...monthEntries],
    );
    final taskNames = await _taskNames(
      session,
      tenant.businessId,
      [...recentEntries, ...monthEntries],
    );

    return DashboardSummary(
      generatedAt: DateTime.now().toUtc(),
      asOf: now,
      trendFrom: trendFrom,
      trendTo: trendTo,
      kpis: _buildKpis(
        transactions: windowTransactions,
        entries: monthEntries,
        currentMonthStart: currentMonthStart,
        trendTo: trendTo,
        roundingMode: roundingMode,
        granularityMinutes: granularity,
      ),
      monthlyTrend: _buildTrend(
        transactions: windowTransactions,
        bucketStarts: bucketStarts,
      ),
      recentInvoices: recentInvoices,
      recentTransactions: recentTransactions,
      recentTimeEntries: [
        for (final entry in recentEntries)
          RecentTimeEntry(
            id: entry.id!,
            startedAt: entry.startedAt,
            stoppedAt: entry.stoppedAt,
            durationMinutes: entry.durationMinutes,
            billable: entry.billable,
            projectId: entry.projectId,
            projectName: entry.projectId == null
                ? null
                : projectNames[entry.projectId],
            taskId: entry.taskId,
            taskName: entry.taskId == null ? null : taskNames[entry.taskId],
          ),
      ],
      receivables: _buildReceivables(
        openInvoices: openInvoices,
        paymentsByInvoice: paymentsByInvoice,
        customersById: customersById,
        asOf: now,
        overdueCap: overdueCap,
        debtorCap: debtorCap,
      ),
    );
  }

  Future<Map<int, List<PaymentRecord>>> _loadPayments(
    Session session,
    List<Invoice> invoices,
  ) async {
    if (invoices.isEmpty) return const {};
    final ids = invoices.map((invoice) => invoice.id!).toList();
    final records = await _payments.findByInvoiceIds(session, ids);
    final byInvoice = <int, List<PaymentRecord>>{};
    for (final record in records) {
      byInvoice.putIfAbsent(record.invoiceId, () => []).add(record);
    }
    return byInvoice;
  }

  /// Remaining amount per invoice: `totalCents − paid`, never below zero.
  static int _remainingCents(
    Invoice invoice,
    Map<int, List<PaymentRecord>> paymentsByInvoice,
  ) {
    final paid =
        paymentsByInvoice[invoice.id]?.fold<int>(
          0,
          (sum, record) => sum + record.amountCents,
        ) ??
        0;
    return math.max(0, invoice.totalCents - paid);
  }

  /// Customer display name: personal name before company name. `null` means
  /// "no displayable name" — either no customer row (deleted rows detach via
  /// SetNull) or a customer with neither personal nor company name; clients
  /// render their own fallback label for it. An empty string never escapes:
  /// a nameless customer folds into `null` just like a missing one.
  static String? _customerName(int? customerId, Map<int, Customer> customers) {
    if (customerId == null) return null;
    final customer = customers[customerId];
    if (customer == null) return null;
    final resolved = customer.name.isNotEmpty
        ? customer.name
        : customer.companyName;
    if (resolved == null || resolved.isEmpty) return null;
    return resolved;
  }

  ReceivablesSummary _buildReceivables({
    required List<Invoice> openInvoices,
    required Map<int, List<PaymentRecord>> paymentsByInvoice,
    required Map<int, Customer> customersById,
    required DateTime asOf,
    required int overdueCap,
    required int debtorCap,
  }) {
    bool isOverdue(Invoice invoice) =>
        invoice.dueDate != null && invoice.dueDate!.isBefore(asOf);

    final overduePairs = <(Invoice, int)>[];
    var openTotalCents = 0;
    final debtorsById = <int?, _DebtorAccumulator>{};

    for (final invoice in openInvoices) {
      final remaining = _remainingCents(invoice, paymentsByInvoice);
      openTotalCents += remaining;
      if (isOverdue(invoice)) {
        overduePairs.add((invoice, remaining));
      }
      final accumulator = debtorsById.putIfAbsent(
        invoice.customerId,
        _DebtorAccumulator.new,
      );
      accumulator.openCount += 1;
      accumulator.openTotalCents += remaining;
      if (isOverdue(invoice)) {
        accumulator.overdueTotalCents += remaining;
        final dueDate = invoice.dueDate!;
        if (accumulator.oldestDueDate == null ||
            dueDate.isBefore(accumulator.oldestDueDate!)) {
          accumulator.oldestDueDate = dueDate;
        }
      }
    }

    final debtors =
        [
          for (final entry in debtorsById.entries)
            DebtorSummary(
              customerId: entry.key,
              customerName: _customerName(entry.key, customersById),
              openCount: entry.value.openCount,
              openTotalCents: entry.value.openTotalCents,
              overdueTotalCents: entry.value.overdueTotalCents,
              oldestDueDate: entry.value.oldestDueDate,
            ),
        ]..sort((a, b) {
          final byAmount = b.openTotalCents.compareTo(a.openTotalCents);
          if (byAmount != 0) return byAmount;
          // Deterministic tiebreak: known customers by id, the "no customer"
          // group last.
          if (a.customerId == null || b.customerId == null) {
            if (a.customerId == b.customerId) return 0;
            return a.customerId == null ? 1 : -1;
          }
          return a.customerId!.compareTo(b.customerId!);
        });

    return ReceivablesSummary(
      openInvoicesCount: openInvoices.length,
      openTotalCents: openTotalCents,
      overdueCount: overduePairs.length,
      overdueTotalCents: overduePairs.fold<int>(
        0,
        (sum, pair) => sum + pair.$2,
      ),
      debtors: debtors.take(debtorCap).toList(),
      overdueInvoices: overduePairs
          .take(overdueCap)
          .map((pair) => pair.$1)
          .toList(),
    );
  }

  DashboardKpis _buildKpis({
    required List<AccountingTransaction> transactions,
    required List<TimeEntry> entries,
    required DateTime currentMonthStart,
    required DateTime trendTo,
    required RoundingMode roundingMode,
    required int granularityMinutes,
  }) {
    var incomeCents = 0;
    var expenseCents = 0;
    for (final transaction in transactions) {
      // Half-open current-month window (the fetch bound was inclusive).
      if (transaction.occurredAt.isBefore(currentMonthStart) ||
          !transaction.occurredAt.isBefore(trendTo)) {
        continue;
      }
      if (transaction.type == TransactionType.income) {
        incomeCents += transaction.amountCents;
      } else {
        expenseCents += transaction.amountCents;
      }
    }

    var totalMinutes = 0;
    var billableMinutes = 0;
    var roundedMinutes = 0;
    for (final entry in entries) {
      final duration = entry.durationMinutes;
      // Running timers are never part of reports (see GetTimeReportUseCase).
      if (entry.stoppedAt == null || duration == null) continue;
      if (entry.startedAt.isBefore(currentMonthStart) ||
          !entry.startedAt.isBefore(trendTo)) {
        continue;
      }
      totalMinutes += duration;
      if (entry.billable) billableMinutes += duration;
      roundedMinutes += TimeRounding.apply(
        minutes: duration,
        mode: roundingMode,
        granularityMinutes: granularityMinutes,
      );
    }

    return DashboardKpis(
      periodFrom: currentMonthStart,
      periodTo: trendTo,
      incomeCents: incomeCents,
      expenseCents: expenseCents,
      profitCents: incomeCents - expenseCents,
      totalMinutes: totalMinutes,
      billableMinutes: billableMinutes,
      roundedMinutes: roundedMinutes,
    );
  }

  /// Aggregates capped transactions into consecutive UTC monthly buckets.
  /// Buckets with no activity stay at zero so charts remain continuous.
  ///
  /// Window semantics (v1): buckets are half-open UTC months
  /// ([monthStart, nextMonthStart)), whereas the fetch bounds above — and
  /// accounting.profitLoss's inclusive `to` parameter (`occurredAt <= to`) —
  /// are not. A transaction with occurredAt exactly on a bucket end counts
  /// toward profitLoss but drops out of the trend here. Practical impact is
  /// nil for v1 (that boundary instant is an exact month-start midnight);
  /// once P&L switches to half-open intervals, remove this divergence.
  List<MonthlyTrendPoint> _buildTrend({
    required List<AccountingTransaction> transactions,
    required List<DateTime> bucketStarts,
  }) {
    final first = bucketStarts.first;
    final incomes = List<int>.filled(bucketStarts.length, 0);
    final expenses = List<int>.filled(bucketStarts.length, 0);

    for (final transaction in transactions) {
      final occurred = transaction.occurredAt;
      // Consecutive UTC month buckets make the calendar-month distance an
      // exact O(1) bucket index.
      final index =
          (occurred.year - first.year) * 12 + occurred.month - first.month;
      if (index < 0 || index >= bucketStarts.length) continue;
      if (transaction.type == TransactionType.income) {
        incomes[index] += transaction.amountCents;
      } else {
        expenses[index] += transaction.amountCents;
      }
    }

    return [
      for (var i = 0; i < bucketStarts.length; i++)
        MonthlyTrendPoint(
          monthStart: bucketStarts[i],
          incomeCents: incomes[i],
          expenseCents: expenses[i],
          profitCents: incomes[i] - expenses[i],
        ),
    ];
  }

  /// Resolves project display names for feed entries. The ids originate from
  /// tenant-scoped entry queries, yet the lookup re-applies [businessId] as
  /// an IDOR backstop against future callers or corrupt rows.
  Future<Map<int, String>> _projectNames(
    Session session,
    int businessId,
    List<TimeEntry> entries,
  ) async {
    final ids = entries.map((e) => e.projectId).whereType<int>().toSet();
    if (ids.isEmpty) return const {};
    final projects = await _projects.findByIds(
      session,
      ids,
      businessId: businessId,
    );
    return {for (final project in projects) project.id!: project.name};
  }

  /// Resolves task display names for feed entries. See [_projectNames] for
  /// why [businessId] is re-applied here.
  Future<Map<int, String>> _taskNames(
    Session session,
    int businessId,
    List<TimeEntry> entries,
  ) async {
    final ids = entries.map((e) => e.taskId).whereType<int>().toSet();
    if (ids.isEmpty) return const {};
    final tasks = await _tasks.findByIds(session, ids, businessId: businessId);
    return {for (final task in tasks) task.id!: task.name};
  }
}

class _DebtorAccumulator {
  int openCount = 0;
  int openTotalCents = 0;
  int overdueTotalCents = 0;
  DateTime? oldestDueDate;
}
