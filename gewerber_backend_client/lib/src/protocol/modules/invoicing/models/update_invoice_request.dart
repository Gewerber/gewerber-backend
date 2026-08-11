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
import '../../../modules/invoicing/models/recurrence_rule.dart' as _i2;
import '../../../modules/invoicing/models/invoice_item_request.dart' as _i3;
import 'package:gewerber_backend_client/src/protocol/protocol.dart' as _i4;

abstract class UpdateInvoiceRequest implements _i1.SerializableModel {
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
    this.recurrence,
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
    _i2.RecurrenceRule? recurrence,
    required List<_i3.InvoiceItemRequest> items,
  }) = _UpdateInvoiceRequestImpl;

  factory UpdateInvoiceRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UpdateInvoiceRequest(
      invoiceId: jsonSerialization['invoiceId'] as int,
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
      paymentTermsDays: jsonSerialization['paymentTermsDays'] as int,
      templateId: jsonSerialization['templateId'] as int?,
      notes: jsonSerialization['notes'] as String?,
      recurrence: jsonSerialization['recurrence'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.RecurrenceRule>(
              jsonSerialization['recurrence'],
            ),
      items: _i4.Protocol().deserialize<List<_i3.InvoiceItemRequest>>(
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

  _i2.RecurrenceRule? recurrence;

  List<_i3.InvoiceItemRequest> items;

  /// Returns a shallow copy of this [UpdateInvoiceRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
    _i2.RecurrenceRule? recurrence,
    List<_i3.InvoiceItemRequest>? items,
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
      if (recurrence != null) 'recurrence': recurrence?.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
    _i2.RecurrenceRule? recurrence,
    required List<_i3.InvoiceItemRequest> items,
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
         recurrence: recurrence,
         items: items,
       );

  /// Returns a shallow copy of this [UpdateInvoiceRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
    Object? recurrence = _Undefined,
    List<_i3.InvoiceItemRequest>? items,
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
      recurrence: recurrence is _i2.RecurrenceRule?
          ? recurrence
          : this.recurrence?.copyWith(),
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
