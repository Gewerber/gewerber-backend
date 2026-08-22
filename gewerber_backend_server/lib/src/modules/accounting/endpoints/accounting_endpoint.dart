import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/business_scoped_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/create_transaction_use_case.dart';
import '../application/delete_transaction_use_case.dart';
import '../application/export_transactions_use_case.dart';
import '../application/get_transaction_use_case.dart';
import '../application/list_transactions_use_case.dart';
import '../application/profit_loss_use_case.dart';
import '../application/update_transaction_use_case.dart';

class AccountingEndpoint extends BusinessScopedEndpoint {
  /// Records an income or expense transaction.
  Future<AccountingTransaction> create(
    Session session,
    CreateTransactionRequest request, {
    int? businessId,
  }) {
    return getIt<CreateTransactionUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  Future<AccountingTransaction> get(
    Session session,
    int transactionId, {
    int? businessId,
  }) {
    return getIt<GetTransactionUseCase>().call(
      session,
      transactionId,
      businessId: businessId,
    );
  }

  Future<AccountingTransaction> update(
    Session session,
    UpdateTransactionRequest request, {
    int? businessId,
  }) {
    return getIt<UpdateTransactionUseCase>().call(
      session,
      request,
      businessId: businessId,
    );
  }

  Future<List<AccountingTransaction>> list(
    Session session, {
    TransactionType? type,
    TransactionCategory? category,
    DateTime? from,
    DateTime? to,
    int? limit,
    int? offset,
    int? businessId,
  }) {
    return getIt<ListTransactionsUseCase>().call(
      session,
      type: type,
      category: category,
      from: from,
      to: to,
      limit: limit,
      offset: offset,
      businessId: businessId,
    );
  }

  Future<void> delete(
    Session session,
    int transactionId, {
    int? businessId,
  }) {
    return getIt<DeleteTransactionUseCase>().call(
      session,
      transactionId,
      businessId: businessId,
    );
  }

  /// Basic profit & loss (EÜR style) for the period.
  Future<ProfitLossReport> profitLoss(
    Session session,
    DateTime from,
    DateTime to, {
    int? businessId,
  }) {
    return getIt<ProfitLossUseCase>().call(
      session,
      from: from,
      to: to,
      businessId: businessId,
    );
  }

  /// Exports transactions as CSV.
  Future<String> exportCsv(
    Session session, {
    TransactionType? type,
    DateTime? from,
    DateTime? to,
    int? businessId,
  }) {
    return getIt<ExportTransactionsUseCase>().call(
      session,
      type: type,
      from: from,
      to: to,
      businessId: businessId,
    );
  }
}
