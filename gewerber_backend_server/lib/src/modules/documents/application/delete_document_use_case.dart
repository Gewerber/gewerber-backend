import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/document_gateway.dart';
import 'get_document_use_case.dart';

@singleton
class DeleteDocumentUseCase {
  DeleteDocumentUseCase(
    this._tenantResolver,
    this._getDocument,
    this._documents,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final GetDocumentUseCase _getDocument;
  final DocumentGateway _documents;
  final AuditService _audit;

  Future<void> call(Session session, int documentId) async {
    final tenant = await _tenantResolver.requireAdmin(session);
    final document = await _getDocument.call(session, documentId);
    if (document.businessId != tenant.businessId) {
      throw NotFoundException(entityType: 'Document', entityId: '$documentId');
    }

    await session.storage.deleteFile(
      storageId: document.storageLocation.name,
      path: document.storagePath,
    );
    await _documents.delete(session, document);

    await _audit.log(
      session,
      action: 'document.delete',
      entityType: 'Document',
      entityId: '$documentId',
      tenant: tenant,
    );
  }
}
