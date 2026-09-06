import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import 'get_document_use_case.dart';

@singleton
class DownloadDocumentUseCase {
  DownloadDocumentUseCase(this._getDocument);

  final GetDocumentUseCase _getDocument;

  Future<ByteData> call(Session session, int documentId) async {
    final document = await _getDocument.call(session, documentId);
    // Serverpod 4 storage throws CloudStorageFileNotFoundException when the
    // blob is gone; translate it into the API's NotFoundException.
    final ByteData data;
    try {
      data = await session.storage.retrieveFile(
        storageId: document.storageLocation.name,
        path: document.storagePath,
      );
    } on CloudStorageFileNotFoundException {
      throw NotFoundException(entityType: 'Document', entityId: '$documentId');
    }
    return data;
  }
}
