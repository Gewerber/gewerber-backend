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

import 'package:serverpod/serverpod.dart' as _is;

abstract class TimeReportLine
    implements _is.SerializableModel, _is.ProtocolSerialization {
  TimeReportLine._({
    this.projectId,
    this.projectName,
    this.taskId,
    this.taskName,
    required this.entryCount,
    required this.totalMinutes,
    required this.billableMinutes,
    required this.roundedMinutes,
  });

  factory TimeReportLine({
    int? projectId,
    String? projectName,
    int? taskId,
    String? taskName,
    required int entryCount,
    required int totalMinutes,
    required int billableMinutes,
    required int roundedMinutes,
  }) = _TimeReportLineImpl;

  factory TimeReportLine.fromJson(Map<String, dynamic> jsonSerialization) {
    return TimeReportLine(
      projectId: jsonSerialization['projectId'] as int?,
      projectName: jsonSerialization['projectName'] as String?,
      taskId: jsonSerialization['taskId'] as int?,
      taskName: jsonSerialization['taskName'] as String?,
      entryCount: jsonSerialization['entryCount'] as int,
      totalMinutes: jsonSerialization['totalMinutes'] as int,
      billableMinutes: jsonSerialization['billableMinutes'] as int,
      roundedMinutes: jsonSerialization['roundedMinutes'] as int,
    );
  }

  int? projectId;

  String? projectName;

  int? taskId;

  String? taskName;

  int entryCount;

  int totalMinutes;

  int billableMinutes;

  int roundedMinutes;

  /// Returns a shallow copy of this [TimeReportLine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TimeReportLine copyWith({
    int? projectId,
    String? projectName,
    int? taskId,
    String? taskName,
    int? entryCount,
    int? totalMinutes,
    int? billableMinutes,
    int? roundedMinutes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TimeReportLine',
      if (projectId != null) 'projectId': projectId,
      if (projectName != null) 'projectName': projectName,
      if (taskId != null) 'taskId': taskId,
      if (taskName != null) 'taskName': taskName,
      'entryCount': entryCount,
      'totalMinutes': totalMinutes,
      'billableMinutes': billableMinutes,
      'roundedMinutes': roundedMinutes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TimeReportLine',
      if (projectId != null) 'projectId': projectId,
      if (projectName != null) 'projectName': projectName,
      if (taskId != null) 'taskId': taskId,
      if (taskName != null) 'taskName': taskName,
      'entryCount': entryCount,
      'totalMinutes': totalMinutes,
      'billableMinutes': billableMinutes,
      'roundedMinutes': roundedMinutes,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TimeReportLineImpl extends TimeReportLine {
  _TimeReportLineImpl({
    int? projectId,
    String? projectName,
    int? taskId,
    String? taskName,
    required int entryCount,
    required int totalMinutes,
    required int billableMinutes,
    required int roundedMinutes,
  }) : super._(
         projectId: projectId,
         projectName: projectName,
         taskId: taskId,
         taskName: taskName,
         entryCount: entryCount,
         totalMinutes: totalMinutes,
         billableMinutes: billableMinutes,
         roundedMinutes: roundedMinutes,
       );

  /// Returns a shallow copy of this [TimeReportLine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TimeReportLine copyWith({
    Object? projectId = _Undefined,
    Object? projectName = _Undefined,
    Object? taskId = _Undefined,
    Object? taskName = _Undefined,
    int? entryCount,
    int? totalMinutes,
    int? billableMinutes,
    int? roundedMinutes,
  }) {
    return TimeReportLine(
      projectId: projectId is int? ? projectId : this.projectId,
      projectName: projectName is String? ? projectName : this.projectName,
      taskId: taskId is int? ? taskId : this.taskId,
      taskName: taskName is String? ? taskName : this.taskName,
      entryCount: entryCount ?? this.entryCount,
      totalMinutes: totalMinutes ?? this.totalMinutes,
      billableMinutes: billableMinutes ?? this.billableMinutes,
      roundedMinutes: roundedMinutes ?? this.roundedMinutes,
    );
  }
}
