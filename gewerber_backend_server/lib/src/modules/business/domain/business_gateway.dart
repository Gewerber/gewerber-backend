import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class BusinessGateway {
  Future<Business> create(
    Session session,
    Business business, {
    Transaction? transaction,
  });

  Future<Business?> findById(Session session, int id);

  Future<Business> update(Session session, Business business);
}
