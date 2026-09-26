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

abstract class RateLimitException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  RateLimitException._({
    required this.message,
    this.retryAfterSeconds,
  });

  factory RateLimitException({
    required String message,
    int? retryAfterSeconds,
  }) = _RateLimitExceptionImpl;

  factory RateLimitException.fromJson(Map<String, dynamic> jsonSerialization) {
    return RateLimitException(
      message: jsonSerialization['message'] as String,
      retryAfterSeconds: jsonSerialization['retryAfterSeconds'] as int?,
    );
  }

  String message;

  int? retryAfterSeconds;

  /// Returns a shallow copy of this [RateLimitException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RateLimitException copyWith({
    String? message,
    int? retryAfterSeconds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RateLimitException',
      'message': message,
      if (retryAfterSeconds != null) 'retryAfterSeconds': retryAfterSeconds,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RateLimitException',
      'message': message,
      if (retryAfterSeconds != null) 'retryAfterSeconds': retryAfterSeconds,
    };
  }

  @override
  String toString() {
    return 'RateLimitException(message: $message, retryAfterSeconds: $retryAfterSeconds)';
  }
}

class _Undefined {}

class _RateLimitExceptionImpl extends RateLimitException {
  _RateLimitExceptionImpl({
    required String message,
    int? retryAfterSeconds,
  }) : super._(
         message: message,
         retryAfterSeconds: retryAfterSeconds,
       );

  /// Returns a shallow copy of this [RateLimitException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RateLimitException copyWith({
    String? message,
    Object? retryAfterSeconds = _Undefined,
  }) {
    return RateLimitException(
      message: message ?? this.message,
      retryAfterSeconds: retryAfterSeconds is int?
          ? retryAfterSeconds
          : this.retryAfterSeconds,
    );
  }
}
