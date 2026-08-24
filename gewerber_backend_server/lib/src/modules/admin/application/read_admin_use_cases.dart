import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/admin_business_gateway.dart';
import '../domain/admin_cursor.dart';
import '../domain/admin_directory_gateway.dart';
import '../domain/admin_invoice_gateway.dart';
import '../domain/admin_list_limits.dart';

@singleton
class SearchAdminBusinessesUseCase {
  const SearchAdminBusinessesUseCase(this._businesses);

  final AdminBusinessGateway _businesses;

  /// Keyset-paginated by id (`{'i': ...}`).
  Future<AdminBusinessPage> call(
    Session session, {
    String? query,
    int? limit,
    String? cursor,
  }) async {
    final effectiveLimit = clampAdminListLimit(limit);
    final afterId = cursorInt(decodeAdminCursor(cursor), 'i');

    final rows = await _businesses.searchBusinesses(
      session,
      query: query,
      afterId: afterId,
      limit: effectiveLimit + 1,
    );

    final hasMore = rows.length > effectiveLimit;
    final items = hasMore ? rows.sublist(0, effectiveLimit) : rows;

    return AdminBusinessPage(
      items: items,
      nextCursor: hasMore && items.isNotEmpty
          ? encodeAdminCursor({'i': items.last.id!})
          : null,
      limit: effectiveLimit,
    );
  }
}

/// Loads one business with all memberships (admin view, cross-tenant).
@singleton
class GetAdminBusinessUseCase {
  const GetAdminBusinessUseCase(this._businesses);

  final AdminBusinessGateway _businesses;

  Future<AdminBusinessDetail> call(Session session, int businessId) {
    return _businesses.getBusiness(session, businessId);
  }
}

@singleton
class ListAdminInvoicesUseCase {
  const ListAdminInvoicesUseCase(this._invoices);

  final AdminInvoiceGateway _invoices;

  /// Keyset-paginated by `issueDate DESC, id DESC`; the cursor carries the
  /// last row's issue date and id (`{'d': isoDate, 'i': id}`).
  Future<AdminInvoicePage> call(
    Session session, {
    int? businessId,
    InvoiceStatus? status,
    DateTime? from,
    DateTime? to,
    int? limit,
    String? cursor,
  }) async {
    final effectiveLimit = clampAdminListLimit(limit);
    final position = decodeAdminCursor(cursor);

    final rows = await _invoices.listInvoices(
      session,
      businessId: businessId,
      status: status,
      fromIssueDate: from,
      toIssueDate: to,
      beforeIssueDate: _cursorDate(position),
      beforeId: cursorInt(position, 'i'),
      limit: effectiveLimit + 1,
    );

    final hasMore = rows.length > effectiveLimit;
    final items = hasMore ? rows.sublist(0, effectiveLimit) : rows;
    final last = items.isEmpty ? null : items.last;

    return AdminInvoicePage(
      items: items,
      nextCursor: hasMore && last != null
          ? encodeAdminCursor({
              'd': last.issueDate.toUtc().toIso8601String(),
              'i': last.id!,
            })
          : null,
      limit: effectiveLimit,
    );
  }

  DateTime? _cursorDate(Map<String, Object?>? position) {
    final value = cursorString(position, 'd');
    if (value == null) return null;
    try {
      return DateTime.parse(value).toUtc();
    } on FormatException {
      throw ValidationException(
        message: 'Malformed pagination cursor.',
        field: 'cursor',
      );
    }
  }
}

/// Loads a single invoice across tenants.
@singleton
class GetAdminInvoiceUseCase {
  const GetAdminInvoiceUseCase(this._invoices);

  final AdminInvoiceGateway _invoices;

  Future<Invoice> call(Session session, int invoiceId) async {
    final invoice = await _invoices.findById(session, invoiceId);
    if (invoice == null) {
      throw NotFoundException(entityType: 'Invoice', entityId: '$invoiceId');
    }
    return invoice;
  }
}

/// Loads the dossier of one user (support view).
@singleton
class GetUserDossierUseCase {
  const GetUserDossierUseCase(this._directory);

  final AdminDirectoryGateway _directory;

  Future<AdminUserDossier> call(Session session, UuidValue userId) {
    return _directory.getUserDossier(session, userId);
  }
}
