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
import '../../../modules/accounting/models/accounting_transaction.dart'
    as _ildl58f5;
import '../../../modules/dashboard/models/dashboard_kpis.dart' as _i2lowue0;
import '../../../modules/dashboard/models/monthly_trend_point.dart'
    as _i1ylv7to;
import '../../../modules/dashboard/models/receivables_summary.dart'
    as _isdy6e37;
import '../../../modules/dashboard/models/recent_time_entry.dart' as _iflyllag;
import '../../../modules/invoicing/models/invoice.dart' as _i2lykh97;

abstract class DashboardSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  DashboardSummary._({
    required this.generatedAt,
    required this.asOf,
    required this.trendFrom,
    required this.trendTo,
    required this.kpis,
    required this.monthlyTrend,
    required this.recentInvoices,
    required this.recentTransactions,
    required this.recentTimeEntries,
    required this.receivables,
  });

  factory DashboardSummary({
    required DateTime generatedAt,
    required DateTime asOf,
    required DateTime trendFrom,
    required DateTime trendTo,
    required _i2lowue0.DashboardKpis kpis,
    required List<_i1ylv7to.MonthlyTrendPoint> monthlyTrend,
    required List<_i2lykh97.Invoice> recentInvoices,
    required List<_ildl58f5.AccountingTransaction> recentTransactions,
    required List<_iflyllag.RecentTimeEntry> recentTimeEntries,
    required _isdy6e37.ReceivablesSummary receivables,
  }) = _DashboardSummaryImpl;

  factory DashboardSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardSummary(
      generatedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
      asOf: _is.DateTimeJsonExtension.fromJson(jsonSerialization['asOf']),
      trendFrom: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['trendFrom'],
      ),
      trendTo: _is.DateTimeJsonExtension.fromJson(jsonSerialization['trendTo']),
      kpis: _itzp2rm6.Protocol().deserialize<_i2lowue0.DashboardKpis>(
        jsonSerialization['kpis'],
      ),
      monthlyTrend: _itzp2rm6.Protocol()
          .deserialize<List<_i1ylv7to.MonthlyTrendPoint>>(
            jsonSerialization['monthlyTrend'],
          ),
      recentInvoices: _itzp2rm6.Protocol().deserialize<List<_i2lykh97.Invoice>>(
        jsonSerialization['recentInvoices'],
      ),
      recentTransactions: _itzp2rm6.Protocol()
          .deserialize<List<_ildl58f5.AccountingTransaction>>(
            jsonSerialization['recentTransactions'],
          ),
      recentTimeEntries: _itzp2rm6.Protocol()
          .deserialize<List<_iflyllag.RecentTimeEntry>>(
            jsonSerialization['recentTimeEntries'],
          ),
      receivables: _itzp2rm6.Protocol()
          .deserialize<_isdy6e37.ReceivablesSummary>(
            jsonSerialization['receivables'],
          ),
    );
  }

  DateTime generatedAt;

  DateTime asOf;

  DateTime trendFrom;

  DateTime trendTo;

  _i2lowue0.DashboardKpis kpis;

  List<_i1ylv7to.MonthlyTrendPoint> monthlyTrend;

  List<_i2lykh97.Invoice> recentInvoices;

  List<_ildl58f5.AccountingTransaction> recentTransactions;

  List<_iflyllag.RecentTimeEntry> recentTimeEntries;

  _isdy6e37.ReceivablesSummary receivables;

  /// Returns a shallow copy of this [DashboardSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DashboardSummary copyWith({
    DateTime? generatedAt,
    DateTime? asOf,
    DateTime? trendFrom,
    DateTime? trendTo,
    _i2lowue0.DashboardKpis? kpis,
    List<_i1ylv7to.MonthlyTrendPoint>? monthlyTrend,
    List<_i2lykh97.Invoice>? recentInvoices,
    List<_ildl58f5.AccountingTransaction>? recentTransactions,
    List<_iflyllag.RecentTimeEntry>? recentTimeEntries,
    _isdy6e37.ReceivablesSummary? receivables,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DashboardSummary',
      'generatedAt': generatedAt.toJson(),
      'asOf': asOf.toJson(),
      'trendFrom': trendFrom.toJson(),
      'trendTo': trendTo.toJson(),
      'kpis': kpis.toJson(),
      'monthlyTrend': monthlyTrend.toJson(valueToJson: (v) => v.toJson()),
      'recentInvoices': recentInvoices.toJson(valueToJson: (v) => v.toJson()),
      'recentTransactions': recentTransactions.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'recentTimeEntries': recentTimeEntries.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'receivables': receivables.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DashboardSummary',
      'generatedAt': generatedAt.toJson(),
      'asOf': asOf.toJson(),
      'trendFrom': trendFrom.toJson(),
      'trendTo': trendTo.toJson(),
      'kpis': kpis.toJsonForProtocol(),
      'monthlyTrend': monthlyTrend.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'recentInvoices': recentInvoices.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'recentTransactions': recentTransactions.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'recentTimeEntries': recentTimeEntries.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'receivables': receivables.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _DashboardSummaryImpl extends DashboardSummary {
  _DashboardSummaryImpl({
    required DateTime generatedAt,
    required DateTime asOf,
    required DateTime trendFrom,
    required DateTime trendTo,
    required _i2lowue0.DashboardKpis kpis,
    required List<_i1ylv7to.MonthlyTrendPoint> monthlyTrend,
    required List<_i2lykh97.Invoice> recentInvoices,
    required List<_ildl58f5.AccountingTransaction> recentTransactions,
    required List<_iflyllag.RecentTimeEntry> recentTimeEntries,
    required _isdy6e37.ReceivablesSummary receivables,
  }) : super._(
         generatedAt: generatedAt,
         asOf: asOf,
         trendFrom: trendFrom,
         trendTo: trendTo,
         kpis: kpis,
         monthlyTrend: monthlyTrend,
         recentInvoices: recentInvoices,
         recentTransactions: recentTransactions,
         recentTimeEntries: recentTimeEntries,
         receivables: receivables,
       );

  /// Returns a shallow copy of this [DashboardSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DashboardSummary copyWith({
    DateTime? generatedAt,
    DateTime? asOf,
    DateTime? trendFrom,
    DateTime? trendTo,
    _i2lowue0.DashboardKpis? kpis,
    List<_i1ylv7to.MonthlyTrendPoint>? monthlyTrend,
    List<_i2lykh97.Invoice>? recentInvoices,
    List<_ildl58f5.AccountingTransaction>? recentTransactions,
    List<_iflyllag.RecentTimeEntry>? recentTimeEntries,
    _isdy6e37.ReceivablesSummary? receivables,
  }) {
    return DashboardSummary(
      generatedAt: generatedAt ?? this.generatedAt,
      asOf: asOf ?? this.asOf,
      trendFrom: trendFrom ?? this.trendFrom,
      trendTo: trendTo ?? this.trendTo,
      kpis: kpis ?? this.kpis.copyWith(),
      monthlyTrend:
          monthlyTrend ?? this.monthlyTrend.map((e0) => e0.copyWith()).toList(),
      recentInvoices:
          recentInvoices ??
          this.recentInvoices.map((e0) => e0.copyWith()).toList(),
      recentTransactions:
          recentTransactions ??
          this.recentTransactions.map((e0) => e0.copyWith()).toList(),
      recentTimeEntries:
          recentTimeEntries ??
          this.recentTimeEntries.map((e0) => e0.copyWith()).toList(),
      receivables: receivables ?? this.receivables.copyWith(),
    );
  }
}
