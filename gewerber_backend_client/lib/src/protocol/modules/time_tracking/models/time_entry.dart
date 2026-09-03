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

abstract class TimeEntry
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  TimeEntry._({
    this.id,
    required this.businessId,
    this.projectId,
    this.taskId,
    this.description,
    required this.startedAt,
    this.stoppedAt,
    this.durationMinutes,
    bool? billable,
    this.invoicedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : billable = billable ?? true,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory TimeEntry({
    int? id,
    required int businessId,
    int? projectId,
    int? taskId,
    String? description,
    required DateTime startedAt,
    DateTime? stoppedAt,
    int? durationMinutes,
    bool? billable,
    DateTime? invoicedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TimeEntryImpl;

  factory TimeEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return TimeEntry(
      id: jsonSerialization['id'] as int?,
      businessId: jsonSerialization['businessId'] as int,
      projectId: jsonSerialization['projectId'] as int?,
      taskId: jsonSerialization['taskId'] as int?,
      description: jsonSerialization['description'] as String?,
      startedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      stoppedAt: jsonSerialization['stoppedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['stoppedAt']),
      durationMinutes: jsonSerialization['durationMinutes'] as int?,
      billable: jsonSerialization['billable'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['billable']),
      invoicedAt: jsonSerialization['invoicedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['invoicedAt'],
            ),
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

  int? projectId;

  int? taskId;

  String? description;

  DateTime startedAt;

  DateTime? stoppedAt;

  int? durationMinutes;

  bool billable;

  DateTime? invoicedAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [TimeEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  TimeEntry copyWith({
    int? id,
    int? businessId,
    int? projectId,
    int? taskId,
    String? description,
    DateTime? startedAt,
    DateTime? stoppedAt,
    int? durationMinutes,
    bool? billable,
    DateTime? invoicedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TimeEntry',
      if (id != null) 'id': id,
      'businessId': businessId,
      if (projectId != null) 'projectId': projectId,
      if (taskId != null) 'taskId': taskId,
      if (description != null) 'description': description,
      'startedAt': startedAt.toJson(),
      if (stoppedAt != null) 'stoppedAt': stoppedAt?.toJson(),
      if (durationMinutes != null) 'durationMinutes': durationMinutes,
      'billable': billable,
      if (invoicedAt != null) 'invoicedAt': invoicedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TimeEntry',
      if (id != null) 'id': id,
      'businessId': businessId,
      if (projectId != null) 'projectId': projectId,
      if (taskId != null) 'taskId': taskId,
      if (description != null) 'description': description,
      'startedAt': startedAt.toJson(),
      if (stoppedAt != null) 'stoppedAt': stoppedAt?.toJson(),
      if (durationMinutes != null) 'durationMinutes': durationMinutes,
      'billable': billable,
      if (invoicedAt != null) 'invoicedAt': invoicedAt?.toJson(),
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

class _TimeEntryImpl extends TimeEntry {
  _TimeEntryImpl({
    int? id,
    required int businessId,
    int? projectId,
    int? taskId,
    String? description,
    required DateTime startedAt,
    DateTime? stoppedAt,
    int? durationMinutes,
    bool? billable,
    DateTime? invoicedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         businessId: businessId,
         projectId: projectId,
         taskId: taskId,
         description: description,
         startedAt: startedAt,
         stoppedAt: stoppedAt,
         durationMinutes: durationMinutes,
         billable: billable,
         invoicedAt: invoicedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [TimeEntry]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  TimeEntry copyWith({
    Object? id = _Undefined,
    int? businessId,
    Object? projectId = _Undefined,
    Object? taskId = _Undefined,
    Object? description = _Undefined,
    DateTime? startedAt,
    Object? stoppedAt = _Undefined,
    Object? durationMinutes = _Undefined,
    bool? billable,
    Object? invoicedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TimeEntry(
      id: id is int? ? id : this.id,
      businessId: businessId ?? this.businessId,
      projectId: projectId is int? ? projectId : this.projectId,
      taskId: taskId is int? ? taskId : this.taskId,
      description: description is String? ? description : this.description,
      startedAt: startedAt ?? this.startedAt,
      stoppedAt: stoppedAt is DateTime? ? stoppedAt : this.stoppedAt,
      durationMinutes: durationMinutes is int?
          ? durationMinutes
          : this.durationMinutes,
      billable: billable ?? this.billable,
      invoicedAt: invoicedAt is DateTime? ? invoicedAt : this.invoicedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
