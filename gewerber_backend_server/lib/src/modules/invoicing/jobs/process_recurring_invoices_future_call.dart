import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../application/process_recurring_invoices_use_case.dart';

/// Scheduled by [RecurringInvoicesJobScheduler]; materializes due recurring
/// invoices. Runs in its own [FutureCallSession] without user authentication.
class ProcessRecurringInvoicesFutureCall extends FutureCall<SerializableModel> {
  Future<void> process(Session session) async {
    final created = await getIt<ProcessRecurringInvoicesUseCase>()(session);
    session.log('Processed recurring invoices: $created created.');
  }
}
