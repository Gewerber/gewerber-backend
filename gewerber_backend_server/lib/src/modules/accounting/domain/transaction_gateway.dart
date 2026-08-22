import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class TransactionGateway {
  Future<AccountingTransaction> create(
    Session session,
    AccountingTransaction transaction, {
    Transaction? transactionScope,
  });

  Future<AccountingTransaction?> findById(Session session, int id);

  Future<AccountingTransaction> update(
    Session session,
    AccountingTransaction transaction,
  );

  Future<List<AccountingTransaction>> find(
    Session session, {
    required int businessId,
    TransactionType? type,
    TransactionCategory? category,
    DateTime? from,
    DateTime? to,
    int? limit,
    int? offset,
  });

  Future<AccountingTransaction> delete(
    Session session,
    AccountingTransaction transaction,
  );
}
