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
import 'package:gewerber_backend_server/src/generated/protocol.dart'
    as _itzp2rm6;
import 'package:serverpod/serverpod.dart' as _is;

import '../../../modules/user/models/auth_provider.dart' as _imjnn7ac;

/// Authentication-level state of a user as seen by the admin API.
/// Provider-agnostic: the address and its verification state come from the
/// user's strongest identity (email IdP, then Google, Apple, Microsoft,
/// Facebook), so users who only sign in through a social provider are reported
/// too. `providers` lists the social providers holding an account row.
abstract class AdminAuthStatus
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AdminAuthStatus._({
    required this.blocked,
    required this.emailConfirmed,
    this.email,
    this.authUserCreatedAt,
    required this.providers,
  });

  factory AdminAuthStatus({
    required bool blocked,
    required bool emailConfirmed,
    String? email,
    DateTime? authUserCreatedAt,
    required List<_imjnn7ac.AuthProvider> providers,
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
      providers: _itzp2rm6.Protocol().deserialize<List<_imjnn7ac.AuthProvider>>(
        jsonSerialization['providers'],
      ),
    );
  }

  bool blocked;

  /// Whether ownership of `email` is confirmed. The email IdP is confirmed by
  /// construction (the row only exists after the registration challenge), as
  /// are Google and Microsoft; Apple mirrors `isEmailVerified`; Facebook does
  /// not confirm ownership.
  bool emailConfirmed;

  /// Address of the strongest identity, or `null` when none supplied one.
  String? email;

  DateTime? authUserCreatedAt;

  /// Social providers holding an account row for this user, in enum
  /// declaration order. The email IdP is never listed.
  List<_imjnn7ac.AuthProvider> providers;

  /// Returns a shallow copy of this [AdminAuthStatus]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminAuthStatus copyWith({
    bool? blocked,
    bool? emailConfirmed,
    String? email,
    DateTime? authUserCreatedAt = const _is.$UndefinedDateTime(),
    List<_imjnn7ac.AuthProvider>? providers,
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
      'providers': providers.toJson(valueToJson: (v) => v.toJson()),
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
      'providers': providers.toJson(valueToJson: (v) => v.toJson()),
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
    required List<_imjnn7ac.AuthProvider> providers,
  }) : super._(
         blocked: blocked,
         emailConfirmed: emailConfirmed,
         email: email,
         authUserCreatedAt: authUserCreatedAt,
         providers: providers,
       );

  /// Returns a shallow copy of this [AdminAuthStatus]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminAuthStatus copyWith({
    bool? blocked,
    bool? emailConfirmed,
    Object? email = _Undefined,
    DateTime? authUserCreatedAt = const _is.$UndefinedDateTime(),
    List<_imjnn7ac.AuthProvider>? providers,
  }) {
    return AdminAuthStatus(
      blocked: blocked ?? this.blocked,
      emailConfirmed: emailConfirmed ?? this.emailConfirmed,
      email: email is String? ? email : this.email,
      authUserCreatedAt: authUserCreatedAt is _is.UndefinedSentinel
          ? this.authUserCreatedAt
          : authUserCreatedAt,
      providers: providers ?? this.providers.map((e0) => e0).toList(),
    );
  }
}
