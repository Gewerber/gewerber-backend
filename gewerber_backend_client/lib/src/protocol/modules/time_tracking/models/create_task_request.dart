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

abstract class CreateTaskRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CreateTaskRequest._({
    required this.projectId,
    required this.name,
    this.hourlyRateCents,
  });

  factory CreateTaskRequest({
    required int projectId,
    required String name,
    int? hourlyRateCents,
  }) = _CreateTaskRequestImpl;

  factory CreateTaskRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return CreateTaskRequest(
      projectId: jsonSerialization['projectId'] as int,
      name: jsonSerialization['name'] as String,
      hourlyRateCents: jsonSerialization['hourlyRateCents'] as int?,
    );
  }

  int projectId;

  String name;

  int? hourlyRateCents;

  /// Returns a shallow copy of this [CreateTaskRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CreateTaskRequest copyWith({
    int? projectId,
    String? name,
    int? hourlyRateCents,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateTaskRequest',
      'projectId': projectId,
      'name': name,
      if (hourlyRateCents != null) 'hourlyRateCents': hourlyRateCents,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreateTaskRequest',
      'projectId': projectId,
      'name': name,
      if (hourlyRateCents != null) 'hourlyRateCents': hourlyRateCents,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateTaskRequestImpl extends CreateTaskRequest {
  _CreateTaskRequestImpl({
    required int projectId,
    required String name,
    int? hourlyRateCents,
  }) : super._(
         projectId: projectId,
         name: name,
         hourlyRateCents: hourlyRateCents,
       );

  /// Returns a shallow copy of this [CreateTaskRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CreateTaskRequest copyWith({
    int? projectId,
    String? name,
    Object? hourlyRateCents = _Undefined,
  }) {
    return CreateTaskRequest(
      projectId: projectId ?? this.projectId,
      name: name ?? this.name,
      hourlyRateCents: hourlyRateCents is int?
          ? hourlyRateCents
          : this.hourlyRateCents,
    );
  }
}
