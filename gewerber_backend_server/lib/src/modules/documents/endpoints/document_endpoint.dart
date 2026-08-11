import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/business_scoped_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/delete_document_use_case.dart';
import '../application/download_document_use_case.dart';
import '../application/get_document_use_case.dart';
import '../application/list_documents_use_case.dart';
import '../application/upload_document_use_case.dart';

class DocumentEndpoint extends BusinessScopedEndpoint {
  Future<Document> upload(Session session, UploadDocumentRequest request) {
    return getIt<UploadDocumentUseCase>().call(session, request);
  }

  Future<List<Document>> list(
    Session session, {
    int? businessId,
    DocumentKind? kind,
    String? relatedEntityType,
    String? relatedEntityId,
  }) {
    return getIt<ListDocumentsUseCase>().call(
      session,
      businessId: businessId,
      kind: kind,
      relatedEntityType: relatedEntityType,
      relatedEntityId: relatedEntityId,
    );
  }

  Future<Document> get(Session session, int documentId) {
    return getIt<GetDocumentUseCase>().call(session, documentId);
  }

  Future<ByteData> download(Session session, int documentId) {
    return getIt<DownloadDocumentUseCase>().call(session, documentId);
  }

  Future<void> delete(Session session, int documentId) {
    return getIt<DeleteDocumentUseCase>().call(session, documentId);
  }
}
