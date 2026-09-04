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
import '../../../modules/invoicing/models/payment_record.dart' as _in9an6e0;

abstract class InvoicePaymentStatus
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  InvoicePaymentStatus._({
    required this.invoiceId,
    required this.paidTotalCents,
    required this.remainingCents,
    required this.isPaid,
    required this.payments,
  });

  factory InvoicePaymentStatus({
    required int invoiceId,
    required int paidTotalCents,
    required int remainingCents,
    required bool isPaid,
    required List<_in9an6e0.PaymentRecord> payments,
  }) = _InvoicePaymentStatusImpl;

  factory InvoicePaymentStatus.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return InvoicePaymentStatus(
      invoiceId: jsonSerialization['invoiceId'] as int,
      paidTotalCents: jsonSerialization['paidTotalCents'] as int,
      remainingCents: jsonSerialization['remainingCents'] as int,
      isPaid: _isc.BoolJsonExtension.fromJson(jsonSerialization['isPaid']),
      payments: _iipbhyvd.Protocol().deserialize<List<_in9an6e0.PaymentRecord>>(
        jsonSerialization['payments'],
      ),
    );
  }

  int invoiceId;

  int paidTotalCents;

  int remainingCents;

  bool isPaid;

  List<_in9an6e0.PaymentRecord> payments;

  /// Returns a shallow copy of this [InvoicePaymentStatus]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InvoicePaymentStatus copyWith({
    int? invoiceId,
    int? paidTotalCents,
    int? remainingCents,
    bool? isPaid,
    List<_in9an6e0.PaymentRecord>? payments,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvoicePaymentStatus',
      'invoiceId': invoiceId,
      'paidTotalCents': paidTotalCents,
      'remainingCents': remainingCents,
      'isPaid': isPaid,
      'payments': payments.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvoicePaymentStatus',
      'invoiceId': invoiceId,
      'paidTotalCents': paidTotalCents,
      'remainingCents': remainingCents,
      'isPaid': isPaid,
      'payments': payments.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _InvoicePaymentStatusImpl extends InvoicePaymentStatus {
  _InvoicePaymentStatusImpl({
    required int invoiceId,
    required int paidTotalCents,
    required int remainingCents,
    required bool isPaid,
    required List<_in9an6e0.PaymentRecord> payments,
  }) : super._(
         invoiceId: invoiceId,
         paidTotalCents: paidTotalCents,
         remainingCents: remainingCents,
         isPaid: isPaid,
         payments: payments,
       );

  /// Returns a shallow copy of this [InvoicePaymentStatus]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  InvoicePaymentStatus copyWith({
    int? invoiceId,
    int? paidTotalCents,
    int? remainingCents,
    bool? isPaid,
    List<_in9an6e0.PaymentRecord>? payments,
  }) {
    return InvoicePaymentStatus(
      invoiceId: invoiceId ?? this.invoiceId,
      paidTotalCents: paidTotalCents ?? this.paidTotalCents,
      remainingCents: remainingCents ?? this.remainingCents,
      isPaid: isPaid ?? this.isPaid,
      payments: payments ?? this.payments.map((e0) => e0.copyWith()).toList(),
    );
  }
}
