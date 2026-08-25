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
import 'package:gewerber_backend_server/src/generated/protocol.dart' as _i2;

/// Client-visible projection of the server-only [AuditEntry].
abstract class AdminAuditEntry
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdminAuditEntry._({
    this.id,
    this.businessId,
    this.userId,
    required this.action,
    required this.entityType,
    this.entityId,
    this.changes,
    required this.createdAt,
  });

  factory AdminAuditEntry({
    int? id,
    int? businessId,
    _i1.UuidValue? userId,
    required String action,
    required String entityType,
    String? entityId,
    Map<String, String>? changes,
    required DateTime createdAt,
  }) = _AdminAuditEntryImpl;

  factory AdminAuditEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminAuditEntry(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int?,
      userId: jsonSerialization['userId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      action: jsonSerialization['action'] as String,
      entityType: jsonSerialization['entityType'] as String,
      entityId: jsonSerialization['entityId'] as String?,
      changes: jsonSerialization['changes'] == null
          ? null
          : _i2.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['changes'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  int? id;

  int? businessId;

  _i1.UuidValue? userId;

  String action;

  String entityType;

  String? entityId;

  Map<String, String>? changes;

  DateTime createdAt;

  /// Returns a shallow copy of this [AdminAuditEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminAuditEntry copyWith({
    int? id,
    int? businessId,
    _i1.UuidValue? userId,
    String? action,
    String? entityType,
    String? entityId,
    Map<String, String>? changes,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminAuditEntry',
      if (id != null) 'id': id,
      if (businessId != null) 'businessId': businessId,
      if (userId != null) 'userId': userId?.toJson(),
      'action': action,
      'entityType': entityType,
      if (entityId != null) 'entityId': entityId,
      if (changes != null) 'changes': changes?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminAuditEntry',
      if (id != null) 'id': id,
      if (businessId != null) 'businessId': businessId,
      if (userId != null) 'userId': userId?.toJson(),
      'action': action,
      'entityType': entityType,
      if (entityId != null) 'entityId': entityId,
      if (changes != null) 'changes': changes?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AdminAuditEntryImpl extends AdminAuditEntry {
  _AdminAuditEntryImpl({
    int? id,
    int? businessId,
    _i1.UuidValue? userId,
    required String action,
    required String entityType,
    String? entityId,
    Map<String, String>? changes,
    required DateTime createdAt,
  }) : super._(
         id: id,
         businessId: businessId,
         userId: userId,
         action: action,
         entityType: entityType,
         entityId: entityId,
         changes: changes,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AdminAuditEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminAuditEntry copyWith({
    Object? id = _Undefined,
    Object? businessId = _Undefined,
    Object? userId = _Undefined,
    String? action,
    String? entityType,
    Object? entityId = _Undefined,
    Object? changes = _Undefined,
    DateTime? createdAt,
  }) {
    return AdminAuditEntry(
      id: id is int? ? id : this.id,
      businessId: businessId is int? ? businessId : this.businessId,
      userId: userId is _i1.UuidValue? ? userId : this.userId,
      action: action ?? this.action,
      entityType: entityType ?? this.entityType,
      entityId: entityId is String? ? entityId : this.entityId,
      changes: changes is Map<String, String>?
          ? changes
          : this.changes?.map(
              (
                key0,
                value0,
              ) => MapEntry(
                key0,
                value0,
              ),
            ),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
