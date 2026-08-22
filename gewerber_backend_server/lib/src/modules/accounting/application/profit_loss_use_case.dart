import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/transaction_gateway.dart';

/// Basic EÜR-style profit & loss: income minus expenses of the period,
/// broken down by category.
@singleton
class ProfitLossUseCase {
  ProfitLossUseCase(this._tenantResolver, this._transactions);

  static const int _maxRows = 10000;

  final TenantResolver _tenantResolver;
  final TransactionGateway _transactions;

  Future<ProfitLossReport> call(
    Session session, {
    required DateTime from,
    required DateTime to,
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    if (to.isBefore(from)) {
      throw ValidationException(
        message: 'Report start must be before its end.',
        field: 'to',
      );
    }

    final transactions = await _transactions.find(
      session,
      businessId: tenant.businessId,
      from: from,
      to: to,
      limit: _maxRows,
      offset: 0,
    );

    var incomeCents = 0;
    var expenseCents = 0;
    final incomeByCategory = <TransactionCategory, ProfitLossLine>{};
    final expenseByCategory = <TransactionCategory, ProfitLossLine>{};

    for (final transaction in transactions) {
      final target = transaction.type == TransactionType.income
          ? incomeByCategory
          : expenseByCategory;
      if (transaction.type == TransactionType.income) {
        incomeCents += transaction.amountCents;
      } else {
        expenseCents += transaction.amountCents;
      }

      final existing = target[transaction.category];
      target[transaction.category] = ProfitLossLine(
        category: transaction.category,
        amountCents: (existing?.amountCents ?? 0) + transaction.amountCents,
        count: (existing?.count ?? 0) + 1,
      );
    }

    return ProfitLossReport(
      from: from,
      to: to,
      incomeCents: incomeCents,
      expenseCents: expenseCents,
      profitCents: incomeCents - expenseCents,
      incomeLines: incomeByCategory.values.toList(),
      expenseLines: expenseByCategory.values.toList(),
    );
  }
}
