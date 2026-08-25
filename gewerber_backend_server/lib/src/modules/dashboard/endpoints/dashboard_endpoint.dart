import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/business_scoped_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/get_dashboard_summary_use_case.dart';

class DashboardEndpoint extends BusinessScopedEndpoint {
  /// Aggregated dashboard summary of the tenant: current-month KPIs, monthly
  /// trend, recent activity feeds and open receivables. All list sizes are
  /// clamped server-side; [asOf] anchors every window (tests only).
  Future<DashboardSummary> getSummary(
    Session session, {
    int? trendMonths,
    int? recentLimit,
    int? overdueLimit,
    int? debtorLimit,
    DateTime? asOf,
    int? businessId,
  }) {
    return getIt<GetDashboardSummaryUseCase>().call(
      session,
      trendMonths: trendMonths,
      recentLimit: recentLimit,
      overdueLimit: overdueLimit,
      debtorLimit: debtorLimit,
      asOf: asOf,
      businessId: businessId,
    );
  }
}
