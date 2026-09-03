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

import 'package:gewerber_backend_client/src/protocol/protocol.dart'
    as _iipbhyvd;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../../modules/business/models/address.dart' as _iz28txwx;
import '../../../modules/business/models/currency.dart' as _i80byysb;
import '../../../modules/business/models/legal_form.dart' as _ibbkzk4j;
import '../../../modules/business/models/locale.dart' as _ie5v8zdc;

abstract class UpdateBusinessRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    required _ibbkzk4j.LegalForm legalForm,
    required bool isKleinunternehmer,
    String? vatId,
    String? taxNumber,
    String? email,
    String? phone,
    _iz28txwx.Address? address,
    required _ie5v8zdc.Locale locale,
    required _i80byysb.Currency currency,
  }) = _UpdateBusinessRequestImpl;

  factory UpdateBusinessRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UpdateBusinessRequest(
      businessId: jsonSerialization['businessId'] as int,
      name: jsonSerialization['name'] as String,
      legalForm: _ibbkzk4j.LegalForm.fromJson(
        (jsonSerialization['legalForm'] as String),
      ),
      isKleinunternehmer: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isKleinunternehmer'],
      ),
      vatId: jsonSerialization['vatId'] as String?,
      taxNumber: jsonSerialization['taxNumber'] as String?,
      email: jsonSerialization['email'] as String?,
      phone: jsonSerialization['phone'] as String?,
      address: jsonSerialization['address'] == null
          ? null
          : _iipbhyvd.Protocol().deserialize<_iz28txwx.Address>(
              jsonSerialization['address'],
            ),
      locale: _ie5v8zdc.Locale.fromJson(
        (jsonSerialization['locale'] as String),
      ),
      currency: _i80byysb.Currency.fromJson(
        (jsonSerialization['currency'] as String),
      ),
    );
  }

  int businessId;

  String name;

  _ibbkzk4j.LegalForm legalForm;

  bool isKleinunternehmer;

  String? vatId;

  String? taxNumber;

  String? email;

  String? phone;

  _iz28txwx.Address? address;

  _ie5v8zdc.Locale locale;

  _i80byysb.Currency currency;

  /// Returns a shallow copy of this [UpdateBusinessRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UpdateBusinessRequest copyWith({
    int? businessId,
    String? name,
    _ibbkzk4j.LegalForm? legalForm,
    bool? isKleinunternehmer,
    String? vatId,
    String? taxNumber,
    String? email,
    String? phone,
    _iz28txwx.Address? address,
    _ie5v8zdc.Locale? locale,
    _i80byysb.Currency? currency,
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
      'locale': locale.toJson(),
      'currency': currency.toJson(),
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
      'locale': locale.toJson(),
      'currency': currency.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UpdateBusinessRequestImpl extends UpdateBusinessRequest {
  _UpdateBusinessRequestImpl({
    required int businessId,
    required String name,
    required _ibbkzk4j.LegalForm legalForm,
    required bool isKleinunternehmer,
    String? vatId,
    String? taxNumber,
    String? email,
    String? phone,
    _iz28txwx.Address? address,
    required _ie5v8zdc.Locale locale,
    required _i80byysb.Currency currency,
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
  @_isc.useResult
  @override
  UpdateBusinessRequest copyWith({
    int? businessId,
    String? name,
    _ibbkzk4j.LegalForm? legalForm,
    bool? isKleinunternehmer,
    Object? vatId = _Undefined,
    Object? taxNumber = _Undefined,
    Object? email = _Undefined,
    Object? phone = _Undefined,
    Object? address = _Undefined,
    _ie5v8zdc.Locale? locale,
    _i80byysb.Currency? currency,
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
      address: address is _iz28txwx.Address?
          ? address
          : this.address?.copyWith(),
      locale: locale ?? this.locale,
      currency: currency ?? this.currency,
    );
  }
}
