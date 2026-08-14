import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/invoice_template_gateway.dart';

@Singleton(as: InvoiceTemplateGateway)
class ServerpodInvoiceTemplateGateway implements InvoiceTemplateGateway {
  @override
  Future<InvoiceTemplate> create(
    Session session,
    InvoiceTemplate template, {
    Transaction? transaction,
  }) {
    return InvoiceTemplate.db.insertRow(
      session,
      template,
      transaction: transaction,
    );
  }

  @override
  Future<InvoiceTemplate?> findById(Session session, int id) {
    return InvoiceTemplate.db.findById(session, id);
  }

  @override
  Future<InvoiceTemplate> update(
    Session session,
    InvoiceTemplate template,
  ) {
    return InvoiceTemplate.db.updateRow(session, template);
  }

  @override
  Future<List<InvoiceTemplate>> findByBusinessId(
    Session session,
    int businessId,
  ) {
    return InvoiceTemplate.db.find(
      session,
      where: (t) => t.businessId.equals(businessId),
      orderBy: (t) => t.createdAt,
    );
  }

  @override
  Future<void> clearDefaultFlags(
    Session session,
    int businessId, {
    Transaction? transaction,
  }) {
    return InvoiceTemplate.db.updateWhere(
      session,
      where: (t) => t.businessId.equals(businessId) & t.isDefault.equals(true),
      columnValues: (t) => [t.isDefault(false)],
      transaction: transaction,
    );
  }
}
