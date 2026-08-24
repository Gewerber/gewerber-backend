import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/admin_invoice_gateway.dart';

@Singleton(as: AdminInvoiceGateway)
class ServerpodAdminInvoiceGateway implements AdminInvoiceGateway {
  const ServerpodAdminInvoiceGateway();

  @override
  Future<List<Invoice>> listInvoices(
    Session session, {
    int? businessId,
    InvoiceStatus? status,
    DateTime? fromIssueDate,
    DateTime? toIssueDate,
    DateTime? beforeIssueDate,
    int? beforeId,
    required int limit,
  }) {
    // Keyset order `issueDate DESC, id DESC` mirrors the tenant listing.
    return Invoice.db.find(
      session,
      where: (t) {
        var expression = Constant.bool(true) as Expression;
        if (businessId != null) {
          expression &= t.businessId.equals(businessId);
        }
        if (status != null) {
          expression &= t.status.equals(status);
        }
        if (fromIssueDate != null) {
          expression &= t.issueDate >= fromIssueDate;
        }
        if (toIssueDate != null) {
          expression &= t.issueDate < toIssueDate.add(const Duration(days: 1));
        }
        if (beforeIssueDate != null && beforeId != null) {
          expression &=
              (t.issueDate < beforeIssueDate) |
              ((t.issueDate.equals(beforeIssueDate)) & (t.id < beforeId));
        }
        return expression;
      },
      orderByList: (t) => [t.issueDate.desc(), t.id.desc()],
      limit: limit,
    );
  }

  @override
  Future<Invoice?> findById(Session session, int invoiceId) {
    return Invoice.db.findById(session, invoiceId);
  }
}
