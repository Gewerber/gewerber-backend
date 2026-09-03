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

abstract class CreateInvoiceTemplateRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CreateInvoiceTemplateRequest._({
    required this.name,
    bool? isDefault,
    this.headerText,
    this.footerText,
    this.logoDocumentId,
  }) : isDefault = isDefault ?? false;

  factory CreateInvoiceTemplateRequest({
    required String name,
    bool? isDefault,
    String? headerText,
    String? footerText,
    int? logoDocumentId,
  }) = _CreateInvoiceTemplateRequestImpl;

  factory CreateInvoiceTemplateRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateInvoiceTemplateRequest(
      name: jsonSerialization['name'] as String,
      isDefault: jsonSerialization['isDefault'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isDefault']),
      headerText: jsonSerialization['headerText'] as String?,
      footerText: jsonSerialization['footerText'] as String?,
      logoDocumentId: jsonSerialization['logoDocumentId'] as int?,
    );
  }

  String name;

  bool isDefault;

  String? headerText;

  String? footerText;

  int? logoDocumentId;

  /// Returns a shallow copy of this [CreateInvoiceTemplateRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CreateInvoiceTemplateRequest copyWith({
    String? name,
    bool? isDefault,
    String? headerText,
    String? footerText,
    int? logoDocumentId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateInvoiceTemplateRequest',
      'name': name,
      'isDefault': isDefault,
      if (headerText != null) 'headerText': headerText,
      if (footerText != null) 'footerText': footerText,
      if (logoDocumentId != null) 'logoDocumentId': logoDocumentId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreateInvoiceTemplateRequest',
      'name': name,
      'isDefault': isDefault,
      if (headerText != null) 'headerText': headerText,
      if (footerText != null) 'footerText': footerText,
      if (logoDocumentId != null) 'logoDocumentId': logoDocumentId,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateInvoiceTemplateRequestImpl extends CreateInvoiceTemplateRequest {
  _CreateInvoiceTemplateRequestImpl({
    required String name,
    bool? isDefault,
    String? headerText,
    String? footerText,
    int? logoDocumentId,
  }) : super._(
         name: name,
         isDefault: isDefault,
         headerText: headerText,
         footerText: footerText,
         logoDocumentId: logoDocumentId,
       );

  /// Returns a shallow copy of this [CreateInvoiceTemplateRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CreateInvoiceTemplateRequest copyWith({
    String? name,
    bool? isDefault,
    Object? headerText = _Undefined,
    Object? footerText = _Undefined,
    Object? logoDocumentId = _Undefined,
  }) {
    return CreateInvoiceTemplateRequest(
      name: name ?? this.name,
      isDefault: isDefault ?? this.isDefault,
      headerText: headerText is String? ? headerText : this.headerText,
      footerText: footerText is String? ? footerText : this.footerText,
      logoDocumentId: logoDocumentId is int?
          ? logoDocumentId
          : this.logoDocumentId,
    );
  }
}
