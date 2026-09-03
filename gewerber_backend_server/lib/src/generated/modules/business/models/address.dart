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
import '../../../modules/business/models/country.dart' as _i60az94p;

abstract class Address
    implements _is.SerializableModel, _is.ProtocolSerialization {
  Address._({
    required this.street,
    required this.zip,
    required this.city,
    _i60az94p.Country? country,
  }) : country = country ?? _i60az94p.Country.deu;

  factory Address({
    required String street,
    required String zip,
    required String city,
    _i60az94p.Country? country,
  }) = _AddressImpl;

  factory Address.fromJson(Map<String, dynamic> jsonSerialization) {
    return Address(
      street: jsonSerialization['street'] as String,
      zip: jsonSerialization['zip'] as String,
      city: jsonSerialization['city'] as String,
      country: jsonSerialization['country'] == null
          ? null
          : _i60az94p.Country.fromJson(
              (jsonSerialization['country'] as String),
            ),
    );
  }

  String street;

  String zip;

  String city;

  _i60az94p.Country country;

  /// Returns a shallow copy of this [Address]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Address copyWith({
    String? street,
    String? zip,
    String? city,
    _i60az94p.Country? country,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Address',
      'street': street,
      'zip': zip,
      'city': city,
      'country': country.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Address',
      'street': street,
      'zip': zip,
      'city': city,
      'country': country.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AddressImpl extends Address {
  _AddressImpl({
    required String street,
    required String zip,
    required String city,
    _i60az94p.Country? country,
  }) : super._(
         street: street,
         zip: zip,
         city: city,
         country: country,
       );

  /// Returns a shallow copy of this [Address]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Address copyWith({
    String? street,
    String? zip,
    String? city,
    _i60az94p.Country? country,
  }) {
    return Address(
      street: street ?? this.street,
      zip: zip ?? this.zip,
      city: city ?? this.city,
      country: country ?? this.country,
    );
  }
}
