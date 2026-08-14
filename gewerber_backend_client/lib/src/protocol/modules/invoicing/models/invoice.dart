/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../../modules/invoicing/models/invoice_type.dart' as _i2;
import '../../../modules/invoicing/models/invoice_status.dart' as _i3;
import '../../../modules/business/models/locale.dart' as _i4;
import '../../../modules/business/models/currency.dart' as _i5;
import '../../../modules/invoicing/models/recurrence_interval.dart' as _i6;

abstract class Invoice
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  Invoice._({
    this.id,
    required this.businessId,
    required this.number,
    _i2.InvoiceType? type,
    _i3.InvoiceStatus? status,
    this.customerId,
    required this.issueDate,
    this.dueDate,
    this.serviceDateFrom,
    this.serviceDateTo,
    _i4.Locale? locale,
    _i5.Currency? currency,
    int? subtotalCents,
    int? vatTotalCents,
    int? totalCents,
    int? paymentTermsDays,
    int? dunningLevel,
    this.notes,
    this.templateId,
    this.pdfDocumentId,
    this.recurrenceInterval,
    this.nextRecurrenceDate,
    this.recurrenceEndDate,
    this.recurrenceMaxOccurrences,
    int? recurrenceOccurrencesCreated,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : type = type ?? _i2.InvoiceType.invoice,
       status = status ?? _i3.InvoiceStatus.draft,
       locale = locale ?? _i4.Locale.de,
       currency = currency ?? _i5.Currency.eur,
       subtotalCents = subtotalCents ?? 0,
       vatTotalCents = vatTotalCents ?? 0,
       totalCents = totalCents ?? 0,
       paymentTermsDays = paymentTermsDays ?? 14,
       dunningLevel = dunningLevel ?? 0,
       recurrenceOccurrencesCreated = recurrenceOccurrencesCreated ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Invoice({
    int? id,
    required int businessId,
    required String number,
    _i2.InvoiceType? type,
    _i3.InvoiceStatus? status,
    int? customerId,
    required DateTime issueDate,
    DateTime? dueDate,
    DateTime? serviceDateFrom,
    DateTime? serviceDateTo,
    _i4.Locale? locale,
    _i5.Currency? currency,
    int? subtotalCents,
    int? vatTotalCents,
    int? totalCents,
    int? paymentTermsDays,
    int? dunningLevel,
    String? notes,
    int? templateId,
    int? pdfDocumentId,
    _i6.RecurrenceInterval? recurrenceInterval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
    int? recurrenceOccurrencesCreated,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _InvoiceImpl;

  factory Invoice.fromJson(Map<String, dynamic> jsonSerialization) {
    return Invoice(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      number: jsonSerialization['number'] as String,
      type: jsonSerialization['type'] == null
          ? null
          : _i2.InvoiceType.fromJson((jsonSerialization['type'] as String)),
      status: jsonSerialization['status'] == null
          ? null
          : _i3.InvoiceStatus.fromJson((jsonSerialization['status'] as String)),
      customerId: jsonSerialization['customerId'] as int?,
      issueDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['issueDate'],
      ),
      dueDate: jsonSerialization['dueDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
      serviceDateFrom: jsonSerialization['serviceDateFrom'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['serviceDateFrom'],
            ),
      serviceDateTo: jsonSerialization['serviceDateTo'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['serviceDateTo'],
            ),
      locale: jsonSerialization['locale'] == null
          ? null
          : _i4.Locale.fromJson((jsonSerialization['locale'] as String)),
      currency: jsonSerialization['currency'] == null
          ? null
          : _i5.Currency.fromJson((jsonSerialization['currency'] as String)),
      subtotalCents: jsonSerialization['subtotalCents'] as int?,
      vatTotalCents: jsonSerialization['vatTotalCents'] as int?,
      totalCents: jsonSerialization['totalCents'] as int?,
      paymentTermsDays: jsonSerialization['paymentTermsDays'] as int?,
      dunningLevel: jsonSerialization['dunningLevel'] as int?,
      notes: jsonSerialization['notes'] as String?,
      templateId: jsonSerialization['templateId'] as int?,
      pdfDocumentId: jsonSerialization['pdfDocumentId'] as int?,
      recurrenceInterval: jsonSerialization['recurrenceInterval'] == null
          ? null
          : _i6.RecurrenceInterval.fromJson(
              (jsonSerialization['recurrenceInterval'] as String),
            ),
      nextRecurrenceDate: jsonSerialization['nextRecurrenceDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['nextRecurrenceDate'],
            ),
      recurrenceEndDate: jsonSerialization['recurrenceEndDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['recurrenceEndDate'],
            ),
      recurrenceMaxOccurrences:
          jsonSerialization['recurrenceMaxOccurrences'] as int?,
      recurrenceOccurrencesCreated:
          jsonSerialization['recurrenceOccurrencesCreated'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int businessId;

  String number;

  _i2.InvoiceType type;

  _i3.InvoiceStatus status;

  int? customerId;

  DateTime issueDate;

  DateTime? dueDate;

  DateTime? serviceDateFrom;

  DateTime? serviceDateTo;

  _i4.Locale locale;

  _i5.Currency currency;

  int subtotalCents;

  int vatTotalCents;

  int totalCents;

  int paymentTermsDays;

  int dunningLevel;

  String? notes;

  int? templateId;

  int? pdfDocumentId;

  _i6.RecurrenceInterval? recurrenceInterval;

  DateTime? nextRecurrenceDate;

  DateTime? recurrenceEndDate;

  int? recurrenceMaxOccurrences;

  int recurrenceOccurrencesCreated;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Invoice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Invoice copyWith({
    int? id,
    int? businessId,
    String? number,
    _i2.InvoiceType? type,
    _i3.InvoiceStatus? status,
    int? customerId,
    DateTime? issueDate,
    DateTime? dueDate,
    DateTime? serviceDateFrom,
    DateTime? serviceDateTo,
    _i4.Locale? locale,
    _i5.Currency? currency,
    int? subtotalCents,
    int? vatTotalCents,
    int? totalCents,
    int? paymentTermsDays,
    int? dunningLevel,
    String? notes,
    int? templateId,
    int? pdfDocumentId,
    _i6.RecurrenceInterval? recurrenceInterval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
    int? recurrenceOccurrencesCreated,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Invoice',
      if (id != null) 'id': id,
      'businessId': businessId,
      'number': number,
      'type': type.toJson(),
      'status': status.toJson(),
      if (customerId != null) 'customerId': customerId,
      'issueDate': issueDate.toJson(),
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      if (serviceDateFrom != null) 'serviceDateFrom': serviceDateFrom?.toJson(),
      if (serviceDateTo != null) 'serviceDateTo': serviceDateTo?.toJson(),
      'locale': locale.toJson(),
      'currency': currency.toJson(),
      'subtotalCents': subtotalCents,
      'vatTotalCents': vatTotalCents,
      'totalCents': totalCents,
      'paymentTermsDays': paymentTermsDays,
      'dunningLevel': dunningLevel,
      if (notes != null) 'notes': notes,
      if (templateId != null) 'templateId': templateId,
      if (pdfDocumentId != null) 'pdfDocumentId': pdfDocumentId,
      if (recurrenceInterval != null)
        'recurrenceInterval': recurrenceInterval?.toJson(),
      if (nextRecurrenceDate != null)
        'nextRecurrenceDate': nextRecurrenceDate?.toJson(),
      if (recurrenceEndDate != null)
        'recurrenceEndDate': recurrenceEndDate?.toJson(),
      if (recurrenceMaxOccurrences != null)
        'recurrenceMaxOccurrences': recurrenceMaxOccurrences,
      'recurrenceOccurrencesCreated': recurrenceOccurrencesCreated,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Invoice',
      if (id != null) 'id': id,
      'businessId': businessId,
      'number': number,
      'type': type.toJson(),
      'status': status.toJson(),
      if (customerId != null) 'customerId': customerId,
      'issueDate': issueDate.toJson(),
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      if (serviceDateFrom != null) 'serviceDateFrom': serviceDateFrom?.toJson(),
      if (serviceDateTo != null) 'serviceDateTo': serviceDateTo?.toJson(),
      'locale': locale.toJson(),
      'currency': currency.toJson(),
      'subtotalCents': subtotalCents,
      'vatTotalCents': vatTotalCents,
      'totalCents': totalCents,
      'paymentTermsDays': paymentTermsDays,
      'dunningLevel': dunningLevel,
      if (notes != null) 'notes': notes,
      if (templateId != null) 'templateId': templateId,
      if (pdfDocumentId != null) 'pdfDocumentId': pdfDocumentId,
      if (recurrenceInterval != null)
        'recurrenceInterval': recurrenceInterval?.toJson(),
      if (nextRecurrenceDate != null)
        'nextRecurrenceDate': nextRecurrenceDate?.toJson(),
      if (recurrenceEndDate != null)
        'recurrenceEndDate': recurrenceEndDate?.toJson(),
      if (recurrenceMaxOccurrences != null)
        'recurrenceMaxOccurrences': recurrenceMaxOccurrences,
      'recurrenceOccurrencesCreated': recurrenceOccurrencesCreated,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvoiceImpl extends Invoice {
  _InvoiceImpl({
    int? id,
    required int businessId,
    required String number,
    _i2.InvoiceType? type,
    _i3.InvoiceStatus? status,
    int? customerId,
    required DateTime issueDate,
    DateTime? dueDate,
    DateTime? serviceDateFrom,
    DateTime? serviceDateTo,
    _i4.Locale? locale,
    _i5.Currency? currency,
    int? subtotalCents,
    int? vatTotalCents,
    int? totalCents,
    int? paymentTermsDays,
    int? dunningLevel,
    String? notes,
    int? templateId,
    int? pdfDocumentId,
    _i6.RecurrenceInterval? recurrenceInterval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
    int? recurrenceOccurrencesCreated,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         businessId: businessId,
         number: number,
         type: type,
         status: status,
         customerId: customerId,
         issueDate: issueDate,
         dueDate: dueDate,
         serviceDateFrom: serviceDateFrom,
         serviceDateTo: serviceDateTo,
         locale: locale,
         currency: currency,
         subtotalCents: subtotalCents,
         vatTotalCents: vatTotalCents,
         totalCents: totalCents,
         paymentTermsDays: paymentTermsDays,
         dunningLevel: dunningLevel,
         notes: notes,
         templateId: templateId,
         pdfDocumentId: pdfDocumentId,
         recurrenceInterval: recurrenceInterval,
         nextRecurrenceDate: nextRecurrenceDate,
         recurrenceEndDate: recurrenceEndDate,
         recurrenceMaxOccurrences: recurrenceMaxOccurrences,
         recurrenceOccurrencesCreated: recurrenceOccurrencesCreated,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Invoice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Invoice copyWith({
    Object? id = _Undefined,
    int? businessId,
    String? number,
    _i2.InvoiceType? type,
    _i3.InvoiceStatus? status,
    Object? customerId = _Undefined,
    DateTime? issueDate,
    Object? dueDate = _Undefined,
    Object? serviceDateFrom = _Undefined,
    Object? serviceDateTo = _Undefined,
    _i4.Locale? locale,
    _i5.Currency? currency,
    int? subtotalCents,
    int? vatTotalCents,
    int? totalCents,
    int? paymentTermsDays,
    int? dunningLevel,
    Object? notes = _Undefined,
    Object? templateId = _Undefined,
    Object? pdfDocumentId = _Undefined,
    Object? recurrenceInterval = _Undefined,
    Object? nextRecurrenceDate = _Undefined,
    Object? recurrenceEndDate = _Undefined,
    Object? recurrenceMaxOccurrences = _Undefined,
    int? recurrenceOccurrencesCreated,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Invoice(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      number: number ?? this.number,
      type: type ?? this.type,
      status: status ?? this.status,
      customerId: customerId is int? ? customerId : this.customerId,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate is DateTime? ? dueDate : this.dueDate,
      serviceDateFrom: serviceDateFrom is DateTime?
          ? serviceDateFrom
          : this.serviceDateFrom,
      serviceDateTo: serviceDateTo is DateTime?
          ? serviceDateTo
          : this.serviceDateTo,
      locale: locale ?? this.locale,
      currency: currency ?? this.currency,
      subtotalCents: subtotalCents ?? this.subtotalCents,
      vatTotalCents: vatTotalCents ?? this.vatTotalCents,
      totalCents: totalCents ?? this.totalCents,
      paymentTermsDays: paymentTermsDays ?? this.paymentTermsDays,
      dunningLevel: dunningLevel ?? this.dunningLevel,
      notes: notes is String? ? notes : this.notes,
      templateId: templateId is int? ? templateId : this.templateId,
      pdfDocumentId: pdfDocumentId is int? ? pdfDocumentId : this.pdfDocumentId,
      recurrenceInterval: recurrenceInterval is _i6.RecurrenceInterval?
          ? recurrenceInterval
          : this.recurrenceInterval,
      nextRecurrenceDate: nextRecurrenceDate is DateTime?
          ? nextRecurrenceDate
          : this.nextRecurrenceDate,
      recurrenceEndDate: recurrenceEndDate is DateTime?
          ? recurrenceEndDate
          : this.recurrenceEndDate,
      recurrenceMaxOccurrences: recurrenceMaxOccurrences is int?
          ? recurrenceMaxOccurrences
          : this.recurrenceMaxOccurrences,
      recurrenceOccurrencesCreated:
          recurrenceOccurrencesCreated ?? this.recurrenceOccurrencesCreated,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
