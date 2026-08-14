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
import 'package:serverpod/serverpod.dart' as _i1;
import '../../../modules/invoicing/models/payment_record.dart' as _i2;
import 'package:gewerber_backend_server/src/generated/protocol.dart' as _i3;

abstract class InvoicePaymentStatus
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
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
    required List<_i2.PaymentRecord> payments,
  }) = _InvoicePaymentStatusImpl;

  factory InvoicePaymentStatus.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return InvoicePaymentStatus(
      invoiceId: jsonSerialization['invoiceId'] as int,
      paidTotalCents: jsonSerialization['paidTotalCents'] as int,
      remainingCents: jsonSerialization['remainingCents'] as int,
      isPaid: _i1.BoolJsonExtension.fromJson(jsonSerialization['isPaid']),
      payments: _i3.Protocol().deserialize<List<_i2.PaymentRecord>>(
        jsonSerialization['payments'],
      ),
    );
  }

  int invoiceId;

  int paidTotalCents;

  int remainingCents;

  bool isPaid;

  List<_i2.PaymentRecord> payments;

  /// Returns a shallow copy of this [InvoicePaymentStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InvoicePaymentStatus copyWith({
    int? invoiceId,
    int? paidTotalCents,
    int? remainingCents,
    bool? isPaid,
    List<_i2.PaymentRecord>? payments,
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
    return _i1.SerializationManager.encode(this);
  }
}

class _InvoicePaymentStatusImpl extends InvoicePaymentStatus {
  _InvoicePaymentStatusImpl({
    required int invoiceId,
    required int paidTotalCents,
    required int remainingCents,
    required bool isPaid,
    required List<_i2.PaymentRecord> payments,
  }) : super._(
         invoiceId: invoiceId,
         paidTotalCents: paidTotalCents,
         remainingCents: remainingCents,
         isPaid: isPaid,
         payments: payments,
       );

  /// Returns a shallow copy of this [InvoicePaymentStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InvoicePaymentStatus copyWith({
    int? invoiceId,
    int? paidTotalCents,
    int? remainingCents,
    bool? isPaid,
    List<_i2.PaymentRecord>? payments,
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
