import '../../../generated/future_calls.dart';

/// Ensures the invoicing background jobs are scheduled exactly once,
/// independent of server restarts or multiple server instances.
///
/// Scheduling is idempotent: any existing call chain under a job identifier
/// is cancelled first, then a fresh recurring chain is registered.
class InvoicingJobScheduler {
  const InvoicingJobScheduler();

  static const String recurringInvoicesIdentifier =
      'process-recurring-invoices';
  static const String markOverdueIdentifier = 'mark-overdue-invoices';

  /// How often invoicing background jobs run.
  static const Duration interval = Duration(hours: 1);

  Future<void> ensureScheduled(FutureCalls futureCalls) async {
    await futureCalls.cancel(recurringInvoicesIdentifier);
    await futureCalls
        .callRecurring(identifier: recurringInvoicesIdentifier)
        .every(interval)
        .processRecurringInvoices
        .process();

    await futureCalls.cancel(markOverdueIdentifier);
    await futureCalls
        .callRecurring(identifier: markOverdueIdentifier)
        .every(interval)
        .markOverdueInvoices
        .process();
  }
}
