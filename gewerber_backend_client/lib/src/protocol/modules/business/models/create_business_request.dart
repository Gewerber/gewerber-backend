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
import '../../../modules/business/models/legal_form.dart' as _i2;
import '../../../modules/business/models/locale.dart' as _i3;
import '../../../modules/business/models/currency.dart' as _i4;
import '../../../modules/business/models/address.dart' as _i5;
import 'package:gewerber_backend_client/src/protocol/protocol.dart' as _i6;

abstract class CreateBusinessRequest implements _i1.SerializableModel {
  CreateBusinessRequest._({
    required this.name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    this.vatId,
    this.taxNumber,
    this.email,
    this.phone,
    this.address,
    _i3.Locale? locale,
    _i4.Currency? currency,
  }) : legalForm = legalForm ?? _i2.LegalForm.einzelunternehmen,
       isKleinunternehmer = isKleinunternehmer ?? false,
       locale = locale ?? _i3.Locale.de,
       currency = currency ?? _i4.Currency.eur;

  factory CreateBusinessRequest({
    required String name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    String? vatId,
    String? taxNumber,
    String? email,
    String? phone,
    _i5.Address? address,
    _i3.Locale? locale,
    _i4.Currency? currency,
  }) = _CreateBusinessRequestImpl;

  factory CreateBusinessRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateBusinessRequest(
      name: jsonSerialization['name'] as String,
      legalForm: jsonSerialization['legalForm'] == null
          ? null
          : _i2.LegalForm.fromJson((jsonSerialization['legalForm'] as String)),
      isKleinunternehmer: jsonSerialization['isKleinunternehmer'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['isKleinunternehmer'],
            ),
      vatId: jsonSerialization['vatId'] as String?,
      taxNumber: jsonSerialization['taxNumber'] as String?,
      email: jsonSerialization['email'] as String?,
      phone: jsonSerialization['phone'] as String?,
      address: jsonSerialization['address'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.Address>(
              jsonSerialization['address'],
            ),
      locale: jsonSerialization['locale'] == null
          ? null
          : _i3.Locale.fromJson((jsonSerialization['locale'] as String)),
      currency: jsonSerialization['currency'] == null
          ? null
          : _i4.Currency.fromJson((jsonSerialization['currency'] as String)),
    );
  }

  String name;

  _i2.LegalForm legalForm;

  bool isKleinunternehmer;

  String? vatId;

  String? taxNumber;

  String? email;

  String? phone;

  _i5.Address? address;

  _i3.Locale locale;

  _i4.Currency currency;

  /// Returns a shallow copy of this [CreateBusinessRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreateBusinessRequest copyWith({
    String? name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    String? vatId,
    String? taxNumber,
    String? email,
    String? phone,
    _i5.Address? address,
    _i3.Locale? locale,
    _i4.Currency? currency,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateBusinessRequest',
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
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateBusinessRequestImpl extends CreateBusinessRequest {
  _CreateBusinessRequestImpl({
    required String name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    String? vatId,
    String? taxNumber,
    String? email,
    String? phone,
    _i5.Address? address,
    _i3.Locale? locale,
    _i4.Currency? currency,
  }) : super._(
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

  /// Returns a shallow copy of this [CreateBusinessRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreateBusinessRequest copyWith({
    String? name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    Object? vatId = _Undefined,
    Object? taxNumber = _Undefined,
    Object? email = _Undefined,
    Object? phone = _Undefined,
    Object? address = _Undefined,
    _i3.Locale? locale,
    _i4.Currency? currency,
  }) {
    return CreateBusinessRequest(
      name: name ?? this.name,
      legalForm: legalForm ?? this.legalForm,
      isKleinunternehmer: isKleinunternehmer ?? this.isKleinunternehmer,
      vatId: vatId is String? ? vatId : this.vatId,
      taxNumber: taxNumber is String? ? taxNumber : this.taxNumber,
      email: email is String? ? email : this.email,
      phone: phone is String? ? phone : this.phone,
      address: address is _i5.Address? ? address : this.address?.copyWith(),
      locale: locale ?? this.locale,
      currency: currency ?? this.currency,
    );
  }
}
