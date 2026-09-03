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
import '../../../core/admin/admin_role.dart' as _isyiaiss;

abstract class AdminUserSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AdminUserSummary._({
    required this.userId,
    this.email,
    this.displayName,
    required this.blocked,
    required this.emailConfirmed,
    this.globalRole,
    this.profileCreatedAt,
    this.deletedAt,
  });

  factory AdminUserSummary({
    required _is.UuidValue userId,
    String? email,
    String? displayName,
    required bool blocked,
    required bool emailConfirmed,
    _isyiaiss.AdminRole? globalRole,
    DateTime? profileCreatedAt,
    DateTime? deletedAt,
  }) = _AdminUserSummaryImpl;

  factory AdminUserSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminUserSummary(
      userId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      email: jsonSerialization['email'] as String?,
      displayName: jsonSerialization['displayName'] as String?,
      blocked: _is.BoolJsonExtension.fromJson(jsonSerialization['blocked']),
      emailConfirmed: _is.BoolJsonExtension.fromJson(
        jsonSerialization['emailConfirmed'],
      ),
      globalRole: jsonSerialization['globalRole'] == null
          ? null
          : _isyiaiss.AdminRole.fromJson(
              (jsonSerialization['globalRole'] as String),
            ),
      profileCreatedAt: jsonSerialization['profileCreatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['profileCreatedAt'],
            ),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  _is.UuidValue userId;

  String? email;

  String? displayName;

  bool blocked;

  bool emailConfirmed;

  /// Global role from the `admin_user` allowlist (`null` = regular user).
  _isyiaiss.AdminRole? globalRole;

  DateTime? profileCreatedAt;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [AdminUserSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminUserSummary copyWith({
    _is.UuidValue? userId,
    String? email,
    String? displayName,
    bool? blocked,
    bool? emailConfirmed,
    _isyiaiss.AdminRole? globalRole,
    DateTime? profileCreatedAt,
    DateTime? deletedAt,
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
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminUserSummaryImpl extends AdminUserSummary {
  _AdminUserSummaryImpl({
    required _is.UuidValue userId,
    String? email,
    String? displayName,
    required bool blocked,
    required bool emailConfirmed,
    _isyiaiss.AdminRole? globalRole,
    DateTime? profileCreatedAt,
    DateTime? deletedAt,
  }) : super._(
         userId: userId,
         email: email,
         displayName: displayName,
         blocked: blocked,
         emailConfirmed: emailConfirmed,
         globalRole: globalRole,
         profileCreatedAt: profileCreatedAt,
         deletedAt: deletedAt,
       );

  /// Returns a shallow copy of this [AdminUserSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminUserSummary copyWith({
    _is.UuidValue? userId,
    Object? email = _Undefined,
    Object? displayName = _Undefined,
    bool? blocked,
    bool? emailConfirmed,
    Object? globalRole = _Undefined,
    Object? profileCreatedAt = _Undefined,
    Object? deletedAt = _Undefined,
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
      profileCreatedAt: profileCreatedAt is DateTime?
          ? profileCreatedAt
          : this.profileCreatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
