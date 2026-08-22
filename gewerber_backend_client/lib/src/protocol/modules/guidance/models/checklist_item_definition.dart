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

abstract class ChecklistItemDefinition
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ChecklistItemDefinition._({
    required this.key,
    required this.title,
    this.body,
  });

  factory ChecklistItemDefinition({
    required String key,
    required String title,
    String? body,
  }) = _ChecklistItemDefinitionImpl;

  factory ChecklistItemDefinition.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ChecklistItemDefinition(
      key: jsonSerialization['key'] as String,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String?,
    );
  }

  String key;

  String title;

  String? body;

  /// Returns a shallow copy of this [ChecklistItemDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChecklistItemDefinition copyWith({
    String? key,
    String? title,
    String? body,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChecklistItemDefinition',
      'key': key,
      'title': title,
      if (body != null) 'body': body,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChecklistItemDefinition',
      'key': key,
      'title': title,
      if (body != null) 'body': body,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChecklistItemDefinitionImpl extends ChecklistItemDefinition {
  _ChecklistItemDefinitionImpl({
    required String key,
    required String title,
    String? body,
  }) : super._(
         key: key,
         title: title,
         body: body,
       );

  /// Returns a shallow copy of this [ChecklistItemDefinition]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChecklistItemDefinition copyWith({
    String? key,
    String? title,
    Object? body = _Undefined,
  }) {
    return ChecklistItemDefinition(
      key: key ?? this.key,
      title: title ?? this.title,
      body: body is String? ? body : this.body,
    );
  }
}
