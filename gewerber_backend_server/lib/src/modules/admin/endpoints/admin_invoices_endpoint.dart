import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/admin_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/cancel_invoice_as_admin_use_case.dart';
import '../application/read_admin_use_cases.dart';

/// Cross-tenant invoice reads for support plus admin-side cancellation.
class AdminInvoicesEndpoint extends AdminEndpoint {
  /// Keyset-paginated invoice list ordered by `issueDate DESC`, optionally
  /// filtered by tenant, status and issue-date range (`from` inclusive,
  /// `to` inclusive).
  Future<AdminInvoicePage> invoicesList(
    Session session, {
    int? businessId,
    InvoiceStatus? status,
    DateTime? from,
    DateTime? to,
    int? limit,
    String? cursor,
  }) async {
    await requireAdmin(session, minRole: AdminRole.moderator);
    return getIt<ListAdminInvoicesUseCase>().call(
      session,
      businessId: businessId,
      status: status,
      from: from,
      to: to,
      limit: limit,
      cursor: cursor,
    );
  }

  /// A single invoice across tenants.
  Future<Invoice> invoicesGet(Session session, int invoiceId) async {
    await requireAdmin(session, minRole: AdminRole.moderator);
    return getIt<GetAdminInvoiceUseCase>().call(session, invoiceId);
  }

  /// Cancels an invoice in an open state (`sent`, `partiallyPaid`,
  /// `overdue`). Drafts belong to their owners; paid invoices are immutable
  /// (GoBD) — both are rejected with [ConflictException].
  Future<Invoice> invoiceCancelAdmin(
    Session session, {
    required int invoiceId,
    required String reason,
    required bool confirm,
  }) async {
    final actor = await requireAdmin(session, minRole: AdminRole.admin);
    return getIt<CancelInvoiceAsAdminUseCase>().call(
      session,
      actor: actor,
      invoiceId: invoiceId,
      reason: reason,
      confirm: confirm,
    );
  }
}
