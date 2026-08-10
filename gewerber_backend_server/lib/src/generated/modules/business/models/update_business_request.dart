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
import '../../../modules/business/models/legal_form.dart' as _i2;
import '../../../modules/business/models/address.dart' as _i3;
import 'package:gewerber_backend_server/src/generated/protocol.dart' as _i4;

abstract class UpdateBusinessRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UpdateBusinessRequest._({
    required this.businessId,
    required this.name,
    required this.legalForm,
    required this.isKleinunternehmer,
    this.vatId,
    this.taxNumber,
    this.email,
    this.phone,
    this.address,
    required this.locale,
    required this.currency,
  });

  factory UpdateBusinessRequest({
    required int businessId,
    required String name,
    required _i2.LegalForm legalForm,
    required bool isKleinunternehmer,
    String? vatId,
    String? taxNumber,
    String? email,
    String? phone,
    _i3.Address? address,
    required String locale,
    required String currency,
  }) = _UpdateBusinessRequestImpl;

  factory UpdateBusinessRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UpdateBusinessRequest(
      businessId: jsonSerialization['businessId'] as int,
      name: jsonSerialization['name'] as String,
      legalForm: _i2.LegalForm.fromJson(
        (jsonSerialization['legalForm'] as String),
      ),
      isKleinunternehmer: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isKleinunternehmer'],
      ),
      vatId: jsonSerialization['vatId'] as String?,
      taxNumber: jsonSerialization['taxNumber'] as String?,
      email: jsonSerialization['email'] as String?,
      phone: jsonSerialization['phone'] as String?,
      address: jsonSerialization['address'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Address>(
              jsonSerialization['address'],
            ),
      locale: jsonSerialization['locale'] as String,
      currency: jsonSerialization['currency'] as String,
    );
  }

  int businessId;

  String name;

  _i2.LegalForm legalForm;

  bool isKleinunternehmer;

  String? vatId;

  String? taxNumber;

  String? email;

  String? phone;

  _i3.Address? address;

  String locale;

  String currency;

  /// Returns a shallow copy of this [UpdateBusinessRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UpdateBusinessRequest copyWith({
    int? businessId,
    String? name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    String? vatId,
    String? taxNumber,
    String? email,
    String? phone,
    _i3.Address? address,
    String? locale,
    String? currency,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UpdateBusinessRequest',
      'businessId': businessId,
      'name': name,
      'legalForm': legalForm.toJson(),
      'isKleinunternehmer': isKleinunternehmer,
      if (vatId != null) 'vatId': vatId,
      if (taxNumber != null) 'taxNumber': taxNumber,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address?.toJson(),
      'locale': locale,
      'currency': currency,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UpdateBusinessRequest',
      'businessId': businessId,
      'name': name,
      'legalForm': legalForm.toJson(),
      'isKleinunternehmer': isKleinunternehmer,
      if (vatId != null) 'vatId': vatId,
      if (taxNumber != null) 'taxNumber': taxNumber,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address?.toJsonForProtocol(),
      'locale': locale,
      'currency': currency,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UpdateBusinessRequestImpl extends UpdateBusinessRequest {
  _UpdateBusinessRequestImpl({
    required int businessId,
    required String name,
    required _i2.LegalForm legalForm,
    required bool isKleinunternehmer,
    String? vatId,
    String? taxNumber,
    String? email,
    String? phone,
    _i3.Address? address,
    required String locale,
    required String currency,
  }) : super._(
         businessId: businessId,
         name: name,
         legalForm: legalForm,
         isKleinunternehmer: isKleinunternehmer,
         vatId: vatId,
         taxNumber: taxNumber,
         email: email,
         phone: phone,
         address: address,
         locale: locale,
         currency: currency,
       );

  /// Returns a shallow copy of this [UpdateBusinessRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UpdateBusinessRequest copyWith({
    int? businessId,
    String? name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    Object? vatId = _Undefined,
    Object? taxNumber = _Undefined,
    Object? email = _Undefined,
    Object? phone = _Undefined,
    Object? address = _Undefined,
    String? locale,
    String? currency,
  }) {
    return UpdateBusinessRequest(
      businessId: businessId ?? this.businessId,
      name: name ?? this.name,
      legalForm: legalForm ?? this.legalForm,
      isKleinunternehmer: isKleinunternehmer ?? this.isKleinunternehmer,
      vatId: vatId is String? ? vatId : this.vatId,
      taxNumber: taxNumber is String? ? taxNumber : this.taxNumber,
      email: email is String? ? email : this.email,
      phone: phone is String? ? phone : this.phone,
      address: address is _i3.Address? ? address : this.address?.copyWith(),
      locale: locale ?? this.locale,
      currency: currency ?? this.currency,
    );
  }
}
