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
import '../../../modules/documents/models/document_kind.dart' as _iez1e0gu;
import '../../../modules/documents/models/storage_location.dart' as _i189k6zv;

abstract class Document
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Document._({
    this.id,
    required this.businessId,
    _iez1e0gu.DocumentKind? kind,
    required this.fileName,
    this.mimeType,
    this.sizeBytes,
    _i189k6zv.StorageLocation? storageLocation,
    required this.storagePath,
    this.relatedEntityType,
    this.relatedEntityId,
    this.uploadedById,
    DateTime? createdAt,
  }) : kind = kind ?? _iez1e0gu.DocumentKind.attachment,
       storageLocation = storageLocation ?? _i189k6zv.StorageLocation.private,
       createdAt = createdAt ?? DateTime.now();

  factory Document({
    int? id,
    required int businessId,
    _iez1e0gu.DocumentKind? kind,
    required String fileName,
    String? mimeType,
    int? sizeBytes,
    _i189k6zv.StorageLocation? storageLocation,
    required String storagePath,
    String? relatedEntityType,
    String? relatedEntityId,
    _isc.UuidValue? uploadedById,
    DateTime? createdAt,
  }) = _DocumentImpl;

  factory Document.fromJson(Map<String, dynamic> jsonSerialization) {
    return Document(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      kind: jsonSerialization['kind'] == null
          ? null
          : _iez1e0gu.DocumentKind.fromJson(
              (jsonSerialization['kind'] as String),
            ),
      fileName: jsonSerialization['fileName'] as String,
      mimeType: jsonSerialization['mimeType'] as String?,
      sizeBytes: jsonSerialization['sizeBytes'] as int?,
      storageLocation: jsonSerialization['storageLocation'] == null
          ? null
          : _i189k6zv.StorageLocation.fromJson(
              (jsonSerialization['storageLocation'] as String),
            ),
      storagePath: jsonSerialization['storagePath'] as String,
      relatedEntityType: jsonSerialization['relatedEntityType'] as String?,
      relatedEntityId: jsonSerialization['relatedEntityId'] as String?,
      uploadedById: jsonSerialization['uploadedById'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['uploadedById'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int businessId;

  _iez1e0gu.DocumentKind kind;

  String fileName;

  String? mimeType;

  int? sizeBytes;

  _i189k6zv.StorageLocation storageLocation;

  String storagePath;

  String? relatedEntityType;

  String? relatedEntityId;

  _isc.UuidValue? uploadedById;

  DateTime createdAt;

  /// Returns a shallow copy of this [Document]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Document copyWith({
    int? id,
    int? businessId,
    _iez1e0gu.DocumentKind? kind,
    String? fileName,
    String? mimeType,
    int? sizeBytes,
    _i189k6zv.StorageLocation? storageLocation,
    String? storagePath,
    String? relatedEntityType,
    String? relatedEntityId,
    _isc.UuidValue? uploadedById,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Document',
      if (id != null) 'id': id,
      'businessId': businessId,
      'kind': kind.toJson(),
      'fileName': fileName,
      if (mimeType != null) 'mimeType': mimeType,
      if (sizeBytes != null) 'sizeBytes': sizeBytes,
      'storageLocation': storageLocation.toJson(),
      'storagePath': storagePath,
      if (relatedEntityType != null) 'relatedEntityType': relatedEntityType,
      if (relatedEntityId != null) 'relatedEntityId': relatedEntityId,
      if (uploadedById != null) 'uploadedById': uploadedById?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Document',
      if (id != null) 'id': id,
      'businessId': businessId,
      'kind': kind.toJson(),
      'fileName': fileName,
      if (mimeType != null) 'mimeType': mimeType,
      if (sizeBytes != null) 'sizeBytes': sizeBytes,
      'storageLocation': storageLocation.toJson(),
      'storagePath': storagePath,
      if (relatedEntityType != null) 'relatedEntityType': relatedEntityType,
      if (relatedEntityId != null) 'relatedEntityId': relatedEntityId,
      if (uploadedById != null) 'uploadedById': uploadedById?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DocumentImpl extends Document {
  _DocumentImpl({
    int? id,
    required int businessId,
    _iez1e0gu.DocumentKind? kind,
    required String fileName,
    String? mimeType,
    int? sizeBytes,
    _i189k6zv.StorageLocation? storageLocation,
    required String storagePath,
    String? relatedEntityType,
    String? relatedEntityId,
    _isc.UuidValue? uploadedById,
    DateTime? createdAt,
  }) : super._(
         id: id,
         businessId: businessId,
         kind: kind,
         fileName: fileName,
         mimeType: mimeType,
         sizeBytes: sizeBytes,
         storageLocation: storageLocation,
         storagePath: storagePath,
         relatedEntityType: relatedEntityType,
         relatedEntityId: relatedEntityId,
         uploadedById: uploadedById,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Document]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Document copyWith({
    Object? id = _Undefined,
    int? businessId,
    _iez1e0gu.DocumentKind? kind,
    String? fileName,
    Object? mimeType = _Undefined,
    Object? sizeBytes = _Undefined,
    _i189k6zv.StorageLocation? storageLocation,
    String? storagePath,
    Object? relatedEntityType = _Undefined,
    Object? relatedEntityId = _Undefined,
    Object? uploadedById = _Undefined,
    DateTime? createdAt,
  }) {
    return Document(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      kind: kind ?? this.kind,
      fileName: fileName ?? this.fileName,
      mimeType: mimeType is String? ? mimeType : this.mimeType,
      sizeBytes: sizeBytes is int? ? sizeBytes : this.sizeBytes,
      storageLocation: storageLocation ?? this.storageLocation,
      storagePath: storagePath ?? this.storagePath,
      relatedEntityType: relatedEntityType is String?
          ? relatedEntityType
          : this.relatedEntityType,
      relatedEntityId: relatedEntityId is String?
          ? relatedEntityId
          : this.relatedEntityId,
      uploadedById: uploadedById is _isc.UuidValue?
          ? uploadedById
          : this.uploadedById,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
