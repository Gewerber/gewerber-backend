import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/entitlement/invoice_quota_policy.dart';
import '../../../core/tenant/tenant_context.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';

/// Shared free-tier invoice quota check for every user-facing invoice
/// creation path (ordinary invoices and server-cloned credit notes).
///
/// Quota is consumed at creation, not at issuance: every created invoice
/// immediately receives a GoBD-safe sequential number, and creation is the
/// single choke point that stops a free account from hoarding numbered
/// drafts. Cancelled rows keep their number, so they keep counting.
///
/// Zero-cost when commercial entitlements are disabled (the OSS default): no
/// capability lookup, no count query, no behavior change.
@singleton
class InvoiceCreationQuotaGuard {
  InvoiceCreationQuotaGuard(this._invoices, this._quotaPolicy);

  final InvoiceGateway _invoices;
  final InvoiceQuotaPolicy _quotaPolicy;

  Future<void> enforce(Session session, TenantContext tenant) async {
    if (!_quotaPolicy.enforcementEnabled) return;

    final limit = await _quotaPolicy.monthlyInvoiceLimit(
      session,
      userId: tenant.userId,
      businessId: tenant.businessId,
    );
    if (limit == null) return; // Unlimited capability granted.

    // Current UTC calendar month; the window is half-open so the boundary
    // day is counted exactly once.
    final now = DateTime.now().toUtc();
    final monthStart = DateTime.utc(now.year, now.month);
    final nextMonthStart = DateTime.utc(now.year, now.month + 1);

    final createdThisMonth = await _invoices.countCreatedBetween(
      session,
      businessId: tenant.businessId,
      createdAfter: monthStart,
      createdBefore: nextMonthStart,
    );
    if (createdThisMonth >= limit) {
      throw InvoiceLimitReachedException(
        message:
            'Monthly invoice limit of $limit reached for the current plan.',
        limit: limit,
      );
    }
  }
}
