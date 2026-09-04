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
import '../../../modules/business/models/membership_role.dart' as _i0s3lyvs;

abstract class MyMembershipInfo
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MyMembershipInfo._({
    required this.businessId,
    required this.businessName,
    required this.role,
  });

  factory MyMembershipInfo({
    required int businessId,
    required String businessName,
    required _i0s3lyvs.MembershipRole role,
  }) = _MyMembershipInfoImpl;

  factory MyMembershipInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return MyMembershipInfo(
      businessId: jsonSerialization['businessId'] as int,
      businessName: jsonSerialization['businessName'] as String,
      role: _i0s3lyvs.MembershipRole.fromJson(
        (jsonSerialization['role'] as String),
      ),
    );
  }

  int businessId;

  String businessName;

  _i0s3lyvs.MembershipRole role;

  /// Returns a shallow copy of this [MyMembershipInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MyMembershipInfo copyWith({
    int? businessId,
    String? businessName,
    _i0s3lyvs.MembershipRole? role,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MyMembershipInfo',
      'businessId': businessId,
      'businessName': businessName,
      'role': role.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MyMembershipInfo',
      'businessId': businessId,
      'businessName': businessName,
      'role': role.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _MyMembershipInfoImpl extends MyMembershipInfo {
  _MyMembershipInfoImpl({
    required int businessId,
    required String businessName,
    required _i0s3lyvs.MembershipRole role,
  }) : super._(
         businessId: businessId,
         businessName: businessName,
         role: role,
       );

  /// Returns a shallow copy of this [MyMembershipInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MyMembershipInfo copyWith({
    int? businessId,
    String? businessName,
    _i0s3lyvs.MembershipRole? role,
  }) {
    return MyMembershipInfo(
      businessId: businessId ?? this.businessId,
      businessName: businessName ?? this.businessName,
      role: role ?? this.role,
    );
  }
}
