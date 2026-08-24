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
import '../../../modules/invoicing/models/recurrence_interval.dart' as _i2;

abstract class UpdateRecurringScheduleRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UpdateRecurringScheduleRequest._({
    required this.invoiceId,
    this.interval,
    this.nextRecurrenceDate,
    this.recurrenceEndDate,
    this.recurrenceMaxOccurrences,
    bool? clearRecurrenceEndDate,
    bool? clearMaxOccurrences,
  }) : clearRecurrenceEndDate = clearRecurrenceEndDate ?? false,
       clearMaxOccurrences = clearMaxOccurrences ?? false;

  factory UpdateRecurringScheduleRequest({
    required int invoiceId,
    _i2.RecurrenceInterval? interval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
    bool? clearRecurrenceEndDate,
    bool? clearMaxOccurrences,
  }) = _UpdateRecurringScheduleRequestImpl;

  factory UpdateRecurringScheduleRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UpdateRecurringScheduleRequest(
      invoiceId: jsonSerialization['invoiceId'] as int,
      interval: jsonSerialization['interval'] == null
          ? null
          : _i2.RecurrenceInterval.fromJson(
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
      clearRecurrenceEndDate:
          jsonSerialization['clearRecurrenceEndDate'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['clearRecurrenceEndDate'],
            ),
      clearMaxOccurrences: jsonSerialization['clearMaxOccurrences'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['clearMaxOccurrences'],
            ),
    );
  }

  int invoiceId;

  _i2.RecurrenceInterval? interval;

  DateTime? nextRecurrenceDate;

  DateTime? recurrenceEndDate;

  int? recurrenceMaxOccurrences;

  /// Clear flags: when true, the corresponding field is removed from the
  /// schedule regardless of the field's value above (`null` alone means
  /// "keep as is", so an explicit flag is needed to lift a limit).
  bool clearRecurrenceEndDate;

  bool clearMaxOccurrences;

  /// Returns a shallow copy of this [UpdateRecurringScheduleRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UpdateRecurringScheduleRequest copyWith({
    int? invoiceId,
    _i2.RecurrenceInterval? interval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
    bool? clearRecurrenceEndDate,
    bool? clearMaxOccurrences,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UpdateRecurringScheduleRequest',
      'invoiceId': invoiceId,
      if (interval != null) 'interval': interval?.toJson(),
      if (nextRecurrenceDate != null)
        'nextRecurrenceDate': nextRecurrenceDate?.toJson(),
      if (recurrenceEndDate != null)
        'recurrenceEndDate': recurrenceEndDate?.toJson(),
      if (recurrenceMaxOccurrences != null)
        'recurrenceMaxOccurrences': recurrenceMaxOccurrences,
      'clearRecurrenceEndDate': clearRecurrenceEndDate,
      'clearMaxOccurrences': clearMaxOccurrences,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UpdateRecurringScheduleRequest',
      'invoiceId': invoiceId,
      if (interval != null) 'interval': interval?.toJson(),
      if (nextRecurrenceDate != null)
        'nextRecurrenceDate': nextRecurrenceDate?.toJson(),
      if (recurrenceEndDate != null)
        'recurrenceEndDate': recurrenceEndDate?.toJson(),
      if (recurrenceMaxOccurrences != null)
        'recurrenceMaxOccurrences': recurrenceMaxOccurrences,
      'clearRecurrenceEndDate': clearRecurrenceEndDate,
      'clearMaxOccurrences': clearMaxOccurrences,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UpdateRecurringScheduleRequestImpl
    extends UpdateRecurringScheduleRequest {
  _UpdateRecurringScheduleRequestImpl({
    required int invoiceId,
    _i2.RecurrenceInterval? interval,
    DateTime? nextRecurrenceDate,
    DateTime? recurrenceEndDate,
    int? recurrenceMaxOccurrences,
    bool? clearRecurrenceEndDate,
    bool? clearMaxOccurrences,
  }) : super._(
         invoiceId: invoiceId,
         interval: interval,
         nextRecurrenceDate: nextRecurrenceDate,
         recurrenceEndDate: recurrenceEndDate,
         recurrenceMaxOccurrences: recurrenceMaxOccurrences,
         clearRecurrenceEndDate: clearRecurrenceEndDate,
         clearMaxOccurrences: clearMaxOccurrences,
       );

  /// Returns a shallow copy of this [UpdateRecurringScheduleRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UpdateRecurringScheduleRequest copyWith({
    int? invoiceId,
    Object? interval = _Undefined,
    Object? nextRecurrenceDate = _Undefined,
    Object? recurrenceEndDate = _Undefined,
    Object? recurrenceMaxOccurrences = _Undefined,
    bool? clearRecurrenceEndDate,
    bool? clearMaxOccurrences,
  }) {
    return UpdateRecurringScheduleRequest(
      invoiceId: invoiceId ?? this.invoiceId,
      interval: interval is _i2.RecurrenceInterval? ? interval : this.interval,
      nextRecurrenceDate: nextRecurrenceDate is DateTime?
          ? nextRecurrenceDate
          : this.nextRecurrenceDate,
      recurrenceEndDate: recurrenceEndDate is DateTime?
          ? recurrenceEndDate
          : this.recurrenceEndDate,
      recurrenceMaxOccurrences: recurrenceMaxOccurrences is int?
          ? recurrenceMaxOccurrences
          : this.recurrenceMaxOccurrences,
      clearRecurrenceEndDate:
          clearRecurrenceEndDate ?? this.clearRecurrenceEndDate,
      clearMaxOccurrences: clearMaxOccurrences ?? this.clearMaxOccurrences,
    );
  }
}
