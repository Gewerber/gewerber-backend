import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

/// Cross-tenant read access to invoices for support and moderation.
abstract interface class AdminInvoiceGateway {
  /// Keyset-paginated invoice list ordered by `issueDate DESC, id DESC`,
  /// optionally filtered by tenant, status and issue-date range.
  Future<List<Invoice>> listInvoices(
    Session session, {
    int? businessId,
    InvoiceStatus? status,
    DateTime? fromIssueDate,
    DateTime? toIssueDate,
    DateTime? beforeIssueDate,
    int? beforeId,
    required int limit,
  });

  Future<Invoice?> findById(Session session, int invoiceId);
}
