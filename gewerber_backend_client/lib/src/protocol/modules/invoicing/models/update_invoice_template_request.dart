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

abstract class UpdateInvoiceTemplateRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UpdateInvoiceTemplateRequest._({
    required this.templateId,
    required this.name,
    required this.isDefault,
    this.headerText,
    this.footerText,
    this.logoDocumentId,
  });

  factory UpdateInvoiceTemplateRequest({
    required int templateId,
    required String name,
    required bool isDefault,
    String? headerText,
    String? footerText,
    int? logoDocumentId,
  }) = _UpdateInvoiceTemplateRequestImpl;

  factory UpdateInvoiceTemplateRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UpdateInvoiceTemplateRequest(
      templateId: jsonSerialization['templateId'] as int,
      name: jsonSerialization['name'] as String,
      isDefault: _i1.BoolJsonExtension.fromJson(jsonSerialization['isDefault']),
      headerText: jsonSerialization['headerText'] as String?,
      footerText: jsonSerialization['footerText'] as String?,
      logoDocumentId: jsonSerialization['logoDocumentId'] as int?,
    );
  }

  int templateId;

  String name;

  bool isDefault;

  String? headerText;

  String? footerText;

  int? logoDocumentId;

  /// Returns a shallow copy of this [UpdateInvoiceTemplateRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UpdateInvoiceTemplateRequest copyWith({
    int? templateId,
    String? name,
    bool? isDefault,
    String? headerText,
    String? footerText,
    int? logoDocumentId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UpdateInvoiceTemplateRequest',
      'templateId': templateId,
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
      '__className__': 'UpdateInvoiceTemplateRequest',
      'templateId': templateId,
      'name': name,
      'isDefault': isDefault,
      if (headerText != null) 'headerText': headerText,
      if (footerText != null) 'footerText': footerText,
      if (logoDocumentId != null) 'logoDocumentId': logoDocumentId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UpdateInvoiceTemplateRequestImpl extends UpdateInvoiceTemplateRequest {
  _UpdateInvoiceTemplateRequestImpl({
    required int templateId,
    required String name,
    required bool isDefault,
    String? headerText,
    String? footerText,
    int? logoDocumentId,
  }) : super._(
         templateId: templateId,
         name: name,
         isDefault: isDefault,
         headerText: headerText,
         footerText: footerText,
         logoDocumentId: logoDocumentId,
       );

  /// Returns a shallow copy of this [UpdateInvoiceTemplateRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UpdateInvoiceTemplateRequest copyWith({
    int? templateId,
    String? name,
    bool? isDefault,
    Object? headerText = _Undefined,
    Object? footerText = _Undefined,
    Object? logoDocumentId = _Undefined,
  }) {
    return UpdateInvoiceTemplateRequest(
      templateId: templateId ?? this.templateId,
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
