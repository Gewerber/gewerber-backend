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
    final existing = await GuidanceTipOverride.db.findFirstRow(
      session,
      where: (t) => t.topic.equals(override.topic),
      transaction: transaction,
    );

    if (existing == null) {
      return GuidanceTipOverride.db.insertRow(session, override);
    }

    existing
      ..title = override.title
      ..body = override.body
      ..updatedAt = DateTime.now().toUtc();
    return GuidanceTipOverride.db.updateRow(session, existing);
  }
}
