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

abstract class CreateRecurringScheduleRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CreateRecurringScheduleRequest._({
    required this.invoiceId,
    required this.interval,
    this.nextRecurrenceDate,
    this.recurrenceEndDate,
    this.recurrenceMaxOccurrences,
  });

  factory CreateRecurringScheduleRequest({
    required int invoiceId,
    required _i2.RecurrenceInterval interval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
  }) = _CreateRecurringScheduleRequestImpl;

  factory CreateRecurringScheduleRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CreateRecurringScheduleRequest(
      invoiceId: jsonSerialization['invoiceId'] as int,
      interval: _i2.RecurrenceInterval.fromJson(
        (jsonSerialization['interval'] as String),
      ),
      nextRecurrenceDate: jsonSerialization['nextRecurrenceDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['nextRecurrenceDate'],
            ),
      recurrenceEndDate: jsonSerialization['recurrenceEndDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['recurrenceEndDate'],
            ),
      recurrenceMaxOccurrences:
          jsonSerialization['recurrenceMaxOccurrences'] as int?,
    );
  }

  int invoiceId;

  _i2.RecurrenceInterval interval;

  DateTime? nextRecurrenceDate;

  DateTime? recurrenceEndDate;

  int? recurrenceMaxOccurrences;

  /// Returns a shallow copy of this [CreateRecurringScheduleRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CreateRecurringScheduleRequest copyWith({
    int? invoiceId,
    _i2.RecurrenceInterval? interval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateRecurringScheduleRequest',
      'invoiceId': invoiceId,
      'interval': interval.toJson(),
      if (nextRecurrenceDate != null)
        'nextRecurrenceDate': nextRecurrenceDate?.toJson(),
      if (recurrenceEndDate != null)
        'recurrenceEndDate': recurrenceEndDate?.toJson(),
      if (recurrenceMaxOccurrences != null)
        'recurrenceMaxOccurrences': recurrenceMaxOccurrences,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreateRecurringScheduleRequest',
      'invoiceId': invoiceId,
      'interval': interval.toJson(),
      if (nextRecurrenceDate != null)
        'nextRecurrenceDate': nextRecurrenceDate?.toJson(),
      if (recurrenceEndDate != null)
        'recurrenceEndDate': recurrenceEndDate?.toJson(),
      if (recurrenceMaxOccurrences != null)
        'recurrenceMaxOccurrences': recurrenceMaxOccurrences,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateRecurringScheduleRequestImpl
    extends CreateRecurringScheduleRequest {
  _CreateRecurringScheduleRequestImpl({
    required int invoiceId,
    required _i2.RecurrenceInterval interval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
  }) : super._(
         invoiceId: invoiceId,
         interval: interval,
         nextRecurrenceDate: nextRecurrenceDate,
         recurrenceEndDate: recurrenceEndDate,
         recurrenceMaxOccurrences: recurrenceMaxOccurrences,
       );

  /// Returns a shallow copy of this [CreateRecurringScheduleRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CreateRecurringScheduleRequest copyWith({
    int? invoiceId,
    _i2.RecurrenceInterval? interval,
    Object? nextRecurrenceDate = _Undefined,
    Object? recurrenceEndDate = _Undefined,
    Object? recurrenceMaxOccurrences = _Undefined,
  }) {
    return CreateRecurringScheduleRequest(
      invoiceId: invoiceId ?? this.invoiceId,
      interval: interval ?? this.interval,
      nextRecurrenceDate: nextRecurrenceDate is DateTime?
          ? nextRecurrenceDate
          : this.nextRecurrenceDate,
      recurrenceEndDate: recurrenceEndDate is DateTime?
          ? recurrenceEndDate
          : this.recurrenceEndDate,
      recurrenceMaxOccurrences: recurrenceMaxOccurrences is int?
          ? recurrenceMaxOccurrences
          : this.recurrenceMaxOccurrences,
    );
  }
}
