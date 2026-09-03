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

abstract class CreateTimeEntryRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CreateTimeEntryRequest._({
    this.projectId,
    this.taskId,
    this.description,
    required this.startedAt,
    required this.durationMinutes,
    bool? billable,
  }) : billable = billable ?? true;

  factory CreateTimeEntryRequest({
    int? projectId,
    int? taskId,
    String? description,
    required DateTime startedAt,
    required int durationMinutes,
    bool? billable,
  }) = _CreateTimeEntryRequestImpl;

  factory CreateTimeEntryRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateTimeEntryRequest(
      projectId: jsonSerialization['projectId'] as int?,
      taskId: jsonSerialization['taskId'] as int?,
      description: jsonSerialization['description'] as String?,
      startedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['startedAt'],
      ),
      durationMinutes: jsonSerialization['durationMinutes'] as int,
      billable: jsonSerialization['billable'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['billable']),
    );
  }

  int? projectId;

  int? taskId;

  String? description;

  DateTime startedAt;

  int durationMinutes;

  bool billable;

  /// Returns a shallow copy of this [CreateTimeEntryRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CreateTimeEntryRequest copyWith({
    int? projectId,
    int? taskId,
    String? description,
    DateTime? startedAt,
    int? durationMinutes,
    bool? billable,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateTimeEntryRequest',
      if (projectId != null) 'projectId': projectId,
      if (taskId != null) 'taskId': taskId,
      if (description != null) 'description': description,
      'startedAt': startedAt.toJson(),
      'durationMinutes': durationMinutes,
      'billable': billable,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreateTimeEntryRequest',
      if (projectId != null) 'projectId': projectId,
      if (taskId != null) 'taskId': taskId,
      if (description != null) 'description': description,
      'startedAt': startedAt.toJson(),
      'durationMinutes': durationMinutes,
      'billable': billable,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateTimeEntryRequestImpl extends CreateTimeEntryRequest {
  _CreateTimeEntryRequestImpl({
    int? projectId,
    int? taskId,
    String? description,
    required DateTime startedAt,
    required int durationMinutes,
    bool? billable,
  }) : super._(
         projectId: projectId,
         taskId: taskId,
         description: description,
         startedAt: startedAt,
         durationMinutes: durationMinutes,
         billable: billable,
       );

  /// Returns a shallow copy of this [CreateTimeEntryRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CreateTimeEntryRequest copyWith({
    Object? projectId = _Undefined,
    Object? taskId = _Undefined,
    Object? description = _Undefined,
    DateTime? startedAt,
    int? durationMinutes,
    bool? billable,
  }) {
    return CreateTimeEntryRequest(
      projectId: projectId is int? ? projectId : this.projectId,
      taskId: taskId is int? ? taskId : this.taskId,
      description: description is String? ? description : this.description,
      startedAt: startedAt ?? this.startedAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      billable: billable ?? this.billable,
    );
  }
}
