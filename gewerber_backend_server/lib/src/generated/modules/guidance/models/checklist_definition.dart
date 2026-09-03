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

import 'package:gewerber_backend_server/src/generated/protocol.dart'
    as _itzp2rm6;
import 'package:serverpod/serverpod.dart' as _is;
import '../../../modules/guidance/models/checklist_item_definition.dart'
    as _i1gzw9us;

abstract class ChecklistDefinition
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ChecklistDefinition._({
    required this.key,
    required this.title,
    required this.items,
  });

  factory ChecklistDefinition({
    required String key,
    required String title,
    required List<_i1gzw9us.ChecklistItemDefinition> items,
  }) = _ChecklistDefinitionImpl;

  factory ChecklistDefinition.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChecklistDefinition(
      key: jsonSerialization['key'] as String,
      title: jsonSerialization['title'] as String,
      items: _itzp2rm6.Protocol()
          .deserialize<List<_i1gzw9us.ChecklistItemDefinition>>(
            jsonSerialization['items'],
          ),
    );
  }

  String key;

  String title;

  List<_i1gzw9us.ChecklistItemDefinition> items;

  /// Returns a shallow copy of this [ChecklistDefinition]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ChecklistDefinition copyWith({
    String? key,
    String? title,
    List<_i1gzw9us.ChecklistItemDefinition>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChecklistDefinition',
      'key': key,
      'title': title,
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChecklistDefinition',
      'key': key,
      'title': title,
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ChecklistDefinitionImpl extends ChecklistDefinition {
  _ChecklistDefinitionImpl({
    required String key,
    required String title,
    required List<_i1gzw9us.ChecklistItemDefinition> items,
  }) : super._(
         key: key,
         title: title,
         items: items,
       );

  /// Returns a shallow copy of this [ChecklistDefinition]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ChecklistDefinition copyWith({
    String? key,
    String? title,
    List<_i1gzw9us.ChecklistItemDefinition>? items,
  }) {
    return ChecklistDefinition(
      key: key ?? this.key,
      title: title ?? this.title,
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
