import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

/// Storage for admin-managed overrides of curated guidance tips.
abstract interface class GuidanceTipOverrideGateway {
  /// All overrides, ordered by topic.
  Future<List<GuidanceTipOverride>> listAll(Session session);

  /// Inserts or updates an override by its unique [GuidanceTipOverride.topic].
  Future<GuidanceTipOverride> upsert(
    Session session,
    GuidanceTipOverride override, {
    Transaction? transaction,
  });
}
