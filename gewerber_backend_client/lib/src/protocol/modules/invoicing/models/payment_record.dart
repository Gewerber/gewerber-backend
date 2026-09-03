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

abstract class PaymentRecord
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PaymentRecord._({
    this.id,
    required this.invoiceId,
    DateTime? paidAt,
    required this.amountCents,
    _idng401x.PaymentMethod? method,
    this.reference,
    DateTime? createdAt,
  }) : paidAt = paidAt ?? DateTime.now(),
       method = method ?? _idng401x.PaymentMethod.bankTransfer,
       createdAt = createdAt ?? DateTime.now();

  factory PaymentRecord({
    int? id,
    required int invoiceId,
    DateTime? paidAt,
    required int amountCents,
    _idng401x.PaymentMethod? method,
    String? reference,
    DateTime? createdAt,
  }) = _PaymentRecordImpl;

  factory PaymentRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return PaymentRecord(
      id: jsonSerialization['id'] as int?,
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
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int invoiceId;

  DateTime paidAt;

  int amountCents;

  _idng401x.PaymentMethod method;

  String? reference;

  DateTime createdAt;

  /// Returns a shallow copy of this [PaymentRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PaymentRecord copyWith({
    int? id,
    int? invoiceId,
    DateTime? paidAt,
    int? amountCents,
    _idng401x.PaymentMethod? method,
    String? reference,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PaymentRecord',
      if (id != null) 'id': id,
      'invoiceId': invoiceId,
      'paidAt': paidAt.toJson(),
      'amountCents': amountCents,
      'method': method.toJson(),
      if (reference != null) 'reference': reference,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PaymentRecord',
      if (id != null) 'id': id,
      'invoiceId': invoiceId,
      'paidAt': paidAt.toJson(),
      'amountCents': amountCents,
      'method': method.toJson(),
      if (reference != null) 'reference': reference,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PaymentRecordImpl extends PaymentRecord {
  _PaymentRecordImpl({
    int? id,
    required int invoiceId,
    DateTime? paidAt,
    required int amountCents,
    _idng401x.PaymentMethod? method,
    String? reference,
    DateTime? createdAt,
  }) : super._(
         id: id,
         invoiceId: invoiceId,
         paidAt: paidAt,
         amountCents: amountCents,
         method: method,
         reference: reference,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [PaymentRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PaymentRecord copyWith({
    Object? id = _Undefined,
    int? invoiceId,
    DateTime? paidAt,
    int? amountCents,
    _idng401x.PaymentMethod? method,
    Object? reference = _Undefined,
    DateTime? createdAt,
  }) {
    return PaymentRecord(
      id: id is int? ? id : this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      paidAt: paidAt ?? this.paidAt,
      amountCents: amountCents ?? this.amountCents,
      method: method ?? this.method,
      reference: reference is String? ? reference : this.reference,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
