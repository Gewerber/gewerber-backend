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
import '../../../modules/time_tracking/models/task_status.dart' as _i2;

abstract class UpdateTaskRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UpdateTaskRequest._({
    required this.taskId,
    required this.name,
    required this.status,
    this.hourlyRateCents,
  });

  factory UpdateTaskRequest({
    required int taskId,
    required String name,
    required _i2.TaskStatus status,
    int? hourlyRateCents,
  }) = _UpdateTaskRequestImpl;

  factory UpdateTaskRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return UpdateTaskRequest(
      taskId: jsonSerialization['taskId'] as int,
      name: jsonSerialization['name'] as String,
      status: _i2.TaskStatus.fromJson((jsonSerialization['status'] as String)),
      hourlyRateCents: jsonSerialization['hourlyRateCents'] as int?,
    );
  }

  int taskId;

  String name;

  _i2.TaskStatus status;

  int? hourlyRateCents;

  /// Returns a shallow copy of this [UpdateTaskRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UpdateTaskRequest copyWith({
    int? taskId,
    String? name,
    _i2.TaskStatus? status,
    int? hourlyRateCents,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UpdateTaskRequest',
      'taskId': taskId,
      'name': name,
      'status': status.toJson(),
      if (hourlyRateCents != null) 'hourlyRateCents': hourlyRateCents,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UpdateTaskRequest',
      'taskId': taskId,
      'name': name,
      'status': status.toJson(),
      if (hourlyRateCents != null) 'hourlyRateCents': hourlyRateCents,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UpdateTaskRequestImpl extends UpdateTaskRequest {
  _UpdateTaskRequestImpl({
    required int taskId,
    required String name,
    required _i2.TaskStatus status,
    int? hourlyRateCents,
  }) : super._(
         taskId: taskId,
         name: name,
         status: status,
         hourlyRateCents: hourlyRateCents,
       );

  /// Returns a shallow copy of this [UpdateTaskRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UpdateTaskRequest copyWith({
    int? taskId,
    String? name,
    _i2.TaskStatus? status,
    Object? hourlyRateCents = _Undefined,
  }) {
    return UpdateTaskRequest(
      taskId: taskId ?? this.taskId,
      name: name ?? this.name,
      status: status ?? this.status,
      hourlyRateCents: hourlyRateCents is int?
          ? hourlyRateCents
          : this.hourlyRateCents,
    );
  }
}
