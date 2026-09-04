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
import '../../../modules/business/models/invitation_status.dart' as _iosjwc4i;
import '../../../modules/business/models/membership_role.dart' as _i0s3lyvs;

abstract class Invitation
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Invitation._({
    this.id,
    required this.businessId,
    required this.email,
    _i0s3lyvs.MembershipRole? role,
    _iosjwc4i.InvitationStatus? status,
    this.invitedByUserId,
    required this.tokenHash,
    required this.expiresAt,
    this.acceptedAt,
    DateTime? createdAt,
  }) : role = role ?? _i0s3lyvs.MembershipRole.member,
       status = status ?? _iosjwc4i.InvitationStatus.pending,
       createdAt = createdAt ?? DateTime.now();

  factory Invitation({
    int? id,
    required int businessId,
    required String email,
    _i0s3lyvs.MembershipRole? role,
    _iosjwc4i.InvitationStatus? status,
    _isc.UuidValue? invitedByUserId,
    required String tokenHash,
    required DateTime expiresAt,
    DateTime? acceptedAt,
    DateTime? createdAt,
  }) = _InvitationImpl;

  factory Invitation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Invitation(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      email: jsonSerialization['email'] as String,
      role: jsonSerialization['role'] == null
          ? null
          : _i0s3lyvs.MembershipRole.fromJson(
              (jsonSerialization['role'] as String),
            ),
      status: jsonSerialization['status'] == null
          ? null
          : _iosjwc4i.InvitationStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      invitedByUserId: jsonSerialization['invitedByUserId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['invitedByUserId'],
            ),
      tokenHash: jsonSerialization['tokenHash'] as String,
      expiresAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      acceptedAt: jsonSerialization['acceptedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['acceptedAt'],
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

  /// Mirrors the membership business relation (cascade delete with business).
  int businessId;

  String email;

  _i0s3lyvs.MembershipRole role;

  _iosjwc4i.InvitationStatus status;

  /// Nullable: set to null when the account is deleted (GDPR Art. 17).
  _isc.UuidValue? invitedByUserId;

  /// sha256 hex of the invitation token; the raw token is never stored.
  String tokenHash;

  DateTime expiresAt;

  DateTime? acceptedAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [Invitation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Invitation copyWith({
    int? id,
    int? businessId,
    String? email,
    _i0s3lyvs.MembershipRole? role,
    _iosjwc4i.InvitationStatus? status,
    _isc.UuidValue? invitedByUserId,
    String? tokenHash,
    DateTime? expiresAt,
    DateTime? acceptedAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Invitation',
      if (id != null) 'id': id,
      'businessId': businessId,
      'email': email,
      'role': role.toJson(),
      'status': status.toJson(),
      if (invitedByUserId != null) 'invitedByUserId': invitedByUserId?.toJson(),
      'tokenHash': tokenHash,
      'expiresAt': expiresAt.toJson(),
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Invitation',
      if (id != null) 'id': id,
      'businessId': businessId,
      'email': email,
      'role': role.toJson(),
      'status': status.toJson(),
      if (invitedByUserId != null) 'invitedByUserId': invitedByUserId?.toJson(),
      'tokenHash': tokenHash,
      'expiresAt': expiresAt.toJson(),
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvitationImpl extends Invitation {
  _InvitationImpl({
    int? id,
    required int businessId,
    required String email,
    _i0s3lyvs.MembershipRole? role,
    _iosjwc4i.InvitationStatus? status,
    _isc.UuidValue? invitedByUserId,
    required String tokenHash,
    required DateTime expiresAt,
    DateTime? acceptedAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         businessId: businessId,
         email: email,
         role: role,
         status: status,
         invitedByUserId: invitedByUserId,
         tokenHash: tokenHash,
         expiresAt: expiresAt,
         acceptedAt: acceptedAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Invitation]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Invitation copyWith({
    Object? id = _Undefined,
    int? businessId,
    String? email,
    _i0s3lyvs.MembershipRole? role,
    _iosjwc4i.InvitationStatus? status,
    Object? invitedByUserId = _Undefined,
    String? tokenHash,
    DateTime? expiresAt,
    Object? acceptedAt = _Undefined,
    DateTime? createdAt,
  }) {
    return Invitation(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      email: email ?? this.email,
      role: role ?? this.role,
      status: status ?? this.status,
      invitedByUserId: invitedByUserId is _isc.UuidValue?
          ? invitedByUserId
          : this.invitedByUserId,
      tokenHash: tokenHash ?? this.tokenHash,
      expiresAt: expiresAt ?? this.expiresAt,
      acceptedAt: acceptedAt is DateTime? ? acceptedAt : this.acceptedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
