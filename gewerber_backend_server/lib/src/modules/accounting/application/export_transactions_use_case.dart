import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../../invoicing/domain/money_formatter.dart';
import '../domain/transaction_gateway.dart';

/// Exports accounting transactions as CSV (semicolon-separated, comma
/// decimals).
@singleton
class ExportTransactionsUseCase {
  ExportTransactionsUseCase(this._tenantResolver, this._transactions);

  static const int _maxRows = 10000;

  final TenantResolver _tenantResolver;
  final TransactionGateway _transactions;

  Future<String> call(
    Session session, {
    TransactionType? type,
    DateTime? from,
    DateTime? to,
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final transactions = await _transactions.find(
      session,
      businessId: tenant.businessId,
      type: type,
      from: from,
      to: to,
      limit: _maxRows,
      offset: 0,
    );

    final buffer = StringBuffer()
      ..writeln('Datum;Typ;Kategorie;Beschreibung;Betrag;Währung');
    for (final transaction in transactions) {
      buffer.writeln(
        [
          _formatDate(transaction.occurredAt),
          transaction.type.name,
          transaction.category.name,
          _escapeCsv(transaction.description ?? ''),
          MoneyFormatter.formatCentsDecimal(transaction.amountCents),
          'eur',
        ].join(';'),
      );
    }
    return buffer.toString();
  }

  String _formatDate(DateTime dateTime) {
    final d = dateTime.toLocal();
    final day = d.day.toString().padLeft(2, '0');
    final month = d.month.toString().padLeft(2, '0');
    return '$day.$month.${d.year}';
  }

  String _escapeCsv(String value) {
    if (value.contains(';') || value.contains('"') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }
}
