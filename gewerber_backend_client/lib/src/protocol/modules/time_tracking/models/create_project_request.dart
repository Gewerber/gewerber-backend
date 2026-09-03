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

abstract class CreateProjectRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CreateProjectRequest._({
    required this.name,
    this.customerId,
    this.hourlyRateCents,
    this.notes,
  });

  factory CreateProjectRequest({
    required String name,
    int? customerId,
    int? hourlyRateCents,
    String? notes,
  }) = _CreateProjectRequestImpl;

  factory CreateProjectRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateProjectRequest(
      name: jsonSerialization['name'] as String,
      customerId: jsonSerialization['customerId'] as int?,
      hourlyRateCents: jsonSerialization['hourlyRateCents'] as int?,
      notes: jsonSerialization['notes'] as String?,
    );
  }

  String name;

  int? customerId;

  int? hourlyRateCents;

  String? notes;

  /// Returns a shallow copy of this [CreateProjectRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CreateProjectRequest copyWith({
    String? name,
    int? customerId,
    int? hourlyRateCents,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateProjectRequest',
      'name': name,
      if (customerId != null) 'customerId': customerId,
      if (hourlyRateCents != null) 'hourlyRateCents': hourlyRateCents,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreateProjectRequest',
      'name': name,
      if (customerId != null) 'customerId': customerId,
      if (hourlyRateCents != null) 'hourlyRateCents': hourlyRateCents,
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateProjectRequestImpl extends CreateProjectRequest {
  _CreateProjectRequestImpl({
    required String name,
    int? customerId,
    int? hourlyRateCents,
    String? notes,
  }) : super._(
         name: name,
         customerId: customerId,
         hourlyRateCents: hourlyRateCents,
         notes: notes,
       );

  /// Returns a shallow copy of this [CreateProjectRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CreateProjectRequest copyWith({
    String? name,
    Object? customerId = _Undefined,
    Object? hourlyRateCents = _Undefined,
    Object? notes = _Undefined,
  }) {
    return CreateProjectRequest(
      name: name ?? this.name,
      customerId: customerId is int? ? customerId : this.customerId,
      hourlyRateCents: hourlyRateCents is int?
          ? hourlyRateCents
          : this.hourlyRateCents,
      notes: notes is String? ? notes : this.notes,
    );
  }
}
