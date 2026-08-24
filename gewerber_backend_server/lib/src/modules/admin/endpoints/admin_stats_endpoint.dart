import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/admin_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/get_admin_stats_use_case.dart';

/// Platform-wide counters for the admin overview. Moderator and up.
class AdminStatsEndpoint extends AdminEndpoint {
  /// User, business, invoice-status and running-timer counts across all
  /// tenants.
  Future<AdminStatsOverview> statsOverview(Session session) async {
    await requireAdmin(session, minRole: AdminRole.moderator);
    return getIt<GetAdminStatsUseCase>().call(session);
  }
}
