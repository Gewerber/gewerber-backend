@Tags(['integration'])
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const otherUserId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given DocumentEndpoint', (sessionBuilder, endpoints) {
    late TestSessionBuilder authenticatedSession;
    late int businessId;

    setUp(() async {
      authenticatedSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          testUserId,
          {},
        ),
      );
      final business = await endpoints.business.create(
        authenticatedSession,
        CreateBusinessRequest(name: 'Mein Gewerbe'),
      );
      businessId = business.id!;
    });

    UploadDocumentRequest uploadRequest({
      required String fileName,
      String content = 'Gewerber test content',
      DocumentKind kind = DocumentKind.attachment,
      int? overrideBusinessId,
      String? mimeType = 'text/plain',
    }) {
      return UploadDocumentRequest(
        businessId: overrideBusinessId ?? businessId,
        kind: kind,
        fileName: fileName,
        mimeType: mimeType,
        data: ByteData.sublistView(utf8.encode(content)),
      );
    }

    test('when uploading then document metadata is stored', () async {
      final document = await endpoints.document.upload(
        authenticatedSession,
        uploadRequest(fileName: 'receipt.txt'),
      );

      expect(document.id, isNotNull);
      expect(document.businessId, businessId);
      expect(document.kind, DocumentKind.attachment);
      expect(document.fileName, 'receipt.txt');
      expect(document.mimeType, 'text/plain');
      expect(document.sizeBytes, 'Gewerber test content'.length);
      expect(document.storageLocation, StorageLocation.private);
      expect(document.storagePath, contains('business/$businessId/'));
      expect(document.storagePath, endsWith('.txt'));
    });

    test('when downloading then the same bytes are returned', () async {
      const content = 'hello gewerber äöü';
      final document = await endpoints.document.upload(
        authenticatedSession,
        uploadRequest(fileName: 'data.txt', content: content),
      );

      final downloaded = await endpoints.document.download(
        authenticatedSession,
        document.id!,
      );

      expect(
        utf8.decode(
          downloaded.buffer.asUint8List(
            downloaded.offsetInBytes,
            downloaded.lengthInBytes,
          ),
        ),
        content,
      );
    });

    test('when listing then only own documents are returned', () async {
      await endpoints.document.upload(
        authenticatedSession,
        uploadRequest(fileName: 'a.txt'),
      );
      await endpoints.document.upload(
        authenticatedSession,
        uploadRequest(fileName: 'b.pdf', kind: DocumentKind.invoicePdf),
      );

      final all = await endpoints.document.list(authenticatedSession);
      expect(all.length, 2);

      final pdfs = await endpoints.document.list(
        authenticatedSession,
        kind: DocumentKind.invoicePdf,
      );
      expect(pdfs.length, 1);
      expect(pdfs.first.fileName, 'b.pdf');
    });

    test('when deleting then document is removed', () async {
      final document = await endpoints.document.upload(
        authenticatedSession,
        uploadRequest(fileName: 'to-delete.txt'),
      );

      await endpoints.document.delete(authenticatedSession, document.id!);

      await expectLater(
        () => endpoints.document.get(authenticatedSession, document.id!),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('when uploading empty file then ValidationException', () async {
      await expectLater(
        () => endpoints.document.upload(
          authenticatedSession,
          UploadDocumentRequest(
            businessId: businessId,
            fileName: 'empty.txt',
            data: ByteData(0),
          ),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('when file name is blank then ValidationException', () async {
      await expectLater(
        () => endpoints.document.upload(
          authenticatedSession,
          UploadDocumentRequest(
            businessId: businessId,
            fileName: '   ',
            data: ByteData.sublistView(utf8.encode('x')),
          ),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('when uploading a whitelisted type then it is stored', () async {
      final document = await endpoints.document.upload(
        authenticatedSession,
        uploadRequest(
          fileName: 'rechnung.pdf',
          mimeType: 'application/pdf',
          content: '%PDF-1.4 fake pdf',
        ),
      );
      expect(document.storagePath, endsWith('.pdf'));
      expect(document.mimeType, 'application/pdf');
    });

    test(
      'when extension is not whitelisted then ValidationException',
      () async {
        for (final fileName in ['payload.exe', 'script.js', 'page.html']) {
          await expectLater(
            () => endpoints.document.upload(
              authenticatedSession,
              uploadRequest(fileName: fileName),
            ),
            throwsA(
              isA<ValidationException>().having(
                (e) => e.field,
                'field',
                'fileName',
              ),
            ),
            reason: '"$fileName" must be rejected',
          );
        }
      },
    );

    test('when the file has no extension then ValidationException', () async {
      await expectLater(
        () => endpoints.document.upload(
          authenticatedSession,
          uploadRequest(fileName: 'README'),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test(
      'when content type is not whitelisted then ValidationException',
      () async {
        await expectLater(
          () => endpoints.document.upload(
            authenticatedSession,
            uploadRequest(
              fileName: 'notes.txt',
              mimeType: 'application/x-msdownload',
            ),
          ),
          throwsA(
            isA<ValidationException>().having(
              (e) => e.field,
              'field',
              'mimeType',
            ),
          ),
        );
      },
    );

    test(
      'when extension and content type disagree then the extension wins',
      () async {
        // Mislabeled MIME types are common in clients: the extension decides.
        final document = await endpoints.document.upload(
          authenticatedSession,
          uploadRequest(fileName: 'b.pdf', mimeType: 'text/plain'),
        );
        expect(document.fileName, 'b.pdf');
        expect(document.mimeType, 'text/plain');
        expect(document.storagePath, endsWith('.pdf'));
      },
    );

    test(
      'when other tenant accesses a document then NotFoundException',
      () async {
        final document = await endpoints.document.upload(
          authenticatedSession,
          uploadRequest(fileName: 'secret.txt'),
        );

        final otherSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            otherUserId,
            {},
          ),
        );
        final otherBusiness = await endpoints.business.create(
          otherSession,
          CreateBusinessRequest(name: 'Anderes Gewerbe'),
        );

        await expectLater(
          () => endpoints.document.get(otherSession, document.id!),
          throwsA(isA<NotFoundException>()),
        );
        await expectLater(
          () => endpoints.document.download(otherSession, document.id!),
          throwsA(isA<NotFoundException>()),
        );
        await expectLater(
          () => endpoints.document.delete(otherSession, document.id!),
          throwsA(isA<NotFoundException>()),
        );

        final listed = await endpoints.document.list(otherSession);
        expect(listed, isEmpty);
        expect(otherBusiness.id, isNot(businessId));
      },
    );
  });
}
