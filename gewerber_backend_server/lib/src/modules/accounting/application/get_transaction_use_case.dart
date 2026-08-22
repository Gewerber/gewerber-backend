import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/transaction_gateway.dart';

@singleton
class GetTransactionUseCase {
  GetTransactionUseCase(this._tenantResolver, this._transactions);

  final TenantResolver _tenantResolver;
  final TransactionGateway _transactions;

  Future<AccountingTransaction> call(
    Session session,
    int transactionId, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final transaction = await _transactions.findById(session, transactionId);
    if (transaction == null || transaction.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'AccountingTransaction',
        entityId: '$transactionId',
      );
    }
    return transaction;
  }
}
