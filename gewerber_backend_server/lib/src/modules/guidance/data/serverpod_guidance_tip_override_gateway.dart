import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/guidance_tip_override_gateway.dart';

@Singleton(as: GuidanceTipOverrideGateway)
class ServerpodGuidanceTipOverrideGateway
    implements GuidanceTipOverrideGateway {
  const ServerpodGuidanceTipOverrideGateway();

  @override
  Future<List<GuidanceTipOverride>> listAll(Session session) {
    return GuidanceTipOverride.db.find(
      session,
      orderBy: (t) => t.topic,
    );
  }

  @override
  Future<GuidanceTipOverride> upsert(
    Session session,
    GuidanceTipOverride override, {
    Transaction? transaction,
  }) async {
    // Atomic ON CONFLICT upsert: no check-then-insert race between two
    // admins editing the same topic.
    final row = await GuidanceTipOverride.db.upsertRow(
      session,
      override..updatedAt = DateTime.now().toUtc(),
      conflictColumns: (t) => [t.topic],
      transaction: transaction,
    );
    // Without `updateWhere` the conflicting row is always affected.
    return row!;
  }
}
