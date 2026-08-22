import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/business_scoped_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/list_reminders_use_case.dart';
import '../application/send_payment_reminder_use_case.dart';

class ReminderEndpoint extends BusinessScopedEndpoint {
  /// Lists all reminders sent for the invoice, ordered by send date.
  Future<List<Reminder>> list(
    Session session,
    int invoiceId, {
    int? businessId,
  }) {
    return getIt<ListRemindersUseCase>().call(
      session,
      invoiceId,
      businessId: businessId,
    );
  }

  /// Sends a payment reminder to the customer and records it. The reminder
  /// level is incremented on every send and mirrored to the invoice's
  /// `dunningLevel`.
  Future<Reminder> send(
    Session session,
    int invoiceId, {
    int? businessId,
  }) {
    return getIt<SendPaymentReminderUseCase>().call(
      session,
      invoiceId,
      businessId: businessId,
    );
  }
}
