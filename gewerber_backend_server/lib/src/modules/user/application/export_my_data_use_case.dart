import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/session_auth.dart';
import '../../../generated/protocol.dart';
import '../../accounting/domain/transaction_gateway.dart';
import '../../business/domain/membership_gateway.dart';
import '../../documents/domain/document_gateway.dart';
import '../../guidance/domain/user_guidance_progress_gateway.dart';
import '../../invoicing/domain/customer_gateway.dart';
import '../../invoicing/domain/invoice_gateway.dart';
import '../../invoicing/domain/invoice_item_gateway.dart';
import '../../invoicing/domain/payment_record_gateway.dart';
import '../../invoicing/domain/reminder_gateway.dart';
import '../../time_tracking/domain/project_gateway.dart';
import '../../time_tracking/domain/task_gateway.dart';
import '../../time_tracking/domain/time_entry_gateway.dart';
import '../domain/account_deletion.dart';
import '../domain/user_profile_gateway.dart';

/// Builds a GDPR Art. 20 data export for the logged-in user as a ZIP archive.
///
/// The archive contains every business the user is a member of (and only
/// those): customers, invoices with items, payments, reminders,
/// projects/tasks/time entries, accounting transactions and document
/// metadata + content. Per-user data (profile, memberships, guidance
/// progress) is included once at the top level; foreign tenants are never
/// read.
///
/// Inside the archive every section is a self-documenting JSON file (UTF-8);
/// the layout is versioned via `manifest.json`. Document contents are read
/// from the database storage and capped per file to bound memory usage.
@singleton
class ExportMyDataUseCase {
  ExportMyDataUseCase(
    this._profiles,
    this._memberships,
    this._customers,
    this._invoices,
    this._items,
    this._payments,
    this._reminders,
    this._projects,
    this._tasks,
    this._timeEntries,
    this._transactions,
    this._documents,
    this._guidance,
  );

  /// Version of the export format written into `manifest.json`. Bump on
  /// breaking changes of the layout so consumers can adapt.
  ///
  /// History:
  /// - 1: initial layout.
  /// - 2: added `businesses/<id>/payments.json` and
  ///   `businesses/<id>/reminders.json`.
  static const int exportFormatVersion = 2;

  static const String _manifestPath = 'manifest.json';
  static const String _profilePath = 'profile.json';
  static const String _membershipsPath = 'memberships.json';
  static const String _guidanceProgressPath = 'guidance_progress.json';
  static const String _businessesDir = 'businesses';

  /// Defensive upper bound for embedding a single document's bytes. Uploads
  /// are limited well below this today; oversized entries are exported as
  /// metadata only so one huge blob cannot exhaust server memory.
  static const int maxDocumentBytes = 512 * 1024;

  final UserProfileGateway _profiles;
  final MembershipGateway _memberships;
  final CustomerGateway _customers;
  final InvoiceGateway _invoices;
  final InvoiceItemGateway _items;
  final PaymentRecordGateway _payments;
  final ReminderGateway _reminders;
  final ProjectGateway _projects;
  final TaskGateway _tasks;
  final TimeEntryGateway _timeEntries;
  final TransactionGateway _transactions;
  final DocumentGateway _documents;
  final UserGuidanceProgressGateway _guidance;

