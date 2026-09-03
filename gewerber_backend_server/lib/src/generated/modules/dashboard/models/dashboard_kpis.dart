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

abstract class DashboardKpis
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DashboardKpis._({
    required this.periodFrom,
    required this.periodTo,
    required this.incomeCents,
    required this.expenseCents,
    required this.profitCents,
    required this.totalMinutes,
    required this.billableMinutes,
    required this.roundedMinutes,
  });

  factory DashboardKpis({
    required DateTime periodFrom,
    required DateTime periodTo,
    required int incomeCents,
    required int expenseCents,
    required int profitCents,
    required int totalMinutes,
    required int billableMinutes,
    required int roundedMinutes,
  }) = _DashboardKpisImpl;

  factory DashboardKpis.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardKpis(
      periodFrom: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['periodFrom'],
      ),
      periodTo: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['periodTo'],
      ),
      incomeCents: jsonSerialization['incomeCents'] as int,
      expenseCents: jsonSerialization['expenseCents'] as int,
      profitCents: jsonSerialization['profitCents'] as int,
      totalMinutes: jsonSerialization['totalMinutes'] as int,
      billableMinutes: jsonSerialization['billableMinutes'] as int,
      roundedMinutes: jsonSerialization['roundedMinutes'] as int,
    );
  }

  DateTime periodFrom;

  DateTime periodTo;

  int incomeCents;

  int expenseCents;

  int profitCents;

  int totalMinutes;

  int billableMinutes;

  int roundedMinutes;

  /// Returns a shallow copy of this [DashboardKpis]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DashboardKpis copyWith({
    DateTime? periodFrom,
    DateTime? periodTo,
    int? incomeCents,
    int? expenseCents,
    int? profitCents,
    int? totalMinutes,
    int? billableMinutes,
    int? roundedMinutes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardKpis',
      'periodFrom': periodFrom.toJson(),
      'periodTo': periodTo.toJson(),
      'incomeCents': incomeCents,
      'expenseCents': expenseCents,
      'profitCents': profitCents,
      'totalMinutes': totalMinutes,
      'billableMinutes': billableMinutes,
      'roundedMinutes': roundedMinutes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DashboardKpis',
      'periodFrom': periodFrom.toJson(),
      'periodTo': periodTo.toJson(),
      'incomeCents': incomeCents,
      'expenseCents': expenseCents,
      'profitCents': profitCents,
      'totalMinutes': totalMinutes,
      'billableMinutes': billableMinutes,
      'roundedMinutes': roundedMinutes,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _DashboardKpisImpl extends DashboardKpis {
  _DashboardKpisImpl({
    required DateTime periodFrom,
    required DateTime periodTo,
    required int incomeCents,
    required int expenseCents,
    required int profitCents,
    required int totalMinutes,
    required int billableMinutes,
    required int roundedMinutes,
  }) : super._(
         periodFrom: periodFrom,
         periodTo: periodTo,
         incomeCents: incomeCents,
         expenseCents: expenseCents,
         profitCents: profitCents,
         totalMinutes: totalMinutes,
         billableMinutes: billableMinutes,
         roundedMinutes: roundedMinutes,
       );

  /// Returns a shallow copy of this [DashboardKpis]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DashboardKpis copyWith({
    DateTime? periodFrom,
    DateTime? periodTo,
    int? incomeCents,
    int? expenseCents,
    int? profitCents,
    int? totalMinutes,
    int? billableMinutes,
    int? roundedMinutes,
  }) {
    return DashboardKpis(
      periodFrom: periodFrom ?? this.periodFrom,
      periodTo: periodTo ?? this.periodTo,
      incomeCents: incomeCents ?? this.incomeCents,
      expenseCents: expenseCents ?? this.expenseCents,
      profitCents: profitCents ?? this.profitCents,
      totalMinutes: totalMinutes ?? this.totalMinutes,
      billableMinutes: billableMinutes ?? this.billableMinutes,
      roundedMinutes: roundedMinutes ?? this.roundedMinutes,
    );
  }
}
