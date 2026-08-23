import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/reminder_gateway.dart';

@Singleton(as: ReminderGateway)
class ServerpodReminderGateway implements ReminderGateway {
  @override
  Future<Reminder> create(
    Session session,
    Reminder reminder, {
    Transaction? transaction,
  }) {
    return Reminder.db.insertRow(session, reminder, transaction: transaction);
  }

  @override
  Future<List<Reminder>> findByInvoiceId(Session session, int invoiceId) {
    return Reminder.db.find(
      session,
      where: (t) => t.invoiceId.equals(invoiceId),
      orderBy: (t) => t.sentAt,
    );
  }

  @override
  Future<List<Reminder>> findByInvoiceIds(
    Session session,
    List<int> invoiceIds,
  ) {
    if (invoiceIds.isEmpty) return Future.value(const []);
    // `sentAt` matches the per-invoice ordering of [findByInvoiceId]; the id
    // tiebreak keeps the result deterministic for identical timestamps.
    return Reminder.db.find(
      session,
      where: (t) => t.invoiceId.inSet(invoiceIds.toSet()),
      orderByList: (t) => [t.sentAt.asc(), t.id.asc()],
    );
  }
}
