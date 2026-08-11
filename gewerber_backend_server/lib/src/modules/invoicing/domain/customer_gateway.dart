import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class CustomerGateway {
  Future<Customer> create(
    Session session,
    Customer customer, {
    Transaction? transaction,
  });

  Future<Customer?> findById(Session session, int id);

  Future<Customer> update(Session session, Customer customer);

  Future<List<Customer>> find(
    Session session, {
    required int businessId,
    CustomerStatus? status,
    int? limit,
    int? offset,
  });
}
