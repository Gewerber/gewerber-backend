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
import '../../../modules/business/models/membership_role.dart' as _i0s3lyvs;

abstract class Membership
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Membership._({
    this.id,
    this.userId,
    required this.businessId,
    _i0s3lyvs.MembershipRole? role,
    DateTime? createdAt,
  }) : role = role ?? _i0s3lyvs.MembershipRole.member,
       createdAt = createdAt ?? DateTime.now();

  factory Membership({
    int? id,
    _isc.UuidValue? userId,
    required int businessId,
    _i0s3lyvs.MembershipRole? role,
    DateTime? createdAt,
  }) = _MembershipImpl;

  factory Membership.fromJson(Map<String, dynamic> jsonSerialization) {
    return Membership(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      businessId: jsonSerialization['businessId'] as int,
      role: jsonSerialization['role'] == null
          ? null
          : _i0s3lyvs.MembershipRole.fromJson(
              (jsonSerialization['role'] as String),
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Nullable: set to null when the account is deleted (GDPR Art. 17).
  _isc.UuidValue? userId;

  int businessId;

  _i0s3lyvs.MembershipRole role;

  DateTime createdAt;

  /// Returns a shallow copy of this [Membership]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Membership copyWith({
    int? id,
    _isc.UuidValue? userId,
    int? businessId,
    _i0s3lyvs.MembershipRole? role,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Membership',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId?.toJson(),
      'businessId': businessId,
      'role': role.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Membership',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId?.toJson(),
      'businessId': businessId,
      'role': role.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MembershipImpl extends Membership {
  _MembershipImpl({
    int? id,
    _isc.UuidValue? userId,
    required int businessId,
    _i0s3lyvs.MembershipRole? role,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         businessId: businessId,
         role: role,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Membership]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Membership copyWith({
    Object? id = _Undefined,
    Object? userId = _Undefined,
    int? businessId,
    _i0s3lyvs.MembershipRole? role,
    DateTime? createdAt,
  }) {
    return Membership(
      id: id is int? ? id : this.id,
      userId: userId is _isc.UuidValue? ? userId : this.userId,
      businessId: businessId ?? this.businessId,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
