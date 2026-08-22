import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../domain/invoice_gateway.dart';

/// System job (no tenant scope): marks sent/partially paid invoices whose due
/// date has passed as `overdue`.
@singleton
class MarkOverdueInvoicesUseCase {
  MarkOverdueInvoicesUseCase(this._invoices);

  final InvoiceGateway _invoices;

  Future<int> call(Session session, {DateTime? now}) async {
    final reference = now ?? DateTime.now();
    return _invoices.markOverdue(session, reference);
  }
}
