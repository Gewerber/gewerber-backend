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

  /// Counts customers matching the same filter as [find], ignoring
  /// limit/offset — used to build paginated list pages.
  Future<int> count(
    Session session, {
    required int businessId,
    CustomerStatus? status,
  });
}
