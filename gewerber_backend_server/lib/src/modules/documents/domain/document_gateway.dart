import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class DocumentGateway {
  Future<Document> create(
    Session session,
    Document document, {
    Transaction? transaction,
  });

  Future<Document?> findById(Session session, int id);

  Future<List<Document>> find(
    Session session, {
    required int businessId,
    DocumentKind? kind,
    String? relatedEntityType,
    String? relatedEntityId,
    int? limit,
    int? offset,
  });

  Future<Document> delete(Session session, Document document);
}
