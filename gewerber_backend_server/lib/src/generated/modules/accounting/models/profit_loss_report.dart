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
import '../../../modules/accounting/models/profit_loss_line.dart' as _iy1ovtjt;

abstract class ProfitLossReport
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ProfitLossReport._({
    required this.from,
    required this.to,
    required this.incomeCents,
    required this.expenseCents,
    required this.profitCents,
    required this.incomeLines,
    required this.expenseLines,
  });

  factory ProfitLossReport({
    required DateTime from,
    required DateTime to,
    required int incomeCents,
    required int expenseCents,
    required int profitCents,
    required List<_iy1ovtjt.ProfitLossLine> incomeLines,
    required List<_iy1ovtjt.ProfitLossLine> expenseLines,
  }) = _ProfitLossReportImpl;

  factory ProfitLossReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return ProfitLossReport(
      from: _is.DateTimeJsonExtension.fromJson(jsonSerialization['from']),
      to: _is.DateTimeJsonExtension.fromJson(jsonSerialization['to']),
      incomeCents: jsonSerialization['incomeCents'] as int,
      expenseCents: jsonSerialization['expenseCents'] as int,
      profitCents: jsonSerialization['profitCents'] as int,
      incomeLines: _itzp2rm6.Protocol()
          .deserialize<List<_iy1ovtjt.ProfitLossLine>>(
            jsonSerialization['incomeLines'],
          ),
      expenseLines: _itzp2rm6.Protocol()
          .deserialize<List<_iy1ovtjt.ProfitLossLine>>(
            jsonSerialization['expenseLines'],
          ),
    );
  }

  DateTime from;

  DateTime to;

  int incomeCents;

  int expenseCents;

  int profitCents;

  List<_iy1ovtjt.ProfitLossLine> incomeLines;

  List<_iy1ovtjt.ProfitLossLine> expenseLines;

  /// Returns a shallow copy of this [ProfitLossReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ProfitLossReport copyWith({
    DateTime? from,
    DateTime? to,
    int? incomeCents,
    int? expenseCents,
    int? profitCents,
    List<_iy1ovtjt.ProfitLossLine>? incomeLines,
    List<_iy1ovtjt.ProfitLossLine>? expenseLines,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ProfitLossReport',
      'from': from.toJson(),
      'to': to.toJson(),
      'incomeCents': incomeCents,
      'expenseCents': expenseCents,
      'profitCents': profitCents,
      'incomeLines': incomeLines.toJson(valueToJson: (v) => v.toJson()),
      'expenseLines': expenseLines.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ProfitLossReport',
      'from': from.toJson(),
      'to': to.toJson(),
      'incomeCents': incomeCents,
      'expenseCents': expenseCents,
      'profitCents': profitCents,
      'incomeLines': incomeLines.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'expenseLines': expenseLines.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ProfitLossReportImpl extends ProfitLossReport {
  _ProfitLossReportImpl({
    required DateTime from,
    required DateTime to,
    required int incomeCents,
    required int expenseCents,
    required int profitCents,
    required List<_iy1ovtjt.ProfitLossLine> incomeLines,
    required List<_iy1ovtjt.ProfitLossLine> expenseLines,
  }) : super._(
         from: from,
         to: to,
         incomeCents: incomeCents,
         expenseCents: expenseCents,
         profitCents: profitCents,
         incomeLines: incomeLines,
         expenseLines: expenseLines,
       );

  /// Returns a shallow copy of this [ProfitLossReport]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ProfitLossReport copyWith({
    DateTime? from,
    DateTime? to,
    int? incomeCents,
    int? expenseCents,
    int? profitCents,
    List<_iy1ovtjt.ProfitLossLine>? incomeLines,
    List<_iy1ovtjt.ProfitLossLine>? expenseLines,
  }) {
    return ProfitLossReport(
      from: from ?? this.from,
      to: to ?? this.to,
      incomeCents: incomeCents ?? this.incomeCents,
      expenseCents: expenseCents ?? this.expenseCents,
      profitCents: profitCents ?? this.profitCents,
      incomeLines:
          incomeLines ?? this.incomeLines.map((e0) => e0.copyWith()).toList(),
      expenseLines:
          expenseLines ?? this.expenseLines.map((e0) => e0.copyWith()).toList(),
    );
  }
}
