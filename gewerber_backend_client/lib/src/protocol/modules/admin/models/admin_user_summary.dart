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

import '../../../core/admin/admin_role.dart' as _isyiaiss;
import '../../../modules/user/models/auth_provider.dart' as _imjnn7ac;

abstract class AdminUserSummary
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AdminUserSummary._({
    required this.userId,
    this.email,
    this.displayName,
    required this.blocked,
    required this.emailConfirmed,
    this.globalRole,
    this.profileCreatedAt,
    this.deletedAt,
    required this.connectedProviders,
  });

  factory AdminUserSummary({
    required _isc.UuidValue userId,
    String? email,
    String? displayName,
    required bool blocked,
    required bool emailConfirmed,
    _isyiaiss.AdminRole? globalRole,
    DateTime? profileCreatedAt,
    DateTime? deletedAt,
    required List<_imjnn7ac.AuthProvider> connectedProviders,
  }) = _AdminUserSummaryImpl;

  factory AdminUserSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminUserSummary(
      userId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      email: jsonSerialization['email'] as String?,
      displayName: jsonSerialization['displayName'] as String?,
      blocked: _isc.BoolJsonExtension.fromJson(jsonSerialization['blocked']),
      emailConfirmed: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['emailConfirmed'],
      ),
      globalRole: jsonSerialization['globalRole'] == null
          ? null
          : _isyiaiss.AdminRole.fromJson(
              (jsonSerialization['globalRole'] as String),
            ),
      profileCreatedAt: jsonSerialization['profileCreatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['profileCreatedAt'],
            ),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
      connectedProviders: _iipbhyvd.Protocol()
          .deserialize<List<_imjnn7ac.AuthProvider>>(
            jsonSerialization['connectedProviders'],
          ),
    );
  }

  _isc.UuidValue userId;

  /// Display address resolved from the user's strongest identity (email IdP,
  /// then Google, Apple, Microsoft, Facebook). `null` when no identity carried
  /// an address; such users are not listed by the directory search.
  String? email;

  String? displayName;

  bool blocked;

  /// Whether ownership of `email` is confirmed: always true for the email IdP,
  /// Google and Microsoft, Apple's `isEmailVerified` claim, and false for
  /// Facebook (profile address, not verified).
  bool emailConfirmed;

  /// Global role from the `admin_user` allowlist (`null` = regular user).
  _isyiaiss.AdminRole? globalRole;

  DateTime? profileCreatedAt;

  DateTime? deletedAt;

  /// Social providers holding an account row for this user, in enum
  /// declaration order. The email IdP is not a social provider and is never
  /// listed here.
  List<_imjnn7ac.AuthProvider> connectedProviders;

  /// Returns a shallow copy of this [AdminUserSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AdminUserSummary copyWith({
    _isc.UuidValue? userId,
    String? email,
    String? displayName,
    bool? blocked,
    bool? emailConfirmed,
    _isyiaiss.AdminRole? globalRole,
    DateTime? profileCreatedAt = const _isc.$UndefinedDateTime(),
    DateTime? deletedAt = const _isc.$UndefinedDateTime(),
    List<_imjnn7ac.AuthProvider>? connectedProviders,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminUserSummary',
      'userId': userId.toJson(),
      if (email != null) 'email': email,
      if (displayName != null) 'displayName': displayName,
      'blocked': blocked,
      'emailConfirmed': emailConfirmed,
      if (globalRole != null) 'globalRole': globalRole?.toJson(),
      if (profileCreatedAt != null)
        'profileCreatedAt': profileCreatedAt?.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
      'connectedProviders': connectedProviders.toJson(
        valueToJson: (v) => v.toJson(),
      ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminUserSummary',
      'userId': userId.toJson(),
      if (email != null) 'email': email,
      if (displayName != null) 'displayName': displayName,
      'blocked': blocked,
      'emailConfirmed': emailConfirmed,
      if (globalRole != null) 'globalRole': globalRole?.toJson(),
      if (profileCreatedAt != null)
        'profileCreatedAt': profileCreatedAt?.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
      'connectedProviders': connectedProviders.toJson(
        valueToJson: (v) => v.toJson(),
      ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminUserSummaryImpl extends AdminUserSummary {
  _AdminUserSummaryImpl({
    required _isc.UuidValue userId,
    String? email,
    String? displayName,
    required bool blocked,
    required bool emailConfirmed,
    _isyiaiss.AdminRole? globalRole,
    DateTime? profileCreatedAt,
    DateTime? deletedAt,
    required List<_imjnn7ac.AuthProvider> connectedProviders,
  }) : super._(
         userId: userId,
         email: email,
         displayName: displayName,
         blocked: blocked,
         emailConfirmed: emailConfirmed,
         globalRole: globalRole,
         profileCreatedAt: profileCreatedAt,
         deletedAt: deletedAt,
         connectedProviders: connectedProviders,
       );

  /// Returns a shallow copy of this [AdminUserSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AdminUserSummary copyWith({
    _isc.UuidValue? userId,
    Object? email = _Undefined,
    Object? displayName = _Undefined,
    bool? blocked,
    bool? emailConfirmed,
    Object? globalRole = _Undefined,
    DateTime? profileCreatedAt = const _isc.$UndefinedDateTime(),
    DateTime? deletedAt = const _isc.$UndefinedDateTime(),
    List<_imjnn7ac.AuthProvider>? connectedProviders,
  }) {
    return AdminUserSummary(
      userId: userId ?? this.userId,
      email: email is String? ? email : this.email,
      displayName: displayName is String? ? displayName : this.displayName,
      blocked: blocked ?? this.blocked,
      emailConfirmed: emailConfirmed ?? this.emailConfirmed,
      globalRole: globalRole is _isyiaiss.AdminRole?
          ? globalRole
          : this.globalRole,
      profileCreatedAt: profileCreatedAt is _isc.UndefinedSentinel
          ? this.profileCreatedAt
          : profileCreatedAt,
      deletedAt: deletedAt is _isc.UndefinedSentinel
          ? this.deletedAt
          : deletedAt,
      connectedProviders:
          connectedProviders ??
          this.connectedProviders.map((e0) => e0).toList(),
    );
  }
}
