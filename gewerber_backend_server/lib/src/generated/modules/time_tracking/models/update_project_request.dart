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
import '../../../modules/time_tracking/models/project_status.dart' as _i2;

abstract class UpdateProjectRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UpdateProjectRequest._({
    required this.projectId,
    required this.name,
    required this.status,
    this.customerId,
    this.hourlyRateCents,
    this.notes,
  });

  factory UpdateProjectRequest({
    required int projectId,
    required String name,
    required _i2.ProjectStatus status,
    int? customerId,
    int? hourlyRateCents,
    String? notes,
  }) = _UpdateProjectRequestImpl;

  factory UpdateProjectRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UpdateProjectRequest(
      projectId: jsonSerialization['projectId'] as int,
      name: jsonSerialization['name'] as String,
      status: _i2.ProjectStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      customerId: jsonSerialization['customerId'] as int?,
      hourlyRateCents: jsonSerialization['hourlyRateCents'] as int?,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  int projectId;

  String name;

  _i2.ProjectStatus status;

  int? customerId;

  int? hourlyRateCents;

  String? notes;

  /// Returns a shallow copy of this [UpdateProjectRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UpdateProjectRequest copyWith({
    int? projectId,
    String? name,
    _i2.ProjectStatus? status,
    int? customerId,
    int? hourlyRateCents,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UpdateProjectRequest',
      'projectId': projectId,
      'name': name,
      'status': status.toJson(),
      if (customerId != null) 'customerId': customerId,
      if (hourlyRateCents != null) 'hourlyRateCents': hourlyRateCents,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UpdateProjectRequest',
      'projectId': projectId,
      'name': name,
      'status': status.toJson(),
      if (customerId != null) 'customerId': customerId,
      if (hourlyRateCents != null) 'hourlyRateCents': hourlyRateCents,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UpdateProjectRequestImpl extends UpdateProjectRequest {
  _UpdateProjectRequestImpl({
    required int projectId,
    required String name,
    required _i2.ProjectStatus status,
    int? customerId,
    int? hourlyRateCents,
    String? notes,
  }) : super._(
         projectId: projectId,
         name: name,
         status: status,
         customerId: customerId,
         hourlyRateCents: hourlyRateCents,
         notes: notes,
       );

  /// Returns a shallow copy of this [UpdateProjectRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UpdateProjectRequest copyWith({
    int? projectId,
    String? name,
    _i2.ProjectStatus? status,
    Object? customerId = _Undefined,
    Object? hourlyRateCents = _Undefined,
    Object? notes = _Undefined,
  }) {
    return UpdateProjectRequest(
      projectId: projectId ?? this.projectId,
      name: name ?? this.name,
      status: status ?? this.status,
      customerId: customerId is int? ? customerId : this.customerId,
      hourlyRateCents: hourlyRateCents is int?
          ? hourlyRateCents
          : this.hourlyRateCents,
      notes: notes is String? ? notes : this.notes,
    );
  }
}
