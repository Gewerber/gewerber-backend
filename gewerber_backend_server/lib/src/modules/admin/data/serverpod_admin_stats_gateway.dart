import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as core;

import '../../../generated/protocol.dart';
import '../domain/admin_stats_gateway.dart';

/// Counts over the whole platform. Invoice status counts are computed with
/// one indexed `COUNT` per status — the enum is closed, so the number of
/// queries is bounded and no raw SQL group-by is needed.
@Singleton(as: AdminStatsGateway)
class ServerpodAdminStatsGateway implements AdminStatsGateway {
  const ServerpodAdminStatsGateway();

  @override
  Future<int> countAuthUsers(Session session, {DateTime? createdSince}) {
    return core.AuthUser.db.count(
      session,
      where: (t) => createdSince == null
          ? Constant.bool(true) as Expression
          : t.createdAt >= createdSince,
    );
  }

  @override
  Future<int> countBusinesses(Session session) {
    return Business.db.count(session);
  }

  @override
  Future<Map<InvoiceStatus, int>> countInvoicesByStatus(Session session) async {
    final counts = <InvoiceStatus, int>{};
    for (final status in InvoiceStatus.values) {
      counts[status] = await Invoice.db.count(
        session,
        where: (t) => t.status.equals(status),
      );
    }
    return counts;
  }

  @override
  Future<int> countActiveTimers(Session session) {
    return TimeEntry.db.count(
      session,
      where: (t) => t.stoppedAt.equals(null),
    );
  }

  @override
  Future<AdminStatsOverview> statsOverview(Session session) async {
    final now = DateTime.now().toUtc();
    final usersTotal = await countAuthUsers(session);
    return AdminStatsOverview(
      usersTotal: usersTotal,
      usersLast7Days: await countAuthUsers(
        session,
        createdSince: now.subtract(const Duration(days: 7)),
      ),
      usersLast30Days: await countAuthUsers(
        session,
        createdSince: now.subtract(const Duration(days: 30)),
      ),
      businessesTotal: await countBusinesses(session),
      invoicesByStatus: (await countInvoicesByStatus(session)).entries
          .map((e) => InvoiceStatusCount(status: e.key, count: e.value))
          .toList(),
      activeTimers: await countActiveTimers(session),
    );
  }
}
