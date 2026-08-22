import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/transaction_gateway.dart';

@Singleton(as: TransactionGateway)
class ServerpodTransactionGateway implements TransactionGateway {
  @override
  Future<AccountingTransaction> create(
    Session session,
    AccountingTransaction transaction, {
    Transaction? transactionScope,
  }) {
    return AccountingTransaction.db.insertRow(
      session,
      transaction,
      transaction: transactionScope,
    );
  }

  @override
  Future<AccountingTransaction?> findById(Session session, int id) {
    return AccountingTransaction.db.findById(session, id);
  }

  @override
  Future<AccountingTransaction> update(
    Session session,
    AccountingTransaction transaction,
  ) {
    return AccountingTransaction.db.updateRow(session, transaction);
  }

  @override
  Future<List<AccountingTransaction>> find(
    Session session, {
    required int businessId,
    TransactionType? type,
    TransactionCategory? category,
    DateTime? from,
    DateTime? to,
    int? limit,
    int? offset,
  }) {
    return AccountingTransaction.db.find(
      session,
      where: (t) {
        var expression = t.businessId.equals(businessId);
        if (type != null) {
          expression = expression & t.type.equals(type);
        }
        if (category != null) {
          expression = expression & t.category.equals(category);
        }
        if (from != null) {
          expression = expression & (t.occurredAt >= from);
        }
        if (to != null) {
          expression = expression & (t.occurredAt <= to);
        }
        return expression;
      },
      orderByList: (t) => [t.occurredAt.desc()],
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<AccountingTransaction> delete(
    Session session,
    AccountingTransaction transaction,
  ) {
    return AccountingTransaction.db.deleteRow(session, transaction);
  }
}
