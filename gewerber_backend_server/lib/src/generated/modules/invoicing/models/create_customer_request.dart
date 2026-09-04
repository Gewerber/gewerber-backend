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
import '../../../modules/business/models/address.dart' as _iz28txwx;

abstract class CreateCustomerRequest
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CreateCustomerRequest._({
    required this.name,
    this.companyName,
    this.vatId,
    this.email,
    this.phone,
    this.address,
    this.notes,
  });

  factory CreateCustomerRequest({
    required String name,
    String? companyName,
    String? vatId,
    String? email,
    String? phone,
    _iz28txwx.Address? address,
    String? notes,
  }) = _CreateCustomerRequestImpl;

  factory CreateCustomerRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateCustomerRequest(
      name: jsonSerialization['name'] as String,
      companyName: jsonSerialization['companyName'] as String?,
      vatId: jsonSerialization['vatId'] as String?,
      email: jsonSerialization['email'] as String?,
      phone: jsonSerialization['phone'] as String?,
      address: jsonSerialization['address'] == null
          ? null
          : _itzp2rm6.Protocol().deserialize<_iz28txwx.Address>(
              jsonSerialization['address'],
            ),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  String name;

  String? companyName;

  String? vatId;

  String? email;

  String? phone;

  _iz28txwx.Address? address;

  String? notes;

  /// Returns a shallow copy of this [CreateCustomerRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CreateCustomerRequest copyWith({
    String? name,
    String? companyName,
    String? vatId,
    String? email,
    String? phone,
    _iz28txwx.Address? address,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateCustomerRequest',
      'name': name,
      if (companyName != null) 'companyName': companyName,
      if (vatId != null) 'vatId': vatId,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address?.toJson(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreateCustomerRequest',
      'name': name,
      if (companyName != null) 'companyName': companyName,
      if (vatId != null) 'vatId': vatId,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address?.toJsonForProtocol(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateCustomerRequestImpl extends CreateCustomerRequest {
  _CreateCustomerRequestImpl({
    required String name,
    String? companyName,
    String? vatId,
    String? email,
    String? phone,
    _iz28txwx.Address? address,
    String? notes,
  }) : super._(
         name: name,
         companyName: companyName,
         vatId: vatId,
         email: email,
         phone: phone,
         address: address,
         notes: notes,
       );

  /// Returns a shallow copy of this [CreateCustomerRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CreateCustomerRequest copyWith({
    String? name,
    Object? companyName = _Undefined,
    Object? vatId = _Undefined,
    Object? email = _Undefined,
    Object? phone = _Undefined,
    Object? address = _Undefined,
    Object? notes = _Undefined,
  }) {
    return CreateCustomerRequest(
      name: name ?? this.name,
      companyName: companyName is String? ? companyName : this.companyName,
      vatId: vatId is String? ? vatId : this.vatId,
      email: email is String? ? email : this.email,
      phone: phone is String? ? phone : this.phone,
      address: address is _iz28txwx.Address?
          ? address
          : this.address?.copyWith(),
      notes: notes is String? ? notes : this.notes,
    );
  }
}
