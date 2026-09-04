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
import '../../../core/admin/admin_role.dart' as _isyiaiss;
import '../../../modules/admin/models/admin_auth_status.dart' as _ipkga77r;
import '../../../modules/admin/models/admin_membership_info.dart' as _ir926tki;
import '../../../modules/user/models/user_profile.dart' as _igw681aa;

/// Complete dossier of one user for support and moderation workflows.
abstract class AdminUserDossier
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AdminUserDossier._({
    this.profile,
    this.email,
    required this.authStatus,
    required this.memberships,
    this.globalRole,
  });

  factory AdminUserDossier({
    _igw681aa.UserProfile? profile,
    String? email,
    required _ipkga77r.AdminAuthStatus authStatus,
    required List<_ir926tki.AdminMembershipInfo> memberships,
    _isyiaiss.AdminRole? globalRole,
  }) = _AdminUserDossierImpl;

  factory AdminUserDossier.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminUserDossier(
      profile: jsonSerialization['profile'] == null
          ? null
          : _itzp2rm6.Protocol().deserialize<_igw681aa.UserProfile>(
              jsonSerialization['profile'],
            ),
      email: jsonSerialization['email'] as String?,
      authStatus: _itzp2rm6.Protocol().deserialize<_ipkga77r.AdminAuthStatus>(
        jsonSerialization['authStatus'],
      ),
      memberships: _itzp2rm6.Protocol()
          .deserialize<List<_ir926tki.AdminMembershipInfo>>(
            jsonSerialization['memberships'],
          ),
      globalRole: jsonSerialization['globalRole'] == null
          ? null
          : _isyiaiss.AdminRole.fromJson(
              (jsonSerialization['globalRole'] as String),
            ),
    );
  }

  _igw681aa.UserProfile? profile;

  String? email;

  _ipkga77r.AdminAuthStatus authStatus;

  List<_ir926tki.AdminMembershipInfo> memberships;

  /// Global role from the `admin_user` allowlist (`null` = regular user).
  _isyiaiss.AdminRole? globalRole;

  /// Returns a shallow copy of this [AdminUserDossier]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminUserDossier copyWith({
    _igw681aa.UserProfile? profile,
    String? email,
    _ipkga77r.AdminAuthStatus? authStatus,
    List<_ir926tki.AdminMembershipInfo>? memberships,
    _isyiaiss.AdminRole? globalRole,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminUserDossier',
      if (profile != null) 'profile': profile?.toJson(),
      if (email != null) 'email': email,
      'authStatus': authStatus.toJson(),
      'memberships': memberships.toJson(valueToJson: (v) => v.toJson()),
      if (globalRole != null) 'globalRole': globalRole?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminUserDossier',
      if (profile != null) 'profile': profile?.toJsonForProtocol(),
      if (email != null) 'email': email,
      'authStatus': authStatus.toJsonForProtocol(),
      'memberships': memberships.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      if (globalRole != null) 'globalRole': globalRole?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminUserDossierImpl extends AdminUserDossier {
  _AdminUserDossierImpl({
    _igw681aa.UserProfile? profile,
    String? email,
    required _ipkga77r.AdminAuthStatus authStatus,
    required List<_ir926tki.AdminMembershipInfo> memberships,
    _isyiaiss.AdminRole? globalRole,
  }) : super._(
         profile: profile,
         email: email,
         authStatus: authStatus,
         memberships: memberships,
         globalRole: globalRole,
       );

  /// Returns a shallow copy of this [AdminUserDossier]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminUserDossier copyWith({
    Object? profile = _Undefined,
    Object? email = _Undefined,
    _ipkga77r.AdminAuthStatus? authStatus,
    List<_ir926tki.AdminMembershipInfo>? memberships,
    Object? globalRole = _Undefined,
  }) {
    return AdminUserDossier(
      profile: profile is _igw681aa.UserProfile?
          ? profile
          : this.profile?.copyWith(),
      email: email is String? ? email : this.email,
      authStatus: authStatus ?? this.authStatus.copyWith(),
      memberships:
          memberships ?? this.memberships.map((e0) => e0.copyWith()).toList(),
      globalRole: globalRole is _isyiaiss.AdminRole?
          ? globalRole
          : this.globalRole,
    );
  }
}
