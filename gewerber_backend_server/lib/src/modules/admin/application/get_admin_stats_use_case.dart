import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/admin_stats_gateway.dart';

@singleton
class GetAdminStatsUseCase {
  const GetAdminStatsUseCase(this._stats);

  final AdminStatsGateway _stats;

  Future<AdminStatsOverview> call(Session session) =>
      _stats.statsOverview(session);
}
