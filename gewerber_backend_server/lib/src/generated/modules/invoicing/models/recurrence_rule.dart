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
import '../../../modules/invoicing/models/recurrence_interval.dart' as _i2;

abstract class RecurrenceRule
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  RecurrenceRule._({
    required this.interval,
    required this.nextDate,
    this.endDate,
    this.maxOccurrences,
    int? occurrencesCreated,
  }) : occurrencesCreated = occurrencesCreated ?? 0;

  factory RecurrenceRule({
    required _i2.RecurrenceInterval interval,
    required DateTime nextDate,
    DateTime? endDate,
    int? maxOccurrences,
    int? occurrencesCreated,
  }) = _RecurrenceRuleImpl;

  factory RecurrenceRule.fromJson(Map<String, dynamic> jsonSerialization) {
    return RecurrenceRule(
      interval: _i2.RecurrenceInterval.fromJson(
        (jsonSerialization['interval'] as String),
      ),
      nextDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['nextDate'],
      ),
      endDate: jsonSerialization['endDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      maxOccurrences: jsonSerialization['maxOccurrences'] as int?,
      occurrencesCreated: jsonSerialization['occurrencesCreated'] as int?,
    );
  }

  _i2.RecurrenceInterval interval;

  DateTime nextDate;

  DateTime? endDate;

  int? maxOccurrences;

  int occurrencesCreated;

  /// Returns a shallow copy of this [RecurrenceRule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RecurrenceRule copyWith({
    _i2.RecurrenceInterval? interval,
    DateTime? nextDate,
    DateTime? endDate,
    int? maxOccurrences,
    int? occurrencesCreated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RecurrenceRule',
      'interval': interval.toJson(),
      'nextDate': nextDate.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      if (maxOccurrences != null) 'maxOccurrences': maxOccurrences,
      'occurrencesCreated': occurrencesCreated,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RecurrenceRule',
      'interval': interval.toJson(),
      'nextDate': nextDate.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      if (maxOccurrences != null) 'maxOccurrences': maxOccurrences,
      'occurrencesCreated': occurrencesCreated,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RecurrenceRuleImpl extends RecurrenceRule {
  _RecurrenceRuleImpl({
    required _i2.RecurrenceInterval interval,
    required DateTime nextDate,
    DateTime? endDate,
    int? maxOccurrences,
    int? occurrencesCreated,
  }) : super._(
         interval: interval,
         nextDate: nextDate,
         endDate: endDate,
         maxOccurrences: maxOccurrences,
         occurrencesCreated: occurrencesCreated,
       );

  /// Returns a shallow copy of this [RecurrenceRule]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RecurrenceRule copyWith({
    _i2.RecurrenceInterval? interval,
    DateTime? nextDate,
    Object? endDate = _Undefined,
    Object? maxOccurrences = _Undefined,
    int? occurrencesCreated,
  }) {
    return RecurrenceRule(
      interval: interval ?? this.interval,
      nextDate: nextDate ?? this.nextDate,
      endDate: endDate is DateTime? ? endDate : this.endDate,
      maxOccurrences: maxOccurrences is int?
          ? maxOccurrences
          : this.maxOccurrences,
      occurrencesCreated: occurrencesCreated ?? this.occurrencesCreated,
    );
  }
}
