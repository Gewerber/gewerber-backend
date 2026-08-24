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
import 'package:serverpod/serverpod.dart' as _i1;
import '../../../modules/business/models/business.dart' as _i2;
import '../../../modules/admin/models/admin_membership_info.dart' as _i3;
import 'package:gewerber_backend_server/src/generated/protocol.dart' as _i4;

abstract class AdminBusinessDetail
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdminBusinessDetail._({
    required this.business,
    required this.memberships,
  });

  factory AdminBusinessDetail({
    required _i2.Business business,
    required List<_i3.AdminMembershipInfo> memberships,
  }) = _AdminBusinessDetailImpl;

  factory AdminBusinessDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminBusinessDetail(
      business: _i4.Protocol().deserialize<_i2.Business>(
        jsonSerialization['business'],
      ),
      memberships: _i4.Protocol().deserialize<List<_i3.AdminMembershipInfo>>(
        jsonSerialization['memberships'],
      ),
    );
  }

  _i2.Business business;

  List<_i3.AdminMembershipInfo> memberships;

  /// Returns a shallow copy of this [AdminBusinessDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminBusinessDetail copyWith({
    _i2.Business? business,
    List<_i3.AdminMembershipInfo>? memberships,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminBusinessDetail',
      'business': business.toJson(),
      'memberships': memberships.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminBusinessDetail',
      'business': business.toJsonForProtocol(),
      'memberships': memberships.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AdminBusinessDetailImpl extends AdminBusinessDetail {
  _AdminBusinessDetailImpl({
    required _i2.Business business,
    required List<_i3.AdminMembershipInfo> memberships,
  }) : super._(
         business: business,
         memberships: memberships,
       );

  /// Returns a shallow copy of this [AdminBusinessDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminBusinessDetail copyWith({
    _i2.Business? business,
    List<_i3.AdminMembershipInfo>? memberships,
  }) {
    return AdminBusinessDetail(
      business: business ?? this.business.copyWith(),
      memberships:
          memberships ?? this.memberships.map((e0) => e0.copyWith()).toList(),
    );
  }
}
