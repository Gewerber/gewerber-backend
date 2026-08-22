import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/user_guidance_progress_gateway.dart';

@Singleton(as: UserGuidanceProgressGateway)
class ServerpodUserGuidanceProgressGateway
    implements UserGuidanceProgressGateway {
  @override
  Future<List<UserGuidanceProgress>> findByUser(
    Session session,
    UuidValue userId,
  ) {
    return UserGuidanceProgress.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.itemKey,
    );
  }

  @override
  Future<UserGuidanceProgress?> find(
    Session session, {
    required UuidValue userId,
    required String itemKey,
  }) async {
    final rows = await UserGuidanceProgress.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.itemKey.equals(itemKey),
      limit: 1,
    );
    return rows.firstOrNull;
  }

  @override
  Future<UserGuidanceProgress> upsert(
    Session session,
    UserGuidanceProgress progress,
  ) async {
    final existing = await find(
      session,
      userId: progress.userId,
      itemKey: progress.itemKey,
    );
    if (existing == null) {
      return UserGuidanceProgress.db.insertRow(session, progress);
    }
    return UserGuidanceProgress.db.updateRow(
      session,
      existing.copyWith(
        completedAt: progress.completedAt,
        dismissedAt: progress.dismissedAt,
        updatedAt: DateTime.now(),
      ),
    );
  }
}
