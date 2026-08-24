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
import '../../../modules/business/models/membership.dart' as _i2;
import 'package:gewerber_backend_client/src/protocol/protocol.dart' as _i3;

abstract class AdminMembershipInfo
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdminMembershipInfo._({
    required this.membership,
    required this.businessName,
  });

  factory AdminMembershipInfo({
    required _i2.Membership membership,
    required String businessName,
  }) = _AdminMembershipInfoImpl;

  factory AdminMembershipInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminMembershipInfo(
      membership: _i3.Protocol().deserialize<_i2.Membership>(
        jsonSerialization['membership'],
      ),
      businessName: jsonSerialization['businessName'] as String,
    );
  }

  _i2.Membership membership;

  String businessName;

  /// Returns a shallow copy of this [AdminMembershipInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminMembershipInfo copyWith({
    _i2.Membership? membership,
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
    return _i1.SerializationManager.encode(this);
  }
}

class _AdminMembershipInfoImpl extends AdminMembershipInfo {
  _AdminMembershipInfoImpl({
    required _i2.Membership membership,
    required String businessName,
  }) : super._(
         membership: membership,
         businessName: businessName,
       );

  /// Returns a shallow copy of this [AdminMembershipInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminMembershipInfo copyWith({
    _i2.Membership? membership,
    String? businessName,
  }) {
    return AdminMembershipInfo(
      membership: membership ?? this.membership.copyWith(),
      businessName: businessName ?? this.businessName,
    );
  }
}
