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

/// Authentication-level state of a user as seen by the admin API.
/// `emailConfirmed` reflects the email IdP contract of Serverpod 4 beta:
/// an `EmailAccount` row only exists after the registration verification
/// code was confirmed, so an existing account is always confirmed.
abstract class AdminAuthStatus
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AdminAuthStatus._({
    required this.blocked,
    required this.emailConfirmed,
    this.email,
    this.authUserCreatedAt,
  });

  factory AdminAuthStatus({
    required bool blocked,
    required bool emailConfirmed,
    String? email,
    DateTime? authUserCreatedAt,
  }) = _AdminAuthStatusImpl;

  factory AdminAuthStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminAuthStatus(
      blocked: _is.BoolJsonExtension.fromJson(jsonSerialization['blocked']),
      emailConfirmed: _is.BoolJsonExtension.fromJson(
        jsonSerialization['emailConfirmed'],
      ),
      email: jsonSerialization['email'] as String?,
      authUserCreatedAt: jsonSerialization['authUserCreatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['authUserCreatedAt'],
            ),
    );
  }

  bool blocked;

  bool emailConfirmed;

  String? email;

  DateTime? authUserCreatedAt;

  /// Returns a shallow copy of this [AdminAuthStatus]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminAuthStatus copyWith({
    bool? blocked,
    bool? emailConfirmed,
    String? email,
    DateTime? authUserCreatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminAuthStatus',
      'blocked': blocked,
      'emailConfirmed': emailConfirmed,
      if (email != null) 'email': email,
      if (authUserCreatedAt != null)
        'authUserCreatedAt': authUserCreatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminAuthStatus',
      'blocked': blocked,
      'emailConfirmed': emailConfirmed,
      if (email != null) 'email': email,
      if (authUserCreatedAt != null)
        'authUserCreatedAt': authUserCreatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminAuthStatusImpl extends AdminAuthStatus {
  _AdminAuthStatusImpl({
    required bool blocked,
    required bool emailConfirmed,
    String? email,
    DateTime? authUserCreatedAt,
  }) : super._(
         blocked: blocked,
         emailConfirmed: emailConfirmed,
         email: email,
         authUserCreatedAt: authUserCreatedAt,
       );

  /// Returns a shallow copy of this [AdminAuthStatus]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminAuthStatus copyWith({
    bool? blocked,
    bool? emailConfirmed,
    Object? email = _Undefined,
    Object? authUserCreatedAt = _Undefined,
  }) {
    return AdminAuthStatus(
      blocked: blocked ?? this.blocked,
      emailConfirmed: emailConfirmed ?? this.emailConfirmed,
      email: email is String? ? email : this.email,
      authUserCreatedAt: authUserCreatedAt is DateTime?
          ? authUserCreatedAt
          : this.authUserCreatedAt,
    );
  }
}
