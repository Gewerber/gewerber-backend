import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

/// Aggregated platform counters for the admin overview.
abstract interface class AdminStatsGateway {
  Future<int> countAuthUsers(Session session, {DateTime? createdSince});

  Future<int> countBusinesses(Session session);

  Future<Map<InvoiceStatus, int>> countInvoicesByStatus(Session session);

  /// Time entries whose timer is still running (`stoppedAt` is null).
  Future<int> countActiveTimers(Session session);

  Future<AdminStatsOverview> statsOverview(Session session);
}
