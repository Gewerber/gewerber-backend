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
  Future<List<Customer>> findByIds(Session session, Set<int> ids) {
    if (ids.isEmpty) return Future.value(const []);
    return Customer.db.find(session, where: (t) => t.id.inSet(ids));
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

  @override
  Future<List<Customer>> findPageBefore(
    Session session, {
    required int businessId,
    CustomerStatus? status,
    DateTime? beforeCreatedAt,
    int? beforeId,
    required int limit,
  }) {
    return Customer.db.find(
      session,
      where: (t) {
        var expression = t.businessId.equals(businessId);
        if (status != null) {
          expression = expression & t.status.equals(status);
        }
        if (beforeCreatedAt != null && beforeId != null) {
          // Keyset predicate for the DESC ordering below: everything strictly
          // after the cursor row, with the id as deterministic tiebreak.
          expression =
              expression &
              ((t.createdAt < beforeCreatedAt) |
                  (t.createdAt.equals(beforeCreatedAt) & (t.id < beforeId)));
        }
        return expression;
      },
      orderByList: (t) => [t.createdAt.desc(), t.id.desc()],
      limit: limit,
    );
  }

  @override
  Future<int> count(
    Session session, {
    required int businessId,
    CustomerStatus? status,
  }) {
    return Customer.db.count(
      session,
      where: (t) => status == null
          ? t.businessId.equals(businessId)
          : t.businessId.equals(businessId) & t.status.equals(status),
    );
  }
}
