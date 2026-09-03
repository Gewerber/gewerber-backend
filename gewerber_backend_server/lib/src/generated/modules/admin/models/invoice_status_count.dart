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

import 'package:serverpod/serverpod.dart' as _is;
import '../../../modules/invoicing/models/invoice_status.dart' as _ib459vd4;

abstract class InvoiceStatusCount
    implements _is.SerializableModel, _is.ProtocolSerialization {
  InvoiceStatusCount._({
    required this.status,
    required this.count,
  });

  factory InvoiceStatusCount({
    required _ib459vd4.InvoiceStatus status,
    required int count,
  }) = _InvoiceStatusCountImpl;

  factory InvoiceStatusCount.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvoiceStatusCount(
      status: _ib459vd4.InvoiceStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      count: jsonSerialization['count'] as int,
    );
  }

  _ib459vd4.InvoiceStatus status;

  int count;

  /// Returns a shallow copy of this [InvoiceStatusCount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InvoiceStatusCount copyWith({
    _ib459vd4.InvoiceStatus? status,
    int? count,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvoiceStatusCount',
      'status': status.toJson(),
      'count': count,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvoiceStatusCount',
      'status': status.toJson(),
      'count': count,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _InvoiceStatusCountImpl extends InvoiceStatusCount {
  _InvoiceStatusCountImpl({
    required _ib459vd4.InvoiceStatus status,
    required int count,
  }) : super._(
         status: status,
         count: count,
       );

  /// Returns a shallow copy of this [InvoiceStatusCount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InvoiceStatusCount copyWith({
    _ib459vd4.InvoiceStatus? status,
    int? count,
  }) {
    return InvoiceStatusCount(
      status: status ?? this.status,
      count: count ?? this.count,
    );
  }
}
