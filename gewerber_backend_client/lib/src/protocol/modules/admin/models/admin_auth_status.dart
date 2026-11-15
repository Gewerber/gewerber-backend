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

import '../../../modules/user/models/auth_provider.dart' as _imjnn7ac;

/// Authentication-level state of a user as seen by the admin API.
/// Provider-agnostic: the address and its verification state come from the
/// user's strongest identity (email IdP, then Google, Apple, Microsoft,
/// Facebook), so users who only sign in through a social provider are reported
/// too. `providers` lists the social providers holding an account row.
abstract class AdminAuthStatus
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      blocked: _isc.BoolJsonExtension.fromJson(jsonSerialization['blocked']),
      emailConfirmed: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['emailConfirmed'],
      ),
      email: jsonSerialization['email'] as String?,
      authUserCreatedAt: jsonSerialization['authUserCreatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['authUserCreatedAt'],
            ),
      providers: _iipbhyvd.Protocol().deserialize<List<_imjnn7ac.AuthProvider>>(
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
  @_isc.useResult
  AdminAuthStatus copyWith({
    bool? blocked,
    bool? emailConfirmed,
    String? email,
    DateTime? authUserCreatedAt = const _isc.$UndefinedDateTime(),
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
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
  @override
  AdminAuthStatus copyWith({
    bool? blocked,
    bool? emailConfirmed,
    Object? email = _Undefined,
    DateTime? authUserCreatedAt = const _isc.$UndefinedDateTime(),
    List<_imjnn7ac.AuthProvider>? providers,
  }) {
    return AdminAuthStatus(
      blocked: blocked ?? this.blocked,
      emailConfirmed: emailConfirmed ?? this.emailConfirmed,
      email: email is String? ? email : this.email,
      authUserCreatedAt: authUserCreatedAt is _isc.UndefinedSentinel
          ? this.authUserCreatedAt
          : authUserCreatedAt,
      providers: providers ?? this.providers.map((e0) => e0).toList(),
    );
  }
}
