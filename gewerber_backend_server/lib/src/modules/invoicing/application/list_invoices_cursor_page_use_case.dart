import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/pagination/cursor.dart';
import '../../../core/pagination/list_limits.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';

/// Keyset-paginated variant of [ListInvoicesPageUseCase] for large lists.
///
/// Instead of `offset` the client passes back the opaque
/// [InvoiceCursorPage.nextCursor] of the previous page (`null` = first page).
/// The stable total order is `issueDate DESC, id DESC`; a cursor must only be
/// used with the same filters it was issued with. Cursors are tenant-scoped:
/// one minted for another business is rejected with a [ValidationException]
/// (field `cursor`) — as is any malformed or tampered cursor.
///
/// No total count is computed — keyset pagination stays O(page size)
/// regardless of table size. A `nextCursor` of `null` marks the end.
@singleton
class ListInvoicesCursorPageUseCase {
  ListInvoicesCursorPageUseCase(this._tenantResolver, this._invoices);

  final TenantResolver _tenantResolver;
  final InvoiceGateway _invoices;

  Future<InvoiceCursorPage> call(
    Session session, {
    InvoiceStatus? status,
    int? limit,
    String? cursor,
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final effectiveLimit = clampListLimit(limit);

    final position = decodeListCursor(cursor);
    // Cursors are minted per tenant and never cross tenant boundaries. A
    // foreign cursor is rejected instead of being silently answered with an
    // empty page so client bugs (wrong tenant/business context) surface
    // immediately.
    if (position != null && position.businessId != tenant.businessId) {
      throw ValidationException(
        message:
            'This pagination cursor was issued for another business and '
            'cannot be used here.',
        field: 'cursor',
      );
    }

    final beforeIssueDate = position == null
        ? null
        : decodeCursorSortDate(position);

    // One extra row detects whether another page follows without an extra
    // count query.
    final fetched = await _invoices.findPageBefore(
      session,
      businessId: tenant.businessId,
      status: status,
      beforeIssueDate: beforeIssueDate,
      beforeId: position?.lastId,
      limit: effectiveLimit + 1,
    );
    final hasMore = fetched.length > effectiveLimit;
    final items = hasMore ? fetched.sublist(0, effectiveLimit) : fetched;

    String? nextCursor;
    if (hasMore && items.isNotEmpty) {
      final last = items.last;
      nextCursor = encodeListCursor(
        businessId: tenant.businessId,
        lastId: last.id!,
        sortValue: last.issueDate.toUtc().toIso8601String(),
      );
    }

    return InvoiceCursorPage(
      items: items,
      nextCursor: nextCursor,
      limit: effectiveLimit,
    );
  }
}