  Future<ByteData> call(Session session) async {
    final userId = session.authUserId;
    if (userId == null) {
      throw ForbiddenException(message: 'Not authenticated.');
    }

    final profile = await _profiles.findByUserId(session, userId);
    if (profile != null && profile.deletedAt != null) {
      throwAccountDeleted(userId);
    }
    final memberships = await _memberships.findByUser(session, userId);

    final archive = Archive();

    void addJson(String path, Map<String, dynamic> json) {
      archive.add(ArchiveFile.bytes(path, utf8.encode(jsonEncode(json))));
    }

    addJson(_manifestPath, _manifest(businessCount: memberships.length));

    addJson(_profilePath, {
      'userId': userId.uuid,
      if (profile != null) ...profile.toJson(),
    });

    addJson(_membershipsPath, {
      'count': memberships.length,
      'items': [for (final membership in memberships) membership.toJson()],
    });

    final progress = await _guidance.findByUser(session, userId);
    addJson(_guidanceProgressPath, {
      'count': progress.length,
      'items': [for (final row in progress) row.toJson()],
    });

    for (final membership in memberships) {
      final businessId = membership.businessId;
      final prefix = '$_businessesDir/$businessId';

      addJson('$prefix/business.json', {
        'businessId': businessId,
        'role': membership.role.name,
      });

      // Customers.
      final customers = await _customers.find(session, businessId: businessId);
      addJson('$prefix/customers.json', _section(customers));

      // Invoices with their items (batched item loading).
      final invoices = await _invoices.find(session, businessId: businessId);
      final invoiceIds = [
        for (final invoice in invoices)
          if (invoice.id != null) invoice.id!,
      ];
      final itemsByInvoice = <int, List<InvoiceItem>>{};
      for (final item in await _items.findByInvoiceIds(session, invoiceIds)) {
        itemsByInvoice.putIfAbsent(item.invoiceId, () => []).add(item);
      }
      addJson('$prefix/invoices.json', {
        'count': invoices.length,
        'items': [
          for (final invoice in invoices)
            {
              'invoice': invoice.toJson(),
              'lineItems': [
                for (final item
                    in itemsByInvoice[invoice.id] ?? const <InvoiceItem>[])
                  item.toJson(),
              ],
            },
        ],
      });

      // Payments and reminders of the invoices above, batched in one query
      // each. Every row carries its `invoiceId`.
      final payments = await _payments.findByInvoiceIds(session, invoiceIds);
      addJson('$prefix/payments.json', _section(payments));
      final reminders = await _reminders.findByInvoiceIds(session, invoiceIds);
      addJson('$prefix/reminders.json', _section(reminders));

      // Projects, tasks and time entries.
      final projects = await _projects.find(session, businessId: businessId);
      addJson('$prefix/projects.json', _section(projects));
      final tasks = await _tasks.find(session, businessId: businessId);
      addJson('$prefix/tasks.json', _section(tasks));
      final timeEntries = await _timeEntries.find(
        session,
        businessId: businessId,
      );
      addJson('$prefix/time_entries.json', _section(timeEntries));

      // Accounting transactions.
      final transactions = await _transactions.find(
        session,
        businessId: businessId,
      );
      addJson('$prefix/transactions.json', _section(transactions));

      // Documents: metadata plus embedded content from the database storage.
      final documents = await _documents.find(session, businessId: businessId);
      final documentFiles = <Map<String, dynamic>>[];
      for (final document in documents) {
        final entry = await _exportDocument(
          session,
          archive,
          prefix,
          document,
        );
        if (entry != null) documentFiles.add(entry);
      }
      addJson('$prefix/documents.json', {
        'count': documents.length,
        'filesIncluded': documentFiles.length,
        'items': [for (final document in documents) document.toJson()],
      });
      addJson('$prefix/document_files.json', {
        'count': documentFiles.length,
        'items': documentFiles,
      });
    }

    final encoded = ZipEncoder().encode(archive);
    return ByteData.sublistView(Uint8List.fromList(encoded));
  }

  Map<String, dynamic> _manifest({required int businessCount}) => {
    'format': 'gewerber-gdpr-export',
    'version': exportFormatVersion,
    'generatedAt': DateTime.now().toUtc().toIso8601String(),
    'description':
        'Personal data export according to GDPR Art. 20. JSON files, '
        'UTF-8 encoded; dates as ISO-8601 UTC strings.',
    'layout': {
      'profile.json': 'The user profile.',
      'memberships.json': 'Memberships linking the user to businesses.',
      'guidance_progress.json': 'Per-user guidance progress.',
      'businesses/<id>/*.json':
          'All data of one business the user is a member of.',
      'businesses/<id>/payments.json':
          'Payment records of the business invoices (each row references '
          'its invoiceId).',
      'businesses/<id>/reminders.json':
          'Payment reminders sent for the business invoices (each row '
          'references its invoiceId).',
      'businesses/<id>/documents/files/*':
          'Document contents referenced by document_files.json.',
    },
    'businessCount': businessCount,
  };

  Map<String, dynamic> _section(List<TableRow> rows) => {
    'count': rows.length,
    'items': [for (final row in rows) row.toJson()],
  };

  /// Copies the document's stored bytes into the archive and returns the
  /// manifest entry describing it. Returns `null` when the content cannot be
  /// embedded (missing storage row or oversized file); metadata stays in
  /// `documents.json` either way.
  Future<Map<String, dynamic>?> _exportDocument(
    Session session,
    Archive archive,
    String prefix,
    Document document,
  ) async {
    final id = document.id;
    if (id == null || (document.sizeBytes ?? 0) > maxDocumentBytes) {
      return null;
    }
    // Serverpod 4 storage throws CloudStorageFileNotFoundException when the
    // blob is gone; the export degrades gracefully — the document's metadata
    // stays in documents.json without its content.
    final ByteData data;
    try {
      data = await session.storage.retrieveFile(
        storageId: document.storageLocation.name,
        path: document.storagePath,
      );
    } on CloudStorageFileNotFoundException {
      return null;
    }
    if (data.lengthInBytes > maxDocumentBytes) {
      return null;
    }
    final fileName = '$prefix/documents/files/$id-${document.fileName}';
    // sublistView respects offsetInBytes/lengthInBytes; buffer.asUint8List()
    // would copy the WHOLE backing buffer and embed garbage into the archive.
    archive.add(ArchiveFile.bytes(fileName, Uint8List.sublistView(data)));
    return {
      'documentId': id,
      'fileName': document.fileName,
      'archivePath': fileName,
      'sizeBytes': data.lengthInBytes,
    };
  }
}
