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

abstract class Reminder
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  Reminder._({
    this.id,
    required this.invoiceId,
    required this.level,
    DateTime? sentAt,
  }) : sentAt = sentAt ?? DateTime.now();

  factory Reminder({
    int? id,
    required int invoiceId,
    required int level,
    DateTime? sentAt,
  }) = _ReminderImpl;

  factory Reminder.fromJson(Map<String, dynamic> jsonSerialization) {
    return Reminder(
      id: jsonSerialization['id'] as int?,
      invoiceId: jsonSerialization['invoiceId'] as int,
      level: jsonSerialization['level'] as int,
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int invoiceId;

  int level;

  DateTime sentAt;

  /// Returns a shallow copy of this [Reminder]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Reminder copyWith({
    int? id,
    int? invoiceId,
    int? level,
    DateTime? sentAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Reminder',
      if (id != null) 'id': id,
      'invoiceId': invoiceId,
      'level': level,
      'sentAt': sentAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Reminder',
      if (id != null) 'id': id,
      'invoiceId': invoiceId,
      'level': level,
      'sentAt': sentAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReminderImpl extends Reminder {
  _ReminderImpl({
    int? id,
    required int invoiceId,
    required int level,
    DateTime? sentAt,
  }) : super._(
         id: id,
         invoiceId: invoiceId,
         level: level,
         sentAt: sentAt,
       );

  /// Returns a shallow copy of this [Reminder]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Reminder copyWith({
    Object? id = _Undefined,
    int? invoiceId,
    int? level,
    DateTime? sentAt,
  }) {
    return Reminder(
      id: id is int? ? id : this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      level: level ?? this.level,
      sentAt: sentAt ?? this.sentAt,
    );
  }
}
