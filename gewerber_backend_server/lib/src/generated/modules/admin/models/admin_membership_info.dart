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
import '../../../modules/business/models/membership.dart' as _ixb2a518;

abstract class AdminMembershipInfo
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AdminMembershipInfo._({
    required this.membership,
    required this.businessName,
  });

  factory AdminMembershipInfo({
    required _ixb2a518.Membership membership,
    required String businessName,
  }) = _AdminMembershipInfoImpl;

  factory AdminMembershipInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminMembershipInfo(
      membership: _itzp2rm6.Protocol().deserialize<_ixb2a518.Membership>(
        jsonSerialization['membership'],
      ),
      businessName: jsonSerialization['businessName'] as String,
    );
  }

  _ixb2a518.Membership membership;

  String businessName;

  /// Returns a shallow copy of this [AdminMembershipInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminMembershipInfo copyWith({
    _ixb2a518.Membership? membership,
    String? businessName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminMembershipInfo',
      'membership': membership.toJson(),
      'businessName': businessName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminMembershipInfo',
      'membership': membership.toJsonForProtocol(),
      'businessName': businessName,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AdminMembershipInfoImpl extends AdminMembershipInfo {
  _AdminMembershipInfoImpl({
    required _ixb2a518.Membership membership,
    required String businessName,
  }) : super._(
         membership: membership,
         businessName: businessName,
       );

  /// Returns a shallow copy of this [AdminMembershipInfo]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminMembershipInfo copyWith({
    _ixb2a518.Membership? membership,
    String? businessName,
  }) {
    return AdminMembershipInfo(
      membership: membership ?? this.membership.copyWith(),
      businessName: businessName ?? this.businessName,
    );
  }
}
