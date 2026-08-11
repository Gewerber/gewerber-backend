import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/document_gateway.dart';

@singleton
class GetDocumentUseCase {
  GetDocumentUseCase(this._tenantResolver, this._documents);

  final TenantResolver _tenantResolver;
  final DocumentGateway _documents;

  Future<Document> call(Session session, int documentId) async {
    final tenant = await _tenantResolver.resolve(session);
    final document = await _documents.findById(session, documentId);
    if (document == null || document.businessId != tenant.businessId) {
      throw NotFoundException(entityType: 'Document', entityId: '$documentId');
    }
    return document;
  }
}
