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

import 'package:gewerber_backend_server/src/generated/protocol.dart'
    as _itzp2rm6;
import 'package:serverpod/serverpod.dart' as _is;
import '../../../modules/invoicing/models/invoice_item_request.dart'
    as _ife8od1f;
import '../../../modules/invoicing/models/recurrence_interval.dart'
    as _i2jlpxj3;

abstract class UpdateInvoiceRequest
    implements _is.SerializableModel, _is.ProtocolSerialization {
  UpdateInvoiceRequest._({
    required this.invoiceId,
    this.customerId,
    required this.issueDate,
    this.dueDate,
    this.serviceDateFrom,
    this.serviceDateTo,
    required this.paymentTermsDays,
    this.templateId,
    this.notes,
    this.recurrenceInterval,
    this.nextRecurrenceDate,
    this.recurrenceEndDate,
    this.recurrenceMaxOccurrences,
    required this.items,
  });

  factory UpdateInvoiceRequest({
    required int invoiceId,
    int? customerId,
    required DateTime issueDate,
    DateTime? dueDate,
    DateTime? serviceDateFrom,
    DateTime? serviceDateTo,
    required int paymentTermsDays,
    int? templateId,
    String? notes,
    _i2jlpxj3.RecurrenceInterval? recurrenceInterval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
    required List<_ife8od1f.InvoiceItemRequest> items,
  }) = _UpdateInvoiceRequestImpl;

  factory UpdateInvoiceRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UpdateInvoiceRequest(
      invoiceId: jsonSerialization['invoiceId'] as int,
      customerId: jsonSerialization['customerId'] as int?,
      issueDate: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['issueDate'],
      ),
      dueDate: jsonSerialization['dueDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['dueDate']),
      serviceDateFrom: jsonSerialization['serviceDateFrom'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['serviceDateFrom'],
            ),
      serviceDateTo: jsonSerialization['serviceDateTo'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['serviceDateTo'],
            ),
      paymentTermsDays: jsonSerialization['paymentTermsDays'] as int,
      templateId: jsonSerialization['templateId'] as int?,
      notes: jsonSerialization['notes'] as String?,
      recurrenceInterval: jsonSerialization['recurrenceInterval'] == null
          ? null
          : _i2jlpxj3.RecurrenceInterval.fromJson(
              (jsonSerialization['recurrenceInterval'] as String),
            ),
      nextRecurrenceDate: jsonSerialization['nextRecurrenceDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['nextRecurrenceDate'],
            ),
      recurrenceEndDate: jsonSerialization['recurrenceEndDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['recurrenceEndDate'],
            ),
      recurrenceMaxOccurrences:
          jsonSerialization['recurrenceMaxOccurrences'] as int?,
      items: _itzp2rm6.Protocol()
          .deserialize<List<_ife8od1f.InvoiceItemRequest>>(
            jsonSerialization['items'],
          ),
    );
  }

  int invoiceId;

  int? customerId;

  DateTime issueDate;

  DateTime? dueDate;

  DateTime? serviceDateFrom;

  DateTime? serviceDateTo;

  int paymentTermsDays;

  int? templateId;

  String? notes;

  _i2jlpxj3.RecurrenceInterval? recurrenceInterval;

  DateTime? nextRecurrenceDate;

  DateTime? recurrenceEndDate;

  int? recurrenceMaxOccurrences;

  List<_ife8od1f.InvoiceItemRequest> items;

  /// Returns a shallow copy of this [UpdateInvoiceRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UpdateInvoiceRequest copyWith({
    int? invoiceId,
    int? customerId,
    DateTime? issueDate,
    DateTime? dueDate,
    DateTime? serviceDateFrom,
    DateTime? serviceDateTo,
    int? paymentTermsDays,
    int? templateId,
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
      '__className__': 'UpdateInvoiceRequest',
      'invoiceId': invoiceId,
      if (customerId != null) 'customerId': customerId,
      'issueDate': issueDate.toJson(),
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      if (serviceDateFrom != null) 'serviceDateFrom': serviceDateFrom?.toJson(),
      if (serviceDateTo != null) 'serviceDateTo': serviceDateTo?.toJson(),
      'paymentTermsDays': paymentTermsDays,
      if (templateId != null) 'templateId': templateId,
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
      '__className__': 'UpdateInvoiceRequest',
      'invoiceId': invoiceId,
      if (customerId != null) 'customerId': customerId,
      'issueDate': issueDate.toJson(),
      if (dueDate != null) 'dueDate': dueDate?.toJson(),
      if (serviceDateFrom != null) 'serviceDateFrom': serviceDateFrom?.toJson(),
      if (serviceDateTo != null) 'serviceDateTo': serviceDateTo?.toJson(),
      'paymentTermsDays': paymentTermsDays,
      if (templateId != null) 'templateId': templateId,
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
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UpdateInvoiceRequestImpl extends UpdateInvoiceRequest {
  _UpdateInvoiceRequestImpl({
    required int invoiceId,
    int? customerId,
    required DateTime issueDate,
    DateTime? dueDate,
    DateTime? serviceDateFrom,
    DateTime? serviceDateTo,
    required int paymentTermsDays,
    int? templateId,
    String? notes,
    _i2jlpxj3.RecurrenceInterval? recurrenceInterval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
    required List<_ife8od1f.InvoiceItemRequest> items,
  }) : super._(
         invoiceId: invoiceId,
         customerId: customerId,
         issueDate: issueDate,
         dueDate: dueDate,
         serviceDateFrom: serviceDateFrom,
         serviceDateTo: serviceDateTo,
         paymentTermsDays: paymentTermsDays,
         templateId: templateId,
         notes: notes,
         recurrenceInterval: recurrenceInterval,
         nextRecurrenceDate: nextRecurrenceDate,
         recurrenceEndDate: recurrenceEndDate,
         recurrenceMaxOccurrences: recurrenceMaxOccurrences,
         items: items,
       );

  /// Returns a shallow copy of this [UpdateInvoiceRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UpdateInvoiceRequest copyWith({
    int? invoiceId,
    Object? customerId = _Undefined,
    DateTime? issueDate,
    Object? dueDate = _Undefined,
    Object? serviceDateFrom = _Undefined,
    Object? serviceDateTo = _Undefined,
    int? paymentTermsDays,
    Object? templateId = _Undefined,
    Object? notes = _Undefined,
    Object? recurrenceInterval = _Undefined,
    Object? nextRecurrenceDate = _Undefined,
    Object? recurrenceEndDate = _Undefined,
    Object? recurrenceMaxOccurrences = _Undefined,
    List<_ife8od1f.InvoiceItemRequest>? items,
  }) {
    return UpdateInvoiceRequest(
      invoiceId: invoiceId ?? this.invoiceId,
      customerId: customerId is int? ? customerId : this.customerId,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate is DateTime? ? dueDate : this.dueDate,
      serviceDateFrom: serviceDateFrom is DateTime?
          ? serviceDateFrom
          : this.serviceDateFrom,
      serviceDateTo: serviceDateTo is DateTime?
          ? serviceDateTo
          : this.serviceDateTo,
      paymentTermsDays: paymentTermsDays ?? this.paymentTermsDays,
      templateId: templateId is int? ? templateId : this.templateId,
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
