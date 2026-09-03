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
import '../../../modules/admin/models/admin_membership_info.dart' as _ir926tki;
import '../../../modules/business/models/business.dart' as _i2ifapy5;

abstract class AdminBusinessDetail
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AdminBusinessDetail._({
    required this.business,
    required this.memberships,
  });

  factory AdminBusinessDetail({
    required _i2ifapy5.Business business,
    required List<_ir926tki.AdminMembershipInfo> memberships,
  }) = _AdminBusinessDetailImpl;

  factory AdminBusinessDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminBusinessDetail(
      business: _itzp2rm6.Protocol().deserialize<_i2ifapy5.Business>(
        jsonSerialization['business'],
      ),
      memberships: _itzp2rm6.Protocol()
          .deserialize<List<_ir926tki.AdminMembershipInfo>>(
            jsonSerialization['memberships'],
          ),
    );
  }

  _i2ifapy5.Business business;

  List<_ir926tki.AdminMembershipInfo> memberships;

  /// Returns a shallow copy of this [AdminBusinessDetail]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminBusinessDetail copyWith({
    _i2ifapy5.Business? business,
    List<_ir926tki.AdminMembershipInfo>? memberships,
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
    return _is.SerializationManager.encode(this);
  }
}

class _AdminBusinessDetailImpl extends AdminBusinessDetail {
  _AdminBusinessDetailImpl({
    required _i2ifapy5.Business business,
    required List<_ir926tki.AdminMembershipInfo> memberships,
  }) : super._(
         business: business,
         memberships: memberships,
       );

  /// Returns a shallow copy of this [AdminBusinessDetail]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminBusinessDetail copyWith({
    _i2ifapy5.Business? business,
    List<_ir926tki.AdminMembershipInfo>? memberships,
  }) {
    return AdminBusinessDetail(
      business: business ?? this.business.copyWith(),
      memberships:
          memberships ?? this.memberships.map((e0) => e0.copyWith()).toList(),
    );
  }
}
