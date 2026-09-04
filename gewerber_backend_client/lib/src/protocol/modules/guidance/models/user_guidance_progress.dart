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

abstract class UserGuidanceProgress
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  UserGuidanceProgress._({
    this.id,
    this.userId,
    required this.itemKey,
    this.completedAt,
    this.dismissedAt,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory UserGuidanceProgress({
    int? id,
    _isc.UuidValue? userId,
    required String itemKey,
    DateTime? completedAt,
    DateTime? dismissedAt,
    DateTime? updatedAt,
  }) = _UserGuidanceProgressImpl;

  factory UserGuidanceProgress.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UserGuidanceProgress(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      itemKey: jsonSerialization['itemKey'] as String,
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      dismissedAt: jsonSerialization['dismissedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['dismissedAt'],
            ),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// Nullable: set to null when the account is deleted (GDPR Art. 17).
  _isc.UuidValue? userId;

  String itemKey;

  DateTime? completedAt;

  DateTime? dismissedAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [UserGuidanceProgress]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  UserGuidanceProgress copyWith({
    int? id,
    _isc.UuidValue? userId,
    String? itemKey,
    DateTime? completedAt,
    DateTime? dismissedAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserGuidanceProgress',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId?.toJson(),
      'itemKey': itemKey,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (dismissedAt != null) 'dismissedAt': dismissedAt?.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserGuidanceProgress',
      if (id != null) 'id': id,
      if (userId != null) 'userId': userId?.toJson(),
      'itemKey': itemKey,
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (dismissedAt != null) 'dismissedAt': dismissedAt?.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserGuidanceProgressImpl extends UserGuidanceProgress {
  _UserGuidanceProgressImpl({
    int? id,
    _isc.UuidValue? userId,
    required String itemKey,
    DateTime? completedAt,
    DateTime? dismissedAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         itemKey: itemKey,
         completedAt: completedAt,
         dismissedAt: dismissedAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [UserGuidanceProgress]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  UserGuidanceProgress copyWith({
    Object? id = _Undefined,
    Object? userId = _Undefined,
    String? itemKey,
    Object? completedAt = _Undefined,
    Object? dismissedAt = _Undefined,
    DateTime? updatedAt,
  }) {
    return UserGuidanceProgress(
      id: id is int? ? id : this.id,
      userId: userId is _isc.UuidValue? ? userId : this.userId,
      itemKey: itemKey ?? this.itemKey,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      dismissedAt: dismissedAt is DateTime? ? dismissedAt : this.dismissedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
