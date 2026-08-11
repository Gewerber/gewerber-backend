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
import '../../../modules/documents/models/document_kind.dart' as _i2;
import 'dart:typed_data' as _i3;

abstract class UploadDocumentRequest implements _i1.SerializableModel {
  UploadDocumentRequest._({
    required this.businessId,
    _i2.DocumentKind? kind,
    required this.fileName,
    this.mimeType,
    required this.data,
    this.relatedEntityType,
    this.relatedEntityId,
  }) : kind = kind ?? _i2.DocumentKind.attachment;

  factory UploadDocumentRequest({
    required int businessId,
    _i2.DocumentKind? kind,
    required String fileName,
    String? mimeType,
    required _i3.ByteData data,
    String? relatedEntityType,
    String? relatedEntityId,
  }) = _UploadDocumentRequestImpl;

  factory UploadDocumentRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UploadDocumentRequest(
      businessId: jsonSerialization['businessId'] as int,
      kind: jsonSerialization['kind'] == null
          ? null
          : _i2.DocumentKind.fromJson((jsonSerialization['kind'] as String)),
      fileName: jsonSerialization['fileName'] as String,
      mimeType: jsonSerialization['mimeType'] as String?,
      data: _i1.ByteDataJsonExtension.fromJson(jsonSerialization['data']),
      relatedEntityType: jsonSerialization['relatedEntityType'] as String?,
      relatedEntityId: jsonSerialization['relatedEntityId'] as String?,
    );
  }

  int businessId;

  _i2.DocumentKind kind;

  String fileName;

  String? mimeType;

  _i3.ByteData data;

  String? relatedEntityType;

  String? relatedEntityId;

  /// Returns a shallow copy of this [UploadDocumentRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UploadDocumentRequest copyWith({
    int? businessId,
    _i2.DocumentKind? kind,
    String? fileName,
    String? mimeType,
    _i3.ByteData? data,
    String? relatedEntityType,
    String? relatedEntityId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UploadDocumentRequest',
      'businessId': businessId,
      'kind': kind.toJson(),
      'fileName': fileName,
      if (mimeType != null) 'mimeType': mimeType,
      'data': data.toJson(),
      if (relatedEntityType != null) 'relatedEntityType': relatedEntityType,
      if (relatedEntityId != null) 'relatedEntityId': relatedEntityId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UploadDocumentRequestImpl extends UploadDocumentRequest {
  _UploadDocumentRequestImpl({
    required int businessId,
    _i2.DocumentKind? kind,
    required String fileName,
    String? mimeType,
    required _i3.ByteData data,
    String? relatedEntityType,
    String? relatedEntityId,
  }) : super._(
         businessId: businessId,
         kind: kind,
         fileName: fileName,
         mimeType: mimeType,
         data: data,
         relatedEntityType: relatedEntityType,
         relatedEntityId: relatedEntityId,
       );

  /// Returns a shallow copy of this [UploadDocumentRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UploadDocumentRequest copyWith({
    int? businessId,
    _i2.DocumentKind? kind,
    String? fileName,
    Object? mimeType = _Undefined,
    _i3.ByteData? data,
    Object? relatedEntityType = _Undefined,
    Object? relatedEntityId = _Undefined,
  }) {
    return UploadDocumentRequest(
      businessId: businessId ?? this.businessId,
      kind: kind ?? this.kind,
      fileName: fileName ?? this.fileName,
      mimeType: mimeType is String? ? mimeType : this.mimeType,
      data: data ?? this.data.clone(),
      relatedEntityType: relatedEntityType is String?
          ? relatedEntityType
          : this.relatedEntityType,
      relatedEntityId: relatedEntityId is String?
          ? relatedEntityId
          : this.relatedEntityId,
    );
  }
}
