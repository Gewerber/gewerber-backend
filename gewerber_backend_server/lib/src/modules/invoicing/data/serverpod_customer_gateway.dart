import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/customer_gateway.dart';

@Singleton(as: CustomerGateway)
class ServerpodCustomerGateway implements CustomerGateway {
  @override
  Future<Customer> create(
    Session session,
    Customer customer, {
    Transaction? transaction,
  }) {
    return Customer.db.insertRow(session, customer, transaction: transaction);
  }

  @override
  Future<Customer?> findById(Session session, int id) {
    return Customer.db.findById(session, id);
  }

  @override
  Future<Customer> update(Session session, Customer customer) {
    return Customer.db.updateRow(session, customer);
  }

  @override
  Future<List<Customer>> find(
    Session session, {
    required int businessId,
    CustomerStatus? status,
    int? limit,
    int? offset,
  }) {
    return Customer.db.find(
      session,
      where: (t) => status == null
          ? t.businessId.equals(businessId)
          : t.businessId.equals(businessId) & t.status.equals(status),
      orderByList: (t) => [t.createdAt.desc()],
      limit: limit,
      offset: offset,
    );
  }
}
