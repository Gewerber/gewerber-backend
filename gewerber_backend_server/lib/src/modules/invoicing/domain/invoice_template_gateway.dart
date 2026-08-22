import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class InvoiceTemplateGateway {
  Future<InvoiceTemplate> create(
    Session session,
    InvoiceTemplate template, {
    Transaction? transaction,
  });

  Future<InvoiceTemplate?> findById(Session session, int id);

  Future<InvoiceTemplate> update(Session session, InvoiceTemplate template);

  Future<List<InvoiceTemplate>> findByBusinessId(
    Session session,
    int businessId, {
    int limit = 100,
    int offset = 0,
  });

  /// Clears the default flag of all templates of a business.
  Future<void> clearDefaultFlags(
    Session session,
    int businessId, {
    Transaction? transaction,
  });
}
