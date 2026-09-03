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

import 'package:serverpod/serverpod.dart' as _is;

abstract class MonthlyTrendPoint
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MonthlyTrendPoint._({
    required this.monthStart,
    required this.incomeCents,
    required this.expenseCents,
    required this.profitCents,
  });

  factory MonthlyTrendPoint({
    required DateTime monthStart,
    required int incomeCents,
    required int expenseCents,
    required int profitCents,
  }) = _MonthlyTrendPointImpl;

  factory MonthlyTrendPoint.fromJson(Map<String, dynamic> jsonSerialization) {
    return MonthlyTrendPoint(
      monthStart: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['monthStart'],
      ),
      incomeCents: jsonSerialization['incomeCents'] as int,
      expenseCents: jsonSerialization['expenseCents'] as int,
      profitCents: jsonSerialization['profitCents'] as int,
    );
  }

  DateTime monthStart;

  int incomeCents;

  int expenseCents;

  int profitCents;

  /// Returns a shallow copy of this [MonthlyTrendPoint]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MonthlyTrendPoint copyWith({
    DateTime? monthStart,
    int? incomeCents,
    int? expenseCents,
    int? profitCents,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MonthlyTrendPoint',
      'monthStart': monthStart.toJson(),
      'incomeCents': incomeCents,
      'expenseCents': expenseCents,
      'profitCents': profitCents,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MonthlyTrendPoint',
      'monthStart': monthStart.toJson(),
      'incomeCents': incomeCents,
      'expenseCents': expenseCents,
      'profitCents': profitCents,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _MonthlyTrendPointImpl extends MonthlyTrendPoint {
  _MonthlyTrendPointImpl({
    required DateTime monthStart,
    required int incomeCents,
    required int expenseCents,
    required int profitCents,
  }) : super._(
         monthStart: monthStart,
         incomeCents: incomeCents,
         expenseCents: expenseCents,
         profitCents: profitCents,
       );

  /// Returns a shallow copy of this [MonthlyTrendPoint]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MonthlyTrendPoint copyWith({
    DateTime? monthStart,
    int? incomeCents,
    int? expenseCents,
    int? profitCents,
  }) {
    return MonthlyTrendPoint(
      monthStart: monthStart ?? this.monthStart,
      incomeCents: incomeCents ?? this.incomeCents,
      expenseCents: expenseCents ?? this.expenseCents,
      profitCents: profitCents ?? this.profitCents,
    );
  }
}
