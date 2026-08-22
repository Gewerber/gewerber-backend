import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/transaction_categories.dart';
import '../domain/transaction_gateway.dart';
import '../domain/transaction_reference_validator.dart';

@singleton
class CreateTransactionUseCase {
  CreateTransactionUseCase(
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
    CreateTransactionRequest request, {
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    validateBasics(request.type, request.category, request.amountCents);
    await _references.validate(
      session,
      tenant.businessId,
      receiptDocumentId: request.receiptDocumentId,
      relatedInvoiceId: request.relatedInvoiceId,
    );

    final transaction = await _transactions.create(
      session,
      AccountingTransaction(
        businessId: tenant.businessId,
        type: request.type,
        category: request.category,
        description: request.description,
        occurredAt: request.occurredAt,
        amountCents: request.amountCents,
        receiptDocumentId: request.receiptDocumentId,
        relatedInvoiceId: request.relatedInvoiceId,
      ),
    );
    await _audit.log(
      session,
      action: 'transaction.create',
      entityType: 'AccountingTransaction',
      entityId: '${transaction.id}',
      tenant: tenant,
    );
    return transaction;
  }

  static void validateBasics(
    TransactionType type,
    TransactionCategory category,
    int amountCents,
  ) {
    if (amountCents <= 0) {
      throw ValidationException(
        message: 'Amount must be positive.',
        field: 'amountCents',
      );
    }
    if (!TransactionCategories.matches(type, category)) {
      throw ValidationException(
        message: 'Category does not match the transaction type.',
        field: 'category',
      );
    }
  }
}
