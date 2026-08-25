import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/invoice_gateway.dart';

@Singleton(as: InvoiceGateway)
class ServerpodInvoiceGateway implements InvoiceGateway {
  @override
  Future<Invoice> create(
    Session session,
    Invoice invoice, {
    Transaction? transaction,
  }) {
    return Invoice.db.insertRow(session, invoice, transaction: transaction);
  }

  @override
  Future<Invoice?> findById(Session session, int id) {
    return Invoice.db.findById(session, id);
  }

  @override
  Future<Invoice?> findByIdForUpdate(
    Session session,
    int id, {
    required Transaction transaction,
  }) {
    return Invoice.db.findById(
      session,
      id,
      lockMode: LockMode.forUpdate,
      transaction: transaction,
    );
  }

  @override
  Future<Invoice> update(
    Session session,
    Invoice invoice, {
    Transaction? transaction,
  }) {
    return Invoice.db.updateRow(session, invoice, transaction: transaction);
  }

  @override
  Future<List<Invoice>> find(
    Session session, {
    required int businessId,
    InvoiceStatus? status,
    DateTime? issueDate,
    int? limit,
    int? offset,
  }) {
    return Invoice.db.find(
      session,
      where: (t) {
        var expression = status == null
            ? t.businessId.equals(businessId)
            : t.businessId.equals(businessId) & t.status.equals(status);
        if (issueDate != null) {
          expression = expression & t.issueDate.equals(issueDate);
        }
        return expression;
      },
      orderByList: (t) => [t.issueDate.desc()],
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<List<Invoice>> findDueRecurring(Session session, DateTime now) {
    return Invoice.db.find(
      session,
      where: (t) =>
          t.nextRecurrenceDate.notEquals(null) & (t.nextRecurrenceDate <= now),
      limit: 100,
    );
  }

  @override
  Future<List<Invoice>> findRecurring(
    Session session, {
    required int businessId,
    int? limit,
    int? offset,
  }) {
    // PostgreSQL sorts NULLs last on ASC, so finished schedules (no next
    // date anymore) come after the upcoming ones.
    return Invoice.db.find(
      session,
      where: (t) =>
          t.businessId.equals(businessId) &
          t.recurrenceInterval.notEquals(null),
      orderByList: (t) => [t.nextRecurrenceDate.asc(), t.id.desc()],
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<List<Invoice>> findOpenOrderedByDueDate(
    Session session, {
    required int businessId,
    required int limit,
  }) {
    // Follow-up: credit notes are not compensated server-side yet — they are
    // excluded from open receivables here until a netting strategy exists.
    return Invoice.db.find(
      session,
      where: (t) =>
          t.businessId.equals(businessId) &
          t.type.equals(InvoiceType.invoice) &
          (t.status.equals(InvoiceStatus.sent) |
              t.status.equals(InvoiceStatus.partiallyPaid) |
              t.status.equals(InvoiceStatus.overdue)),
      orderByList: (t) => [t.dueDate.asc(), t.id.asc()],
      limit: limit,
    );
  }

  @override
  Future<List<Invoice>> findPageBefore(
    Session session, {
    required int businessId,
    InvoiceStatus? status,
    DateTime? beforeIssueDate,
    int? beforeId,
    required int limit,
  }) {
    return Invoice.db.find(
      session,
      where: (t) {
        var expression = t.businessId.equals(businessId);
        if (status != null) {
          expression = expression & t.status.equals(status);
        }
        if (beforeIssueDate != null && beforeId != null) {
          // Keyset predicate for the DESC ordering below: everything strictly
          // after the cursor row, with the id as deterministic tiebreak.
          expression =
              expression &
              ((t.issueDate < beforeIssueDate) |
                  (t.issueDate.equals(beforeIssueDate) & (t.id < beforeId)));
        }
        return expression;
      },
      orderByList: (t) => [t.issueDate.desc(), t.id.desc()],
      limit: limit,
    );
  }

  @override
  Future<Map<int, int>> markOverdue(Session session, DateTime now) async {
    // The hourly job has no tenant scope, but a global UPDATE without a
    // `businessId` predicate cannot use the composite
    // `(businessId, status, dueDate)` index efficiently. Instead, iterate the
    // businesses and run one indexed UPDATE per business — same rows are
    // updated as before, just seeked per tenant. The per-business counts let
    // the caller audit the system event with a filled businessId.
    final businesses = await Business.db.find(session);
    final updatedByBusiness = <int, int>{};
    for (final business in businesses) {
      final businessId = business.id;
      if (businessId == null) continue;
      final updated = await Invoice.db.updateWhere(
        session,
        where: (t) =>
            t.businessId.equals(businessId) &
            (t.status.equals(InvoiceStatus.sent) |
                t.status.equals(InvoiceStatus.partiallyPaid)) &
            t.dueDate.notEquals(null) &
            (t.dueDate < now),
        columnValues: (t) => [
          t.status(InvoiceStatus.overdue),
          t.updatedAt(DateTime.now()),
        ],
      );
      if (updated.isNotEmpty) {
        updatedByBusiness[businessId] = updated.length;
      }
    }
    return updatedByBusiness;
  }

  @override
  Future<int> count(
    Session session, {
    required int businessId,
    InvoiceStatus? status,
  }) {
    return Invoice.db.count(
      session,
      where: (t) => status == null
          ? t.businessId.equals(businessId)
          : t.businessId.equals(businessId) & t.status.equals(status),
    );
  }

  @override
  Future<Invoice> delete(
    Session session,
    Invoice invoice, {
    Transaction? transaction,
  }) {
    return Invoice.db.deleteRow(session, invoice, transaction: transaction);
  }
}
