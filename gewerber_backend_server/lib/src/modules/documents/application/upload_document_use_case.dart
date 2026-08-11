import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/session_auth.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/document_gateway.dart';

@singleton
class UploadDocumentUseCase {
  UploadDocumentUseCase(
    this._tenantResolver,
    this._documents,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final DocumentGateway _documents;
  final AuditService _audit;

  Future<Document> call(Session session, UploadDocumentRequest request) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: request.businessId,
    );
    _validate(request);

    final extension = _extensionOf(request.fileName);
    final path =
        'business/${tenant.businessId}/${request.kind.name}/'
        '${Uuid().toString()}$extension';

    // Uploaded files always go to the private storage; public access is
    // granted explicitly through the download endpoint.
    await session.storage.storeFile(
      storageId: StorageLocation.private.name,
      path: path,
      byteData: request.data,
    );

    final document = await _documents.create(
      session,
      Document(
        businessId: tenant.businessId,
        kind: request.kind,
        fileName: request.fileName.trim(),
        mimeType: request.mimeType,
        sizeBytes: request.data.lengthInBytes,
        storageLocation: StorageLocation.private,
        storagePath: path,
        relatedEntityType: request.relatedEntityType,
        relatedEntityId: request.relatedEntityId,
        uploadedById: session.authUserId,
      ),
    );

    await _audit.log(
      session,
      action: 'document.upload',
      entityType: 'Document',
      entityId: '${document.id}',
      tenant: tenant,
    );
    return document;
  }

  void _validate(UploadDocumentRequest request) {
    if (request.fileName.trim().isEmpty) {
      throw ValidationException(
        message: 'File name is required.',
        field: 'fileName',
      );
    }
    if (request.data.lengthInBytes == 0) {
      throw ValidationException(message: 'File is empty.', field: 'data');
    }
  }

  String _extensionOf(String fileName) {
    final index = fileName.lastIndexOf('.');
    if (index < 0 || index == fileName.length - 1) {
      return '';
    }
    return fileName.substring(index).toLowerCase();
  }
}
