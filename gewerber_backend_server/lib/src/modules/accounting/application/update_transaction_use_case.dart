import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/transaction_gateway.dart';
import '../domain/transaction_reference_validator.dart';
import 'create_transaction_use_case.dart';

@singleton
class UpdateTransactionUseCase {
  UpdateTransactionUseCase(
    this._tenantResolver,
    this._transactions,
    this._references,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final TransactionGateway _transactions;
  final TransactionReferenceValidator _references;
  final AuditService _audit;

  Future<AccountingTransaction> call(
    Session session,
    UpdateTransactionRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final transaction = await _transactions.findById(
      session,
      request.transactionId,
    );
    if (transaction == null || transaction.businessId != tenant.businessId) {
      throw NotFoundException(
        entityType: 'AccountingTransaction',
        entityId: '${request.transactionId}',
      );
    }

    CreateTransactionUseCase.validateBasics(
      request.type,
      request.category,
      request.amountCents,
    );
    await _references.validate(
      session,
      tenant.businessId,
      receiptDocumentId: request.receiptDocumentId,
      relatedInvoiceId: request.relatedInvoiceId,
    );

    final updated = await _transactions.update(
      session,
      transaction.copyWith(
        type: request.type,
        category: request.category,
        description: request.description,
        occurredAt: request.occurredAt,
        amountCents: request.amountCents,
        receiptDocumentId: request.receiptDocumentId,
        relatedInvoiceId: request.relatedInvoiceId,
        updatedAt: DateTime.now(),
      ),
    );
    await _audit.log(
      session,
      action: 'transaction.update',
      entityType: 'AccountingTransaction',
      entityId: '${updated.id}',
      tenant: tenant,
    );
    return updated;
  }
}
