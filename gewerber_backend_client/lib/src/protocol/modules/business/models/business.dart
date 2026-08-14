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

abstract class Business
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  Business._({
    this.id,
    required this.name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    this.vatId,
    this.email,
    this.phone,
    this.address,
    _i3.Locale? locale,
    _i4.Currency? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : legalForm = legalForm ?? _i2.LegalForm.einzelunternehmen,
       isKleinunternehmer = isKleinunternehmer ?? false,
       locale = locale ?? _i3.Locale.de,
       currency = currency ?? _i4.Currency.eur,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Business({
    int? id,
    required String name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    String? vatId,
    String? email,
    String? phone,
    _i5.Address? address,
    _i3.Locale? locale,
    _i4.Currency? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _BusinessImpl;

  factory Business.fromJson(Map<String, dynamic> jsonSerialization) {
    return Business(
      id: jsonSerialization['id'] as int?,
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
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  _i2.LegalForm legalForm;

  bool isKleinunternehmer;

  String? vatId;

  String? email;

  String? phone;

  _i5.Address? address;

  _i3.Locale locale;

  _i4.Currency currency;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Business]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Business copyWith({
    int? id,
    String? name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    String? vatId,
    String? email,
    String? phone,
    _i5.Address? address,
    _i3.Locale? locale,
    _i4.Currency? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Business',
      if (id != null) 'id': id,
      'name': name,
      'legalForm': legalForm.toJson(),
      'isKleinunternehmer': isKleinunternehmer,
      if (vatId != null) 'vatId': vatId,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address?.toJson(),
      'locale': locale.toJson(),
      'currency': currency.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Business',
      if (id != null) 'id': id,
      'name': name,
      'legalForm': legalForm.toJson(),
      'isKleinunternehmer': isKleinunternehmer,
      if (vatId != null) 'vatId': vatId,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address?.toJsonForProtocol(),
      'locale': locale.toJson(),
      'currency': currency.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BusinessImpl extends Business {
  _BusinessImpl({
    int? id,
    required String name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    String? vatId,
    String? email,
    String? phone,
    _i5.Address? address,
    _i3.Locale? locale,
    _i4.Currency? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         legalForm: legalForm,
         isKleinunternehmer: isKleinunternehmer,
         vatId: vatId,
         email: email,
         phone: phone,
         address: address,
         locale: locale,
         currency: currency,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Business]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Business copyWith({
    Object? id = _Undefined,
    String? name,
    _i2.LegalForm? legalForm,
    bool? isKleinunternehmer,
    Object? vatId = _Undefined,
    Object? email = _Undefined,
    Object? phone = _Undefined,
    Object? address = _Undefined,
    _i3.Locale? locale,
    _i4.Currency? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Business(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      legalForm: legalForm ?? this.legalForm,
      isKleinunternehmer: isKleinunternehmer ?? this.isKleinunternehmer,
      vatId: vatId is String? ? vatId : this.vatId,
      email: email is String? ? email : this.email,
      phone: phone is String? ? phone : this.phone,
      address: address is _i5.Address? ? address : this.address?.copyWith(),
      locale: locale ?? this.locale,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
