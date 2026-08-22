import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class UserGuidanceProgressGateway {
  Future<List<UserGuidanceProgress>> findByUser(
    Session session,
    UuidValue userId,
  );

  Future<UserGuidanceProgress?> find(
    Session session, {
    required UuidValue userId,
    required String itemKey,
  });

  Future<UserGuidanceProgress> upsert(
    Session session,
    UserGuidanceProgress progress,
  );
}
