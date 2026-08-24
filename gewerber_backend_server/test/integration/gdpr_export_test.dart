@TestOn('vm')
@Tags(['integration'])
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/user/application/export_my_data_use_case.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Integration tests for the GDPR Art. 20 data export
/// (`userProfile.exportMyData`).
void main() {
  const userAId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const userBId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  const ownDocumentContent = 'GEWERBER-EXPORT-BELEG-INHALT';
  const foreignDocumentContent = 'FREMDER-BELEG-INHALT';
  const ownDocumentName = 'export-receipt.txt';
  const foreignDocumentName = 'foreign-receipt.txt';
  const ownCustomerName = 'Export Kunde';
  const foreignCustomerName = 'Fremd Kunde';
  const foreignInvoiceNumber = 'FREMDE-001';
  const ownPaymentReference = 'SEPA-EXPORT-001';
  const foreignPaymentReference = 'FREMD-SEPA-001';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given a user with two businesses and a foreign tenant', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder sessionA;
    late TestSessionBuilder sessionB;
    late int businessAId;
    late int secondBusinessAId;
    late int businessBId;
    late int invoiceItemId;
    late Map<String, Uint8List> files;
    late Archive archive;

    setUp(() async {
      sessionA = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(userAId, {}),
      );
      sessionB = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(userBId, {}),
      );

      // Account A owns two businesses (multi-membership export).
      final businessA = await endpoints.business.create(
        sessionA,
        CreateBusinessRequest(name: 'Export Gewerbe A'),
      );
      businessAId = businessA.id!;
      final secondBusinessA = await endpoints.business.create(
        sessionA,
        CreateBusinessRequest(name: 'Zweitgewerbe A'),
      );
      secondBusinessAId = secondBusinessA.id!;

      final profile = await endpoints.userProfile.getMyProfile(sessionA);
      await endpoints.userProfile.update(
        sessionA,
        UpdateUserProfileRequest(
          displayName: 'Max Muster',
          locale: Locale.de,
          themeMode: AppTheme.system,
        ),
      );
      expect(profile.userId.uuid, userAId);

      await endpoints.guidance.markCompleted(sessionA, 'test-checklist-item');

      // Business A: one of every exportable entity.
      final customer = await endpoints.customer.create(
        sessionA,
        CreateCustomerRequest(name: ownCustomerName, email: 'kunde@example.de'),
        businessId: businessAId,
      );
      final invoice = await endpoints.invoice.create(
        sessionA,
        CreateInvoiceRequest(
          customerId: customer.id,
          items: [
            InvoiceItemRequest(
              description: 'Exportierte Position',
              quantity: 2,
              unitPriceCents: 1500,
            ),
          ],
        ),
        businessId: businessAId,
      );
      final items = await endpoints.invoice.getItems(
        sessionA,
        invoice.id!,
        businessId: businessAId,
      );
      invoiceItemId = items.single.id!;

      // Payments and reminders of the own invoice (sent first, as required).
      await endpoints.invoice.markSent(
        sessionA,
        invoice.id!,
        businessId: businessAId,
      );
      final ownPayment = await endpoints.payment.record(
        sessionA,
        RecordPaymentRequest(
          invoiceId: invoice.id!,
          amountCents: 1500,
          reference: ownPaymentReference,
        ),
        businessId: businessAId,
      );
      expect(ownPayment.invoiceId, invoice.id);
      final ownReminder = await endpoints.reminder.send(
        sessionA,
        invoice.id!,
        businessId: businessAId,
      );
      expect(ownReminder.level, 1);

      final project = await endpoints.project.create(
        sessionA,
        CreateProjectRequest(name: 'Export Projekt'),
        businessId: businessAId,
      );
      final task = await endpoints.task.create(
        sessionA,
        CreateTaskRequest(projectId: project.id!, name: 'Export Aufgabe'),
        businessId: businessAId,
      );
      await endpoints.timeEntry.create(
        sessionA,
        CreateTimeEntryRequest(
          projectId: project.id,
          taskId: task.id,
          description: 'Export Zeiteintrag',
          startedAt: DateTime(2026, 8, 1, 9),
          durationMinutes: 90,
        ),
        businessId: businessAId,
      );
      await endpoints.accounting.create(
        sessionA,
        CreateTransactionRequest(
          type: TransactionType.income,
          category: TransactionCategory.salesRevenue,
          description: 'Export Umsatz',
          occurredAt: DateTime(2026, 8, 2),
          amountCents: 3570,
        ),
        businessId: businessAId,
      );
      await endpoints.document.upload(
        sessionA,
        UploadDocumentRequest(
          businessId: businessAId,
          kind: DocumentKind.receipt,
          fileName: ownDocumentName,
          mimeType: 'text/plain',
          data: ByteData.sublistView(utf8.encode(ownDocumentContent)),
        ),
      );

      // Second own business: minimal footprint.
      await endpoints.customer.create(
        sessionA,
        CreateCustomerRequest(name: 'Zweitgewerbe Kunde'),
        businessId: secondBusinessAId,
      );

      // Foreign tenant B must never leak into A's export.
      final foreignCustomer = await endpoints.customer.create(
        sessionB,
        CreateCustomerRequest(
          name: foreignCustomerName,
          email: 'fremd@example.de',
        ),
        businessId: businessBId = (await endpoints.business.create(
          sessionB,
          CreateBusinessRequest(name: 'Fremdes Gewerbe B'),
        )).id!,
      );
      final foreignInvoice = await endpoints.invoice.create(
        sessionB,
        CreateInvoiceRequest(
          customerId: foreignCustomer.id,
          items: [
            InvoiceItemRequest(
              description: foreignInvoiceNumber,
              quantity: 1,
              unitPriceCents: 99999,
            ),
          ],
        ),
        businessId: businessBId,
      );
      // Foreign payments/reminders must not leak either.
      await endpoints.invoice.markSent(
        sessionB,
        foreignInvoice.id!,
        businessId: businessBId,
      );
      await endpoints.payment.record(
        sessionB,
        RecordPaymentRequest(
          invoiceId: foreignInvoice.id!,
          amountCents: 123,
          reference: foreignPaymentReference,
        ),
        businessId: businessBId,
      );
      await endpoints.reminder.send(
        sessionB,
        foreignInvoice.id!,
        businessId: businessBId,
      );
      await endpoints.document.upload(
        sessionB,
        UploadDocumentRequest(
          businessId: businessBId,
          kind: DocumentKind.receipt,
          fileName: foreignDocumentName,
          mimeType: 'text/plain',
          data: ByteData.sublistView(utf8.encode(foreignDocumentContent)),
        ),
      );

      final zip = await endpoints.userProfile.exportMyData(sessionA);
      archive = ZipDecoder().decodeBytes(
        zip.buffer.asUint8List(zip.offsetInBytes, zip.lengthInBytes),
      );
      files = {
        for (final file in archive.files)
          file.name: Uint8List.fromList(file.content as List<int>),
      };
    });

    String text(String fileName) => utf8.decode(files[fileName]!);

    test(
      'when exporting then manifest, profile and membership sections exist',
      () {
        expect(
          files.keys,
          containsAll([
            'manifest.json',
            'profile.json',
            'memberships.json',
            'guidance_progress.json',
          ]),
        );

        final manifest =
            jsonDecode(text('manifest.json')) as Map<String, dynamic>;
        expect(manifest['format'], 'gewerber-gdpr-export');
        expect(manifest['version'], ExportMyDataUseCase.exportFormatVersion);
        expect(manifest['businessCount'], 2);

        final profileJson =
            jsonDecode(text('profile.json')) as Map<String, dynamic>;
        expect(profileJson['userId'], userAId);
        expect(profileJson['displayName'], 'Max Muster');

        final memberships =
            jsonDecode(text('memberships.json')) as Map<String, dynamic>;
        expect(memberships['count'], 2);
        final memberBusinesses = (memberships['items'] as List)
            .map((m) => (m as Map<String, dynamic>)['businessId'])
            .toSet();
        expect(memberBusinesses, {businessAId, secondBusinessAId});
      },
    );

    test('when exporting then per-user guidance progress is included', () {
      final progress =
          jsonDecode(text('guidance_progress.json')) as Map<String, dynamic>;
      expect(progress['count'], greaterThanOrEqualTo(1));
      final keys = (progress['items'] as List).map(
        (row) => (row as Map<String, dynamic>)['itemKey'],
      );
      expect(keys, contains('test-checklist-item'));
    });

    test(
      'when exporting then all sections of both own businesses are present',
      () {
        final prefix = 'businesses/$businessAId';
        expect(
          files.keys,
          containsAll([
            '$prefix/business.json',
            '$prefix/customers.json',
            '$prefix/invoices.json',
            '$prefix/payments.json',
            '$prefix/reminders.json',
            '$prefix/projects.json',
            '$prefix/tasks.json',
            '$prefix/time_entries.json',
            '$prefix/transactions.json',
            '$prefix/documents.json',
            '$prefix/document_files.json',
            'businesses/$secondBusinessAId/customers.json',
          ]),
        );

        final customers = jsonDecode(text('$prefix/customers.json'));
        expect(customers['count'], 1);
        expect(
          (customers['items'].single as Map)['name'],
          ownCustomerName,
        );
      },
    );

    test(
      'when exporting then payments and reminders sections are included',
      () {
        final prefix = 'businesses/$businessAId';

        final payments = jsonDecode(text('$prefix/payments.json')) as Map;
        expect(payments['count'], 1);
        final payment = (payments['items'].single as Map);
        expect(payment['amountCents'], 1500);
        expect(payment['reference'], ownPaymentReference);
        expect(payment['invoiceId'], isNotNull);

        final reminders = jsonDecode(text('$prefix/reminders.json')) as Map;
        expect(reminders['count'], 1);
        final reminder = (reminders['items'].single as Map);
        expect(reminder['level'], 1);
        expect(reminder['invoiceId'], payment['invoiceId']);

        // The second own business has no invoices yet: empty but present
        // sections keep the layout uniform.
        final emptyPrefix = 'businesses/$secondBusinessAId';
        expect(jsonDecode(text('$emptyPrefix/payments.json'))['count'], 0);
        expect(jsonDecode(text('$emptyPrefix/reminders.json'))['count'], 0);

        // The manifest documents both new files and bumps the format version.
        final manifest =
            jsonDecode(text('manifest.json')) as Map<String, dynamic>;
        expect(manifest['version'], 2);
        expect(
          (manifest['layout'] as Map).keys.join('\n'),
          contains('payments.json'),
        );
        expect(
          (manifest['layout'] as Map).keys.join('\n'),
          contains('reminders.json'),
        );
      },
    );

    test('when exporting then invoices include their line items', () {
      final prefix = 'businesses/$businessAId';
      final invoices = jsonDecode(text('$prefix/invoices.json')) as Map;
      expect(invoices['count'], 1);

      final entry = invoices['items'].single as Map;
      expect(entry['invoice']['id'], isNotNull);
      final lineItems = entry['lineItems'] as List;
      expect(lineItems, hasLength(1));
      expect((lineItems.single as Map)['id'], invoiceItemId);
      expect((lineItems.single as Map)['description'], 'Exportierte Position');
    });

    test(
      'when exporting then time tracking and accounting rows are included',
      () {
        final prefix = 'businesses/$businessAId';
        expect(
          ((jsonDecode(text('$prefix/projects.json')) as Map)['items'] as List)
              .map((p) => (p as Map)['name']),
          contains('Export Projekt'),
        );
        expect(
          ((jsonDecode(text('$prefix/tasks.json')) as Map)['items'] as List)
              .map((t) => (t as Map)['name']),
          contains('Export Aufgabe'),
        );
        expect(
          ((jsonDecode(text('$prefix/time_entries.json')) as Map)['items']
                  as List)
              .map((e) => (e as Map)['description']),
          contains('Export Zeiteintrag'),
        );
        expect(
          ((jsonDecode(text('$prefix/transactions.json')) as Map)['items']
                  as List)
              .map((t) => (t as Map)['amountCents']),
          contains(3570),
        );
      },
    );

    test('when exporting then document content is embedded', () {
      final prefix = 'businesses/$businessAId';
      final documents = jsonDecode(text('$prefix/documents.json')) as Map;
      expect(documents['count'], 1);

      final metadata = (documents['items'].single as Map)['fileName'];
      expect(metadata, ownDocumentName);
      expect(documents['filesIncluded'], 1);

      final fileIndex = jsonDecode(text('$prefix/document_files.json')) as Map;
      final entry = fileIndex['items'].single as Map;
      expect(entry['fileName'], ownDocumentName);
      expect(entry['sizeBytes'], ownDocumentContent.length);

      final embeddedPath = entry['archivePath'] as String;
      expect(files.keys, contains(embeddedPath));
      expect(utf8.decode(files[embeddedPath]!), ownDocumentContent);
    });

    test(
      'when exporting then foreign tenant data is not contained anywhere',
      () {
        final allBytes = files.values.fold<List<int>>(
          <int>[],
          (acc, bytes) => acc..addAll(bytes),
        );
        final everything = utf8.decode(allBytes, allowMalformed: true);

        expect(everything, isNot(contains(foreignCustomerName)));
        expect(everything, isNot(contains(foreignInvoiceNumber)));
        expect(everything, isNot(contains(foreignDocumentContent)));
        expect(everything, isNot(contains(userBId)));
        expect(everything, isNot(contains(foreignPaymentReference)));

        // No section of the foreign business exists in the archive.
        for (final name in files.keys) {
          expect(
            name.startsWith('businesses/$businessBId/'),
            isFalse,
            reason: 'foreign section leaked: $name',
          );
          final firstSegment = name.split('/').first;
          expect(
            firstSegment == businessBId.toString(),
            isFalse,
            reason: 'foreign section leaked: $name',
          );
        }
      },
    );
  });

  withServerpod('Given an oversized stored document', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder sessionA;
    late Session session;

    setUp(() async {
      sessionA = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(userAId, {}),
      );
      session = sessionA.build();
      final business = await endpoints.business.create(
        sessionA,
        CreateBusinessRequest(name: 'Big Blob Gewerbe'),
      );
      // Inserted directly to bypass the upload path (which caps file sizes):
      // simulates legacy data that exceeds the export embedding limit.
      await Document.db.insertRow(
        session,
        Document(
          businessId: business.id!,
          kind: DocumentKind.attachment,
          fileName: 'huge.bin',
          mimeType: 'application/octet-stream',
          sizeBytes: ExportMyDataUseCase.maxDocumentBytes + 1,
          storageLocation: StorageLocation.private,
          storagePath: 'business/${business.id}/attachment/huge.bin',
        ),
      );
    });

    test(
      'when exporting then metadata stays but no bytes are embedded',
      () async {
        final zip = await endpoints.userProfile.exportMyData(sessionA);
        final decoded = ZipDecoder().decodeBytes(
          zip.buffer.asUint8List(zip.offsetInBytes, zip.lengthInBytes),
        );
        final names = decoded.files.map((f) => f.name).toList();

        final documentsFile = names.singleWhere(
          (name) => name.endsWith('/documents.json'),
        );
        final documents =
            jsonDecode(
                  utf8.decode(
                    Uint8List.fromList(
                      decoded.files
                              .firstWhere(
                                (f) => f.name == documentsFile,
                              )
                              .content
                          as List<int>,
                    ),
                  ),
                )
                as Map;
        expect(documents['count'], 1);
        expect(documents['filesIncluded'], 0);
        expect(names, everyElement(isNot(endsWith('huge.bin'))));
      },
    );
  });
}
