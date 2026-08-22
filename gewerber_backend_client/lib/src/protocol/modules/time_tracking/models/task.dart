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
import '../../../modules/time_tracking/models/task_status.dart' as _i2;

abstract class Task
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  Task._({
    this.id,
    required this.businessId,
    required this.projectId,
    required this.name,
    _i2.TaskStatus? status,
    this.hourlyRateCents,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : status = status ?? _i2.TaskStatus.open,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Task({
    int? id,
    required int businessId,
    required int projectId,
    required String name,
    _i2.TaskStatus? status,
    int? hourlyRateCents,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TaskImpl;

  factory Task.fromJson(Map<String, dynamic> jsonSerialization) {
    return Task(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      projectId: jsonSerialization['projectId'] as int,
      name: jsonSerialization['name'] as String,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.TaskStatus.fromJson((jsonSerialization['status'] as String)),
      hourlyRateCents: jsonSerialization['hourlyRateCents'] as int?,
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

  int businessId;

  int projectId;

  String name;

  _i2.TaskStatus status;

  int? hourlyRateCents;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Task]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Task copyWith({
    int? id,
    int? businessId,
    int? projectId,
    String? name,
    _i2.TaskStatus? status,
    int? hourlyRateCents,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Task',
      if (id != null) 'id': id,
      'businessId': businessId,
      'projectId': projectId,
      'name': name,
      'status': status.toJson(),
      if (hourlyRateCents != null) 'hourlyRateCents': hourlyRateCents,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Task',
      if (id != null) 'id': id,
      'businessId': businessId,
      'projectId': projectId,
      'name': name,
      'status': status.toJson(),
      if (hourlyRateCents != null) 'hourlyRateCents': hourlyRateCents,
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

class _TaskImpl extends Task {
  _TaskImpl({
    int? id,
    required int businessId,
    required int projectId,
    required String name,
    _i2.TaskStatus? status,
    int? hourlyRateCents,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         businessId: businessId,
         projectId: projectId,
         name: name,
         status: status,
         hourlyRateCents: hourlyRateCents,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Task]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Task copyWith({
    Object? id = _Undefined,
    int? businessId,
    int? projectId,
    String? name,
    _i2.TaskStatus? status,
    Object? hourlyRateCents = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Task(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      projectId: projectId ?? this.projectId,
      name: name ?? this.name,
      status: status ?? this.status,
      hourlyRateCents: hourlyRateCents is int?
          ? hourlyRateCents
          : this.hourlyRateCents,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
