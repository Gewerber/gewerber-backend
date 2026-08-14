import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/document_gateway.dart';

@Singleton(as: DocumentGateway)
class ServerpodDocumentGateway implements DocumentGateway {
  @override
  Future<Document> create(
    Session session,
    Document document, {
    Transaction? transaction,
  }) {
    return Document.db.insertRow(session, document, transaction: transaction);
  }

  @override
  Future<Document?> findById(Session session, int id) {
    return Document.db.findById(session, id);
  }

  @override
  Future<List<Document>> find(
    Session session, {
    required int businessId,
    DocumentKind? kind,
    String? relatedEntityType,
    String? relatedEntityId,
    int? limit,
    int? offset,
  }) {
    return Document.db.find(
      session,
      where: (t) {
        var expression = t.businessId.equals(businessId);
        if (kind != null) {
          expression = expression & t.kind.equals(kind);
        }
        if (relatedEntityType != null) {
          expression =
              expression & t.relatedEntityType.equals(relatedEntityType);
        }
        if (relatedEntityId != null) {
          expression = expression & t.relatedEntityId.equals(relatedEntityId);
        }
        return expression;
      },
      orderByList: (t) => [t.createdAt.desc()],
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<Document> delete(Session session, Document document) {
    return Document.db.deleteRow(session, document);
  }
}
