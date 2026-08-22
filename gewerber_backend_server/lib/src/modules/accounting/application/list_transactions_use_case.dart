import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/transaction_gateway.dart';

@singleton
class ListTransactionsUseCase {
  ListTransactionsUseCase(this._tenantResolver, this._transactions);

  final TenantResolver _tenantResolver;
  final TransactionGateway _transactions;

  Future<List<AccountingTransaction>> call(
    Session session, {
    TransactionType? type,
    TransactionCategory? category,
    DateTime? from,
    DateTime? to,
    int? limit,
    int? offset,
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    return _transactions.find(
      session,
      businessId: tenant.businessId,
      type: type,
      category: category,
      from: from,
      to: to,
      limit: limit ?? 100,
      offset: offset ?? 0,
    );
  }
}
