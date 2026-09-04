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

import 'package:gewerber_backend_client/src/protocol/protocol.dart'
    as _iipbhyvd;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../../modules/business/models/currency.dart' as _i80byysb;
import '../../../modules/business/models/locale.dart' as _ie5v8zdc;
import '../../../modules/invoicing/models/invoice_item_request.dart'
    as _ife8od1f;
import '../../../modules/invoicing/models/invoice_type.dart' as _i4s57tlu;
import '../../../modules/invoicing/models/recurrence_interval.dart'
    as _i2jlpxj3;

abstract class CreateInvoiceRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CreateInvoiceRequest._({
    _i4s57tlu.InvoiceType? type,
    this.customerId,
    this.issueDate,
    this.dueDate,
    this.serviceDateFrom,
    this.serviceDateTo,
    this.paymentTermsDays,
    this.templateId,
    this.locale,
    this.currency,
    this.notes,
    this.recurrenceInterval,
    this.nextRecurrenceDate,
    this.recurrenceEndDate,
    this.recurrenceMaxOccurrences,
    required this.items,
  }) : type = type ?? _i4s57tlu.InvoiceType.invoice;

  factory CreateInvoiceRequest({
    _i4s57tlu.InvoiceType? type,
    int? customerId,
    DateTime? issueDate,
    DateTime? dueDate,
    DateTime? serviceDateFrom,
    DateTime? serviceDateTo,
    int? paymentTermsDays,
    int? templateId,
    _ie5v8zdc.Locale? locale,
    _i80byysb.Currency? currency,
    String? notes,
    _i2jlpxj3.RecurrenceInterval? recurrenceInterval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
    required List<_ife8od1f.InvoiceItemRequest> items,
  }) = _CreateInvoiceRequestImpl;

  factory CreateInvoiceRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateInvoiceRequest(
      type: jsonSerialization['type'] == null
          ? null
          : _i4s57tlu.InvoiceType.fromJson(
              (jsonSerialization['type'] as String),
            ),
      customerId: jsonSerialization['customerId'] as int?,
      issueDate: jsonSerialization['issueDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['issueDate']),
      dueDate: jsonSerialization['dueDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
      serviceDateFrom: jsonSerialization['serviceDateFrom'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['serviceDateFrom'],
            ),
      serviceDateTo: jsonSerialization['serviceDateTo'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['serviceDateTo'],
            ),
      paymentTermsDays: jsonSerialization['paymentTermsDays'] as int?,
      templateId: jsonSerialization['templateId'] as int?,
      locale: jsonSerialization['locale'] == null
          ? null
          : _ie5v8zdc.Locale.fromJson((jsonSerialization['locale'] as String)),
      currency: jsonSerialization['currency'] == null
          ? null
          : _i80byysb.Currency.fromJson(
              (jsonSerialization['currency'] as String),
            ),
      notes: jsonSerialization['notes'] as String?,
      recurrenceInterval: jsonSerialization['recurrenceInterval'] == null
          ? null
          : _i2jlpxj3.RecurrenceInterval.fromJson(
              (jsonSerialization['recurrenceInterval'] as String),
            ),
      nextRecurrenceDate: jsonSerialization['nextRecurrenceDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['nextRecurrenceDate'],
            ),
      recurrenceEndDate: jsonSerialization['recurrenceEndDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['recurrenceEndDate'],
            ),
      recurrenceMaxOccurrences:
          jsonSerialization['recurrenceMaxOccurrences'] as int?,
      items: _iipbhyvd.Protocol()
          .deserialize<List<_ife8od1f.InvoiceItemRequest>>(
            jsonSerialization['items'],
          ),
    );
  }

  _i4s57tlu.InvoiceType type;

  int? customerId;

  DateTime? issueDate;

  DateTime? dueDate;

  DateTime? serviceDateFrom;

  DateTime? serviceDateTo;

  int? paymentTermsDays;

  int? templateId;

  _ie5v8zdc.Locale? locale;

  _i80byysb.Currency? currency;

  String? notes;

  _i2jlpxj3.RecurrenceInterval? recurrenceInterval;

  DateTime? nextRecurrenceDate;

  DateTime? recurrenceEndDate;

  int? recurrenceMaxOccurrences;

  List<_ife8od1f.InvoiceItemRequest> items;

  /// Returns a shallow copy of this [CreateInvoiceRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CreateInvoiceRequest copyWith({
    _i4s57tlu.InvoiceType? type,
    int? customerId,
    DateTime? issueDate,
    DateTime? dueDate,
    DateTime? serviceDateFrom,
    DateTime? serviceDateTo,
    int? paymentTermsDays,
    int? templateId,
    _ie5v8zdc.Locale? locale,
    _i80byysb.Currency? currency,
    String? notes,
    _i2jlpxj3.RecurrenceInterval? recurrenceInterval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
    List<_ife8od1f.InvoiceItemRequest>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateInvoiceRequest',
      'type': type.toJson(),
      if (customerId != null) 'customerId': customerId,
      if (issueDate != null) 'issueDate': issueDate?.toJson(),
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      if (serviceDateFrom != null) 'serviceDateFrom': serviceDateFrom?.toJson(),
      if (serviceDateTo != null) 'serviceDateTo': serviceDateTo?.toJson(),
      if (paymentTermsDays != null) 'paymentTermsDays': paymentTermsDays,
      if (templateId != null) 'templateId': templateId,
      if (locale != null) 'locale': locale?.toJson(),
      if (currency != null) 'currency': currency?.toJson(),
      if (notes != null) 'notes': notes,
      if (recurrenceInterval != null)
        'recurrenceInterval': recurrenceInterval?.toJson(),
      if (nextRecurrenceDate != null)
        'nextRecurrenceDate': nextRecurrenceDate?.toJson(),
      if (recurrenceEndDate != null)
        'recurrenceEndDate': recurrenceEndDate?.toJson(),
      if (recurrenceMaxOccurrences != null)
        'recurrenceMaxOccurrences': recurrenceMaxOccurrences,
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreateInvoiceRequest',
      'type': type.toJson(),
      if (customerId != null) 'customerId': customerId,
      if (issueDate != null) 'issueDate': issueDate?.toJson(),
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      if (serviceDateFrom != null) 'serviceDateFrom': serviceDateFrom?.toJson(),
      if (serviceDateTo != null) 'serviceDateTo': serviceDateTo?.toJson(),
      if (paymentTermsDays != null) 'paymentTermsDays': paymentTermsDays,
      if (templateId != null) 'templateId': templateId,
      if (locale != null) 'locale': locale?.toJson(),
      if (currency != null) 'currency': currency?.toJson(),
      if (notes != null) 'notes': notes,
      if (recurrenceInterval != null)
        'recurrenceInterval': recurrenceInterval?.toJson(),
      if (nextRecurrenceDate != null)
        'nextRecurrenceDate': nextRecurrenceDate?.toJson(),
      if (recurrenceEndDate != null)
        'recurrenceEndDate': recurrenceEndDate?.toJson(),
      if (recurrenceMaxOccurrences != null)
        'recurrenceMaxOccurrences': recurrenceMaxOccurrences,
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateInvoiceRequestImpl extends CreateInvoiceRequest {
  _CreateInvoiceRequestImpl({
    _i4s57tlu.InvoiceType? type,
    int? customerId,
    DateTime? issueDate,
    DateTime? dueDate,
    DateTime? serviceDateFrom,
    DateTime? serviceDateTo,
    int? paymentTermsDays,
    int? templateId,
    _ie5v8zdc.Locale? locale,
    _i80byysb.Currency? currency,
    String? notes,
    _i2jlpxj3.RecurrenceInterval? recurrenceInterval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
    required List<_ife8od1f.InvoiceItemRequest> items,
  }) : super._(
         type: type,
         customerId: customerId,
         issueDate: issueDate,
         dueDate: dueDate,
         serviceDateFrom: serviceDateFrom,
         serviceDateTo: serviceDateTo,
         paymentTermsDays: paymentTermsDays,
         templateId: templateId,
         locale: locale,
         currency: currency,
         notes: notes,
         recurrenceInterval: recurrenceInterval,
         nextRecurrenceDate: nextRecurrenceDate,
         recurrenceEndDate: recurrenceEndDate,
         recurrenceMaxOccurrences: recurrenceMaxOccurrences,
         items: items,
       );

  /// Returns a shallow copy of this [CreateInvoiceRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CreateInvoiceRequest copyWith({
    _i4s57tlu.InvoiceType? type,
    Object? customerId = _Undefined,
    Object? issueDate = _Undefined,
    Object? dueDate = _Undefined,
    Object? serviceDateFrom = _Undefined,
    Object? serviceDateTo = _Undefined,
    Object? paymentTermsDays = _Undefined,
    Object? templateId = _Undefined,
    Object? locale = _Undefined,
    Object? currency = _Undefined,
    Object? notes = _Undefined,
    Object? recurrenceInterval = _Undefined,
    Object? nextRecurrenceDate = _Undefined,
    Object? recurrenceEndDate = _Undefined,
    Object? recurrenceMaxOccurrences = _Undefined,
    List<_ife8od1f.InvoiceItemRequest>? items,
  }) {
    return CreateInvoiceRequest(
      type: type ?? this.type,
      customerId: customerId is int? ? customerId : this.customerId,
      issueDate: issueDate is DateTime? ? issueDate : this.issueDate,
      dueDate: dueDate is DateTime? ? dueDate : this.dueDate,
      serviceDateFrom: serviceDateFrom is DateTime?
          ? serviceDateFrom
          : this.serviceDateFrom,
      serviceDateTo: serviceDateTo is DateTime?
          ? serviceDateTo
          : this.serviceDateTo,
      paymentTermsDays: paymentTermsDays is int?
          ? paymentTermsDays
          : this.paymentTermsDays,
      templateId: templateId is int? ? templateId : this.templateId,
      locale: locale is _ie5v8zdc.Locale? ? locale : this.locale,
      currency: currency is _i80byysb.Currency? ? currency : this.currency,
      notes: notes is String? ? notes : this.notes,
      recurrenceInterval: recurrenceInterval is _i2jlpxj3.RecurrenceInterval?
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
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
