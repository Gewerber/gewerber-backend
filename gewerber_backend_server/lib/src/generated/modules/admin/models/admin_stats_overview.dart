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
import '../../../modules/admin/models/invoice_status_count.dart' as _i2;
import 'package:gewerber_backend_server/src/generated/protocol.dart' as _i3;

abstract class AdminStatsOverview
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AdminStatsOverview._({
    required this.usersTotal,
    required this.usersLast7Days,
    required this.usersLast30Days,
    required this.businessesTotal,
    required this.invoicesByStatus,
    required this.activeTimers,
  });

  factory AdminStatsOverview({
    required int usersTotal,
    required int usersLast7Days,
    required int usersLast30Days,
    required int businessesTotal,
    required List<_i2.InvoiceStatusCount> invoicesByStatus,
    required int activeTimers,
  }) = _AdminStatsOverviewImpl;

  factory AdminStatsOverview.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminStatsOverview(
      usersTotal: jsonSerialization['usersTotal'] as int,
      usersLast7Days: jsonSerialization['usersLast7Days'] as int,
      usersLast30Days: jsonSerialization['usersLast30Days'] as int,
      businessesTotal: jsonSerialization['businessesTotal'] as int,
      invoicesByStatus: _i3.Protocol()
          .deserialize<List<_i2.InvoiceStatusCount>>(
            jsonSerialization['invoicesByStatus'],
          ),
      activeTimers: jsonSerialization['activeTimers'] as int,
    );
  }

  int usersTotal;

  int usersLast7Days;

  int usersLast30Days;

  int businessesTotal;

  List<_i2.InvoiceStatusCount> invoicesByStatus;

  /// Time entries with a running (not yet stopped) timer across all tenants.
  int activeTimers;

  /// Returns a shallow copy of this [AdminStatsOverview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AdminStatsOverview copyWith({
    int? usersTotal,
    int? usersLast7Days,
    int? usersLast30Days,
    int? businessesTotal,
    List<_i2.InvoiceStatusCount>? invoicesByStatus,
    int? activeTimers,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminStatsOverview',
      'usersTotal': usersTotal,
      'usersLast7Days': usersLast7Days,
      'usersLast30Days': usersLast30Days,
      'businessesTotal': businessesTotal,
      'invoicesByStatus': invoicesByStatus.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'activeTimers': activeTimers,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminStatsOverview',
      'usersTotal': usersTotal,
      'usersLast7Days': usersLast7Days,
      'usersLast30Days': usersLast30Days,
      'businessesTotal': businessesTotal,
      'invoicesByStatus': invoicesByStatus.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'activeTimers': activeTimers,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AdminStatsOverviewImpl extends AdminStatsOverview {
  _AdminStatsOverviewImpl({
    required int usersTotal,
    required int usersLast7Days,
    required int usersLast30Days,
    required int businessesTotal,
    required List<_i2.InvoiceStatusCount> invoicesByStatus,
    required int activeTimers,
  }) : super._(
         usersTotal: usersTotal,
         usersLast7Days: usersLast7Days,
         usersLast30Days: usersLast30Days,
         businessesTotal: businessesTotal,
         invoicesByStatus: invoicesByStatus,
         activeTimers: activeTimers,
       );

  /// Returns a shallow copy of this [AdminStatsOverview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AdminStatsOverview copyWith({
    int? usersTotal,
    int? usersLast7Days,
    int? usersLast30Days,
    int? businessesTotal,
    List<_i2.InvoiceStatusCount>? invoicesByStatus,
    int? activeTimers,
  }) {
    return AdminStatsOverview(
      usersTotal: usersTotal ?? this.usersTotal,
      usersLast7Days: usersLast7Days ?? this.usersLast7Days,
      usersLast30Days: usersLast30Days ?? this.usersLast30Days,
      businessesTotal: businessesTotal ?? this.businessesTotal,
      invoicesByStatus:
          invoicesByStatus ??
          this.invoicesByStatus.map((e0) => e0.copyWith()).toList(),
      activeTimers: activeTimers ?? this.activeTimers,
    );
  }
}
