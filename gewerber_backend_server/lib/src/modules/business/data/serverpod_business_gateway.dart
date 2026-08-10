import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/business_gateway.dart';

@Singleton(as: BusinessGateway)
class ServerpodBusinessGateway implements BusinessGateway {
  @override
  Future<Business> create(
    Session session,
    Business business, {
    Transaction? transaction,
  }) {
    return Business.db.insertRow(session, business, transaction: transaction);
  }

  @override
  Future<Business?> findById(Session session, int id) {
    return Business.db.findById(session, id);
  }

  @override
  Future<Business> update(Session session, Business business) {
    return Business.db.updateRow(session, business);
  }
}
