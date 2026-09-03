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

import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class InvoiceTemplate
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  InvoiceTemplate._({
    this.id,
    required this.businessId,
    required this.name,
    bool? isDefault,
    this.headerText,
    this.footerText,
    this.logoDocumentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isDefault = isDefault ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory InvoiceTemplate({
    int? id,
    required int businessId,
    required String name,
    bool? isDefault,
    String? headerText,
    String? footerText,
    int? logoDocumentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _InvoiceTemplateImpl;

  factory InvoiceTemplate.fromJson(Map<String, dynamic> jsonSerialization) {
    return InvoiceTemplate(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      name: jsonSerialization['name'] as String,
      isDefault: jsonSerialization['isDefault'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isDefault']),
      headerText: jsonSerialization['headerText'] as String?,
      footerText: jsonSerialization['footerText'] as String?,
      logoDocumentId: jsonSerialization['logoDocumentId'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int businessId;

  String name;

  bool isDefault;

  String? headerText;

  String? footerText;

  int? logoDocumentId;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [InvoiceTemplate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InvoiceTemplate copyWith({
    int? id,
    int? businessId,
    String? name,
    bool? isDefault,
    String? headerText,
    String? footerText,
    int? logoDocumentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InvoiceTemplate',
      if (id != null) 'id': id,
      'businessId': businessId,
      'name': name,
      'isDefault': isDefault,
      if (headerText != null) 'headerText': headerText,
      if (footerText != null) 'footerText': footerText,
      if (logoDocumentId != null) 'logoDocumentId': logoDocumentId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InvoiceTemplate',
      if (id != null) 'id': id,
      'businessId': businessId,
      'name': name,
      'isDefault': isDefault,
      if (headerText != null) 'headerText': headerText,
      if (footerText != null) 'footerText': footerText,
      if (logoDocumentId != null) 'logoDocumentId': logoDocumentId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InvoiceTemplateImpl extends InvoiceTemplate {
  _InvoiceTemplateImpl({
    int? id,
    required int businessId,
    required String name,
    bool? isDefault,
    String? headerText,
    String? footerText,
    int? logoDocumentId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         businessId: businessId,
         name: name,
         isDefault: isDefault,
         headerText: headerText,
         footerText: footerText,
         logoDocumentId: logoDocumentId,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [InvoiceTemplate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  InvoiceTemplate copyWith({
    Object? id = _Undefined,
    int? businessId,
    String? name,
    bool? isDefault,
    Object? headerText = _Undefined,
    Object? footerText = _Undefined,
    Object? logoDocumentId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return InvoiceTemplate(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      headerText: headerText is String? ? headerText : this.headerText,
      footerText: footerText is String? ? footerText : this.footerText,
      logoDocumentId: logoDocumentId is int?
          ? logoDocumentId
          : this.logoDocumentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
