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
    final data = await session.storage.retrieveFile(
      storageId: document.storageLocation.name,
      path: document.storagePath,
    );
    if (data == null) {
      throw NotFoundException(entityType: 'Document', entityId: '$documentId');
    }
    return data;
  }
}
