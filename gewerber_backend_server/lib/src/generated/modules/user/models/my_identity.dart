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
import '../../../modules/user/models/my_membership_info.dart' as _if7d4sy6;

abstract class MyIdentity
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MyIdentity._({
    required this.userId,
    this.globalRole,
    required this.memberships,
  });

  factory MyIdentity({
    required _is.UuidValue userId,
    _isyiaiss.AdminRole? globalRole,
    required List<_if7d4sy6.MyMembershipInfo> memberships,
  }) = _MyIdentityImpl;

  factory MyIdentity.fromJson(Map<String, dynamic> jsonSerialization) {
    return MyIdentity(
      userId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      globalRole: jsonSerialization['globalRole'] == null
          ? null
          : _isyiaiss.AdminRole.fromJson(
              (jsonSerialization['globalRole'] as String),
            ),
      memberships: _itzp2rm6.Protocol()
          .deserialize<List<_if7d4sy6.MyMembershipInfo>>(
            jsonSerialization['memberships'],
          ),
    );
  }

  _is.UuidValue userId;

  _isyiaiss.AdminRole? globalRole;

  List<_if7d4sy6.MyMembershipInfo> memberships;

  /// Returns a shallow copy of this [MyIdentity]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MyIdentity copyWith({
    _is.UuidValue? userId,
    _isyiaiss.AdminRole? globalRole,
    List<_if7d4sy6.MyMembershipInfo>? memberships,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MyIdentity',
      'userId': userId.toJson(),
      if (globalRole != null) 'globalRole': globalRole?.toJson(),
      'memberships': memberships.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MyIdentity',
      'userId': userId.toJson(),
      if (globalRole != null) 'globalRole': globalRole?.toJson(),
      'memberships': memberships.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MyIdentityImpl extends MyIdentity {
  _MyIdentityImpl({
    required _is.UuidValue userId,
    _isyiaiss.AdminRole? globalRole,
    required List<_if7d4sy6.MyMembershipInfo> memberships,
  }) : super._(
         userId: userId,
         globalRole: globalRole,
         memberships: memberships,
       );

  /// Returns a shallow copy of this [MyIdentity]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MyIdentity copyWith({
    _is.UuidValue? userId,
    Object? globalRole = _Undefined,
    List<_if7d4sy6.MyMembershipInfo>? memberships,
  }) {
    return MyIdentity(
      userId: userId ?? this.userId,
      globalRole: globalRole is _isyiaiss.AdminRole?
          ? globalRole
          : this.globalRole,
      memberships:
          memberships ?? this.memberships.map((e0) => e0.copyWith()).toList(),
    );
  }
}
