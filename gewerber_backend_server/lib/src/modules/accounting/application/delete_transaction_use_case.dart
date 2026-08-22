import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/transaction_gateway.dart';

@singleton
class DeleteTransactionUseCase {
  DeleteTransactionUseCase(
    this._tenantResolver,
    this._transactions,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final TransactionGateway _transactions;
  final AuditService _audit;

  Future<void> call(
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

    await _transactions.delete(session, transaction);
    await _audit.log(
      session,
      action: 'transaction.delete',
      entityType: 'AccountingTransaction',
      entityId: '$transactionId',
      tenant: tenant,
    );
  }
}
