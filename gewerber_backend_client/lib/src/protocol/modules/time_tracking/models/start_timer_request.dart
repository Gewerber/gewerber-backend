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

abstract class StartTimerRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StartTimerRequest._({
    this.projectId,
    this.taskId,
    this.description,
    this.startedAt,
    bool? billable,
  }) : billable = billable ?? true;

  factory StartTimerRequest({
    int? projectId,
    int? taskId,
    String? description,
    DateTime? startedAt,
    bool? billable,
  }) = _StartTimerRequestImpl;

  factory StartTimerRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return StartTimerRequest(
      projectId: jsonSerialization['projectId'] as int?,
      taskId: jsonSerialization['taskId'] as int?,
      description: jsonSerialization['description'] as String?,
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      billable: jsonSerialization['billable'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['billable']),
    );
  }

  int? projectId;

  int? taskId;

  String? description;

  DateTime? startedAt;

  bool billable;

  /// Returns a shallow copy of this [StartTimerRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StartTimerRequest copyWith({
    int? projectId,
    int? taskId,
    String? description,
    DateTime? startedAt,
    bool? billable,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StartTimerRequest',
      if (projectId != null) 'projectId': projectId,
      if (taskId != null) 'taskId': taskId,
      if (description != null) 'description': description,
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      'billable': billable,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StartTimerRequest',
      if (projectId != null) 'projectId': projectId,
      if (taskId != null) 'taskId': taskId,
      if (description != null) 'description': description,
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      'billable': billable,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StartTimerRequestImpl extends StartTimerRequest {
  _StartTimerRequestImpl({
    int? projectId,
    int? taskId,
    String? description,
    DateTime? startedAt,
    bool? billable,
  }) : super._(
         projectId: projectId,
         taskId: taskId,
         description: description,
         startedAt: startedAt,
         billable: billable,
       );

  /// Returns a shallow copy of this [StartTimerRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StartTimerRequest copyWith({
    Object? projectId = _Undefined,
    Object? taskId = _Undefined,
    Object? description = _Undefined,
    Object? startedAt = _Undefined,
    bool? billable,
  }) {
    return StartTimerRequest(
      projectId: projectId is int? ? projectId : this.projectId,
      taskId: taskId is int? ? taskId : this.taskId,
      description: description is String? ? description : this.description,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      billable: billable ?? this.billable,
    );
  }
}
