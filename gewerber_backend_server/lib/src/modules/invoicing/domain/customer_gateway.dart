import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class CustomerGateway {
  Future<Customer> create(
    Session session,
    Customer customer, {
    Transaction? transaction,
  });

  Future<Customer?> findById(Session session, int id);

  /// Loads many customers in one query.
  Future<List<Customer>> findByIds(Session session, Set<int> ids);

  Future<Customer> update(Session session, Customer customer);

  Future<List<Customer>> find(
    Session session, {
    required int businessId,
    CustomerStatus? status,
    int? limit,
    int? offset,
  });

  /// Keyset-paginated slice of customers strictly before the cursor position
  /// ([beforeCreatedAt], [beforeId]) in the stable order
  /// `createdAt DESC, id DESC`. Pass both cursor values of the previous
  /// page's last row; omit them for the first page. [limit] is applied as-is
  /// (callers may request one extra row to detect a following page).
  Future<List<Customer>> findPageBefore(
    Session session, {
    required int businessId,
    CustomerStatus? status,
    DateTime? beforeCreatedAt,
    int? beforeId,
    required int limit,
  });

  /// Counts customers matching the same filter as [find], ignoring
  /// limit/offset — used to build paginated list pages.
  Future<int> count(
    Session session, {
    required int businessId,
    CustomerStatus? status,
  });
}
