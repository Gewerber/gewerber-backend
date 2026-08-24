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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../../core/admin/admin_role.dart' as _i2;

abstract class AdminUserSummary
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
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
    required _i1.UuidValue userId,
    String? email,
    String? displayName,
    required bool blocked,
    required bool emailConfirmed,
    _i2.AdminRole? globalRole,
    DateTime? profileCreatedAt,
    DateTime? deletedAt,
  }) = _AdminUserSummaryImpl;

  factory AdminUserSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminUserSummary(
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      email: jsonSerialization['email'] as String?,
      displayName: jsonSerialization['displayName'] as String?,
      blocked: _i1.BoolJsonExtension.fromJson(jsonSerialization['blocked']),
      emailConfirmed: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['emailConfirmed'],
      ),
      globalRole: jsonSerialization['globalRole'] == null
          ? null
          : _i2.AdminRole.fromJson((jsonSerialization['globalRole'] as String)),
      profileCreatedAt: jsonSerialization['profileCreatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['profileCreatedAt'],
            ),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  _i1.UuidValue userId;

  String? email;

  String? displayName;

  bool blocked;

  bool emailConfirmed;

  /// Global role from the `admin_user` allowlist (`null` = regular user).
  _i2.AdminRole? globalRole;

  DateTime? profileCreatedAt;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [AdminUserSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminUserSummary copyWith({
    _i1.UuidValue? userId,
    String? email,
    String? displayName,
    bool? blocked,
    bool? emailConfirmed,
    _i2.AdminRole? globalRole,
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
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminUserSummaryImpl extends AdminUserSummary {
  _AdminUserSummaryImpl({
    required _i1.UuidValue userId,
    String? email,
    String? displayName,
    required bool blocked,
    required bool emailConfirmed,
    _i2.AdminRole? globalRole,
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
  @_i1.useResult
  @override
  AdminUserSummary copyWith({
    _i1.UuidValue? userId,
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
      globalRole: globalRole is _i2.AdminRole? ? globalRole : this.globalRole,
      profileCreatedAt: profileCreatedAt is DateTime?
          ? profileCreatedAt
          : this.profileCreatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
