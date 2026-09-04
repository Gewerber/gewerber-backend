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

abstract class ForbiddenException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  ForbiddenException._({this.message});

  factory ForbiddenException({String? message}) = _ForbiddenExceptionImpl;

  factory ForbiddenException.fromJson(Map<String, dynamic> jsonSerialization) {
    return ForbiddenException(message: jsonSerialization['message'] as String?);
  }

  String? message;

  /// Returns a shallow copy of this [ForbiddenException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ForbiddenException copyWith({String? message});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ForbiddenException',
      if (message != null) 'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ForbiddenException',
      if (message != null) 'message': message,
    };
  }

  @override
  String toString() {
    return 'ForbiddenException(message: $message)';
  }
}

class _Undefined {}

class _ForbiddenExceptionImpl extends ForbiddenException {
  _ForbiddenExceptionImpl({String? message}) : super._(message: message);

  /// Returns a shallow copy of this [ForbiddenException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ForbiddenException copyWith({Object? message = _Undefined}) {
    return ForbiddenException(
      message: message is String? ? message : this.message,
    );
  }
}
