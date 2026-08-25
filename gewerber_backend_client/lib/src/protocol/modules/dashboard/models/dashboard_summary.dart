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
import '../../../modules/dashboard/models/dashboard_kpis.dart' as _i2;
import '../../../modules/dashboard/models/monthly_trend_point.dart' as _i3;
import '../../../modules/invoicing/models/invoice.dart' as _i4;
import '../../../modules/accounting/models/accounting_transaction.dart' as _i5;
import '../../../modules/dashboard/models/recent_time_entry.dart' as _i6;
import '../../../modules/dashboard/models/receivables_summary.dart' as _i7;
import 'package:gewerber_backend_client/src/protocol/protocol.dart' as _i8;

abstract class DashboardSummary
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
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
    required _i2.DashboardKpis kpis,
    required List<_i3.MonthlyTrendPoint> monthlyTrend,
    required List<_i4.Invoice> recentInvoices,
    required List<_i5.AccountingTransaction> recentTransactions,
    required List<_i6.RecentTimeEntry> recentTimeEntries,
    required _i7.ReceivablesSummary receivables,
  }) = _DashboardSummaryImpl;

  factory DashboardSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardSummary(
      generatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['generatedAt'],
      ),
      asOf: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['asOf']),
      trendFrom: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['trendFrom'],
      ),
      trendTo: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['trendTo']),
      kpis: _i8.Protocol().deserialize<_i2.DashboardKpis>(
        jsonSerialization['kpis'],
      ),
      monthlyTrend: _i8.Protocol().deserialize<List<_i3.MonthlyTrendPoint>>(
        jsonSerialization['monthlyTrend'],
      ),
      recentInvoices: _i8.Protocol().deserialize<List<_i4.Invoice>>(
        jsonSerialization['recentInvoices'],
      ),
      recentTransactions: _i8.Protocol()
          .deserialize<List<_i5.AccountingTransaction>>(
            jsonSerialization['recentTransactions'],
          ),
      recentTimeEntries: _i8.Protocol().deserialize<List<_i6.RecentTimeEntry>>(
        jsonSerialization['recentTimeEntries'],
      ),
      receivables: _i8.Protocol().deserialize<_i7.ReceivablesSummary>(
        jsonSerialization['receivables'],
      ),
    );
  }

  DateTime generatedAt;

  DateTime asOf;

  DateTime trendFrom;

  DateTime trendTo;

  _i2.DashboardKpis kpis;

  List<_i3.MonthlyTrendPoint> monthlyTrend;

  List<_i4.Invoice> recentInvoices;

  List<_i5.AccountingTransaction> recentTransactions;

  List<_i6.RecentTimeEntry> recentTimeEntries;

  _i7.ReceivablesSummary receivables;

  /// Returns a shallow copy of this [DashboardSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DashboardSummary copyWith({
    DateTime? generatedAt,
    DateTime? asOf,
    DateTime? trendFrom,
    DateTime? trendTo,
    _i2.DashboardKpis? kpis,
    List<_i3.MonthlyTrendPoint>? monthlyTrend,
    List<_i4.Invoice>? recentInvoices,
    List<_i5.AccountingTransaction>? recentTransactions,
    List<_i6.RecentTimeEntry>? recentTimeEntries,
    _i7.ReceivablesSummary? receivables,
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
    return _i1.SerializationManager.encode(this);
  }
}

class _DashboardSummaryImpl extends DashboardSummary {
  _DashboardSummaryImpl({
    required DateTime generatedAt,
    required DateTime asOf,
    required DateTime trendFrom,
    required DateTime trendTo,
    required _i2.DashboardKpis kpis,
    required List<_i3.MonthlyTrendPoint> monthlyTrend,
    required List<_i4.Invoice> recentInvoices,
    required List<_i5.AccountingTransaction> recentTransactions,
    required List<_i6.RecentTimeEntry> recentTimeEntries,
    required _i7.ReceivablesSummary receivables,
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
  @_i1.useResult
  @override
  DashboardSummary copyWith({
    DateTime? generatedAt,
    DateTime? asOf,
    DateTime? trendFrom,
    DateTime? trendTo,
    _i2.DashboardKpis? kpis,
    List<_i3.MonthlyTrendPoint>? monthlyTrend,
    List<_i4.Invoice>? recentInvoices,
    List<_i5.AccountingTransaction>? recentTransactions,
    List<_i6.RecentTimeEntry>? recentTimeEntries,
    _i7.ReceivablesSummary? receivables,
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
