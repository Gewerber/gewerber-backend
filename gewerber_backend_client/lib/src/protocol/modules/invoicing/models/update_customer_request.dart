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
import '../../../modules/invoicing/models/customer_status.dart' as _i2;
import '../../../modules/business/models/address.dart' as _i3;
import 'package:gewerber_backend_client/src/protocol/protocol.dart' as _i4;

abstract class UpdateCustomerRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UpdateCustomerRequest._({
    required this.customerId,
    required this.status,
    required this.name,
    this.companyName,
    this.vatId,
    this.email,
    this.phone,
    this.address,
    this.notes,
  });

  factory UpdateCustomerRequest({
    required int customerId,
    required _i2.CustomerStatus status,
    required String name,
    String? companyName,
    String? vatId,
    String? email,
    String? phone,
    _i3.Address? address,
    String? notes,
  }) = _UpdateCustomerRequestImpl;

  factory UpdateCustomerRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UpdateCustomerRequest(
      customerId: jsonSerialization['customerId'] as int,
      status: _i2.CustomerStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      name: jsonSerialization['name'] as String,
      companyName: jsonSerialization['companyName'] as String?,
      vatId: jsonSerialization['vatId'] as String?,
      email: jsonSerialization['email'] as String?,
      phone: jsonSerialization['phone'] as String?,
      address: jsonSerialization['address'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Address>(
              jsonSerialization['address'],
            ),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  int customerId;

  _i2.CustomerStatus status;

  String name;

  String? companyName;

  String? vatId;

  String? email;

  String? phone;

  _i3.Address? address;

  String? notes;

  /// Returns a shallow copy of this [UpdateCustomerRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UpdateCustomerRequest copyWith({
    int? customerId,
    _i2.CustomerStatus? status,
    String? name,
    String? companyName,
    String? vatId,
    String? email,
    String? phone,
    _i3.Address? address,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UpdateCustomerRequest',
      'customerId': customerId,
      'status': status.toJson(),
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
      '__className__': 'UpdateCustomerRequest',
      'customerId': customerId,
      'status': status.toJson(),
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
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UpdateCustomerRequestImpl extends UpdateCustomerRequest {
  _UpdateCustomerRequestImpl({
    required int customerId,
    required _i2.CustomerStatus status,
    required String name,
    String? companyName,
    String? vatId,
    String? email,
    String? phone,
    _i3.Address? address,
    String? notes,
  }) : super._(
         customerId: customerId,
         status: status,
         name: name,
         companyName: companyName,
         vatId: vatId,
         email: email,
         phone: phone,
         address: address,
         notes: notes,
       );

  /// Returns a shallow copy of this [UpdateCustomerRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UpdateCustomerRequest copyWith({
    int? customerId,
    _i2.CustomerStatus? status,
    String? name,
    Object? companyName = _Undefined,
    Object? vatId = _Undefined,
    Object? email = _Undefined,
    Object? phone = _Undefined,
    Object? address = _Undefined,
    Object? notes = _Undefined,
  }) {
    return UpdateCustomerRequest(
      customerId: customerId ?? this.customerId,
      status: status ?? this.status,
      name: name ?? this.name,
      companyName: companyName is String? ? companyName : this.companyName,
      vatId: vatId is String? ? vatId : this.vatId,
      email: email is String? ? email : this.email,
      phone: phone is String? ? phone : this.phone,
      address: address is _i3.Address? ? address : this.address?.copyWith(),
      notes: notes is String? ? notes : this.notes,
    );
  }
}
