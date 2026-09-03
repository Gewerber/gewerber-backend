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
import '../../../modules/time_tracking/models/project_status.dart' as _i1ujg7mu;

abstract class Project
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Project._({
    this.id,
    required this.businessId,
    required this.name,
    _i1ujg7mu.ProjectStatus? status,
    this.customerId,
    this.hourlyRateCents,
    this.notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : status = status ?? _i1ujg7mu.ProjectStatus.active,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Project({
    int? id,
    required int businessId,
    required String name,
    _i1ujg7mu.ProjectStatus? status,
    int? customerId,
    int? hourlyRateCents,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProjectImpl;

  factory Project.fromJson(Map<String, dynamic> jsonSerialization) {
    return Project(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      name: jsonSerialization['name'] as String,
      status: jsonSerialization['status'] == null
          ? null
          : _i1ujg7mu.ProjectStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      customerId: jsonSerialization['customerId'] as int?,
      hourlyRateCents: jsonSerialization['hourlyRateCents'] as int?,
      notes: jsonSerialization['notes'] as String?,
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

  _i1ujg7mu.ProjectStatus status;

  int? customerId;

  int? hourlyRateCents;

  String? notes;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Project copyWith({
    int? id,
    int? businessId,
    String? name,
    _i1ujg7mu.ProjectStatus? status,
    int? customerId,
    int? hourlyRateCents,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Project',
      if (id != null) 'id': id,
      'businessId': businessId,
      'name': name,
      'status': status.toJson(),
      if (customerId != null) 'customerId': customerId,
      if (hourlyRateCents != null) 'hourlyRateCents': hourlyRateCents,
      if (notes != null) 'notes': notes,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Project',
      if (id != null) 'id': id,
      'businessId': businessId,
      'name': name,
      'status': status.toJson(),
      if (customerId != null) 'customerId': customerId,
      if (hourlyRateCents != null) 'hourlyRateCents': hourlyRateCents,
      if (notes != null) 'notes': notes,
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

class _ProjectImpl extends Project {
  _ProjectImpl({
    int? id,
    required int businessId,
    required String name,
    _i1ujg7mu.ProjectStatus? status,
    int? customerId,
    int? hourlyRateCents,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         businessId: businessId,
         name: name,
         status: status,
         customerId: customerId,
         hourlyRateCents: hourlyRateCents,
         notes: notes,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Project]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Project copyWith({
    Object? id = _Undefined,
    int? businessId,
    String? name,
    _i1ujg7mu.ProjectStatus? status,
    Object? customerId = _Undefined,
    Object? hourlyRateCents = _Undefined,
    Object? notes = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Project(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      name: name ?? this.name,
      status: status ?? this.status,
      customerId: customerId is int? ? customerId : this.customerId,
      hourlyRateCents: hourlyRateCents is int?
          ? hourlyRateCents
          : this.hourlyRateCents,
      notes: notes is String? ? notes : this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
