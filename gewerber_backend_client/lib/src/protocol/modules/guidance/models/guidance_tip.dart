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

abstract class GuidanceTip
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  GuidanceTip._({
    required this.topic,
    required this.title,
    required this.body,
  });

  factory GuidanceTip({
    required String topic,
    required String title,
    required String body,
  }) = _GuidanceTipImpl;

  factory GuidanceTip.fromJson(Map<String, dynamic> jsonSerialization) {
    return GuidanceTip(
      topic: jsonSerialization['topic'] as String,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
    );
  }

  String topic;

  String title;

  String body;

  /// Returns a shallow copy of this [GuidanceTip]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GuidanceTip copyWith({
    String? topic,
    String? title,
    String? body,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GuidanceTip',
      'topic': topic,
      'title': title,
      'body': body,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GuidanceTip',
      'topic': topic,
      'title': title,
      'body': body,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GuidanceTipImpl extends GuidanceTip {
  _GuidanceTipImpl({
    required String topic,
    required String title,
    required String body,
  }) : super._(
         topic: topic,
         title: title,
         body: body,
       );

  /// Returns a shallow copy of this [GuidanceTip]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GuidanceTip copyWith({
    String? topic,
    String? title,
    String? body,
  }) {
    return GuidanceTip(
      topic: topic ?? this.topic,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}
