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

import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../../modules/invoicing/models/payment_method.dart' as _idng401x;

abstract class RecordPaymentRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RecordPaymentRequest._({
    required this.invoiceId,
    this.paidAt,
    required this.amountCents,
    _idng401x.PaymentMethod? method,
    this.reference,
  }) : method = method ?? _idng401x.PaymentMethod.bankTransfer;

  factory RecordPaymentRequest({
    required int invoiceId,
    DateTime? paidAt,
    required int amountCents,
    _idng401x.PaymentMethod? method,
    String? reference,
  }) = _RecordPaymentRequestImpl;

  factory RecordPaymentRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return RecordPaymentRequest(
      invoiceId: jsonSerialization['invoiceId'] as int,
      paidAt: jsonSerialization['paidAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['paidAt']),
      amountCents: jsonSerialization['amountCents'] as int,
      method: jsonSerialization['method'] == null
          ? null
          : _idng401x.PaymentMethod.fromJson(
              (jsonSerialization['method'] as String),
            ),
      reference: jsonSerialization['reference'] as String?,
    );
  }

  int invoiceId;

  DateTime? paidAt;

  int amountCents;

  _idng401x.PaymentMethod method;

  String? reference;

  /// Returns a shallow copy of this [RecordPaymentRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RecordPaymentRequest copyWith({
    int? invoiceId,
    DateTime? paidAt,
    int? amountCents,
    _idng401x.PaymentMethod? method,
    String? reference,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RecordPaymentRequest',
      'invoiceId': invoiceId,
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      'amountCents': amountCents,
      'method': method.toJson(),
      if (reference != null) 'reference': reference,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RecordPaymentRequest',
      'invoiceId': invoiceId,
      if (paidAt != null) 'paidAt': paidAt?.toJson(),
      'amountCents': amountCents,
      'method': method.toJson(),
      if (reference != null) 'reference': reference,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RecordPaymentRequestImpl extends RecordPaymentRequest {
  _RecordPaymentRequestImpl({
    required int invoiceId,
    DateTime? paidAt,
    required int amountCents,
    _idng401x.PaymentMethod? method,
    String? reference,
  }) : super._(
         invoiceId: invoiceId,
         paidAt: paidAt,
         amountCents: amountCents,
         method: method,
         reference: reference,
       );

  /// Returns a shallow copy of this [RecordPaymentRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RecordPaymentRequest copyWith({
    int? invoiceId,
    Object? paidAt = _Undefined,
    int? amountCents,
    _idng401x.PaymentMethod? method,
    Object? reference = _Undefined,
  }) {
    return RecordPaymentRequest(
      invoiceId: invoiceId ?? this.invoiceId,
      paidAt: paidAt is DateTime? ? paidAt : this.paidAt,
      amountCents: amountCents ?? this.amountCents,
      method: method ?? this.method,
      reference: reference is String? ? reference : this.reference,
    );
  }
}
