import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class ReminderGateway {
  Future<Reminder> create(
    Session session,
    Reminder reminder, {
    Transaction? transaction,
  });

  Future<List<Reminder>> findByInvoiceId(Session session, int invoiceId);
}
