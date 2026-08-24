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

abstract class RecentTimeEntry
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  RecentTimeEntry._({
    required this.id,
    required this.startedAt,
    this.stoppedAt,
    this.durationMinutes,
    required this.billable,
    this.projectId,
    this.projectName,
    this.taskId,
    this.taskName,
  });

  factory RecentTimeEntry({
    required int id,
    required DateTime startedAt,
    DateTime? stoppedAt,
    int? durationMinutes,
    required bool billable,
    int? projectId,
    String? projectName,
    int? taskId,
    String? taskName,
  }) = _RecentTimeEntryImpl;

  factory RecentTimeEntry.fromJson(Map<String, dynamic> jsonSerialization) {
    return RecentTimeEntry(
      id: jsonSerialization['id'] as int,
      startedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      stoppedAt: jsonSerialization['stoppedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['stoppedAt']),
      durationMinutes: jsonSerialization['durationMinutes'] as int?,
      billable: _i1.BoolJsonExtension.fromJson(jsonSerialization['billable']),
      projectId: jsonSerialization['projectId'] as int?,
      projectName: jsonSerialization['projectName'] as String?,
      taskId: jsonSerialization['taskId'] as int?,
      taskName: jsonSerialization['taskName'] as String?,
    );
  }

  int id;

  DateTime startedAt;

  DateTime? stoppedAt;

  int? durationMinutes;

  bool billable;

  int? projectId;

  String? projectName;

  int? taskId;

  String? taskName;

  /// Returns a shallow copy of this [RecentTimeEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RecentTimeEntry copyWith({
    int? id,
    DateTime? startedAt,
    DateTime? stoppedAt,
    int? durationMinutes,
    bool? billable,
    int? projectId,
    String? projectName,
    int? taskId,
    String? taskName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RecentTimeEntry',
      'id': id,
      'startedAt': startedAt.toJson(),
      if (stoppedAt != null) 'stoppedAt': stoppedAt?.toJson(),
      if (durationMinutes != null) 'durationMinutes': durationMinutes,
      'billable': billable,
      if (projectId != null) 'projectId': projectId,
      if (projectName != null) 'projectName': projectName,
      if (taskId != null) 'taskId': taskId,
      if (taskName != null) 'taskName': taskName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RecentTimeEntry',
      'id': id,
      'startedAt': startedAt.toJson(),
      if (stoppedAt != null) 'stoppedAt': stoppedAt?.toJson(),
      if (durationMinutes != null) 'durationMinutes': durationMinutes,
      'billable': billable,
      if (projectId != null) 'projectId': projectId,
      if (projectName != null) 'projectName': projectName,
      if (taskId != null) 'taskId': taskId,
      if (taskName != null) 'taskName': taskName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RecentTimeEntryImpl extends RecentTimeEntry {
  _RecentTimeEntryImpl({
    required int id,
    required DateTime startedAt,
    DateTime? stoppedAt,
    int? durationMinutes,
    required bool billable,
    int? projectId,
    String? projectName,
    int? taskId,
    String? taskName,
  }) : super._(
         id: id,
         startedAt: startedAt,
         stoppedAt: stoppedAt,
         durationMinutes: durationMinutes,
         billable: billable,
         projectId: projectId,
         projectName: projectName,
         taskId: taskId,
         taskName: taskName,
       );

  /// Returns a shallow copy of this [RecentTimeEntry]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RecentTimeEntry copyWith({
    int? id,
    DateTime? startedAt,
    Object? stoppedAt = _Undefined,
    Object? durationMinutes = _Undefined,
    bool? billable,
    Object? projectId = _Undefined,
    Object? projectName = _Undefined,
    Object? taskId = _Undefined,
    Object? taskName = _Undefined,
  }) {
    return RecentTimeEntry(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      stoppedAt: stoppedAt is DateTime? ? stoppedAt : this.stoppedAt,
      durationMinutes: durationMinutes is int?
          ? durationMinutes
          : this.durationMinutes,
      billable: billable ?? this.billable,
      projectId: projectId is int? ? projectId : this.projectId,
      projectName: projectName is String? ? projectName : this.projectName,
      taskId: taskId is int? ? taskId : this.taskId,
      taskName: taskName is String? ? taskName : this.taskName,
    );
  }
}
