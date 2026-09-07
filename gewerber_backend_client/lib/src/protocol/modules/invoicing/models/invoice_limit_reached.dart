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

abstract class InvoiceLimitReachedException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  InvoiceLimitReachedException._({
    required this.message,
    required this.limit,
  });

  factory InvoiceLimitReachedException({
    required String message,
    required int limit,
  }) = _InvoiceLimitReachedExceptionImpl;

  factory InvoiceLimitReachedException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return InvoiceLimitReachedException(
      message: jsonSerialization['message'] as String,
      limit: jsonSerialization['limit'] as int,
    );
  }

  String message;

  int limit;

  /// Returns a shallow copy of this [InvoiceLimitReachedException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InvoiceLimitReachedException copyWith({
    String? message,
    int? limit,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvoiceLimitReachedException',
      'message': message,
      'limit': limit,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvoiceLimitReachedException',
      'message': message,
      'limit': limit,
    };
  }

  @override
  String toString() {
    return 'InvoiceLimitReachedException(message: $message, limit: $limit)';
  }
}

class _InvoiceLimitReachedExceptionImpl extends InvoiceLimitReachedException {
  _InvoiceLimitReachedExceptionImpl({
    required String message,
    required int limit,
  }) : super._(
         message: message,
         limit: limit,
       );

  /// Returns a shallow copy of this [InvoiceLimitReachedException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  InvoiceLimitReachedException copyWith({
    String? message,
    int? limit,
  }) {
    return InvoiceLimitReachedException(
      message: message ?? this.message,
      limit: limit ?? this.limit,
    );
  }
}
