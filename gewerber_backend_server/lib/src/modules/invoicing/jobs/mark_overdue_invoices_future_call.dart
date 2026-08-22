import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../application/mark_overdue_invoices_use_case.dart';

/// Scheduled by [InvoicingJobScheduler]; marks invoices past their due date
/// as overdue. Runs in its own [FutureCallSession] without user authentication.
class MarkOverdueInvoicesFutureCall extends FutureCall<SerializableModel> {
  Future<void> process(Session session) async {
    final updated = await getIt<MarkOverdueInvoicesUseCase>()(session);
    session.log('Marked overdue invoices: $updated.');
  }
}
