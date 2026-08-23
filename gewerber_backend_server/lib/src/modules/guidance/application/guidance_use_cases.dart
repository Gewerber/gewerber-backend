import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/session_auth.dart';
import '../../../generated/protocol.dart';
import '../../user/domain/account_deletion.dart';
import '../../user/domain/user_profile_gateway.dart';
import '../domain/user_guidance_progress_gateway.dart';

/// Base logic shared by guidance mutations: resolves the authenticated user
/// and rejects soft-deleted accounts.
@singleton
class GuidanceSessionService {
  GuidanceSessionService(this._profiles);

  final UserProfileGateway _profiles;

  /// Resolves the authenticated user or throws [ForbiddenException].
  ///
  /// A soft-deleted account (GDPR Art. 17 tombstone on `UserProfile`) must not
  /// write guidance progress again — [UserGuidanceProgressGateway.upsert]
  /// would otherwise re-create personal rows for it.
  Future<UuidValue> requireUser(Session session) async {
    final userId = session.authUserId;
    if (userId == null) {
      throw ForbiddenException(message: 'Not authenticated.');
    }
    final profile = await _profiles.findByUserId(session, userId);
    if (profile != null && profile.deletedAt != null) {
      throwAccountDeleted(userId);
    }
    return userId;
  }
}

@singleton
class MarkGuidanceCompletedUseCase {
  MarkGuidanceCompletedUseCase(this._sessionService, this._progress);

  final GuidanceSessionService _sessionService;
  final UserGuidanceProgressGateway _progress;

  Future<UserGuidanceProgress> call(Session session, String itemKey) async {
    final userId = await _sessionService.requireUser(session);
    if (itemKey.trim().isEmpty) {
      throw ArgumentError.value(itemKey, 'itemKey', 'must not be empty');
    }
    final existing = await _progress.find(
      session,
      userId: userId,
      itemKey: itemKey,
    );
    return _progress.upsert(
      session,
      UserGuidanceProgress(
        id: existing?.id,
        userId: userId,
        itemKey: itemKey,
        completedAt: DateTime.now(),
        dismissedAt: existing?.dismissedAt,
      ),
    );
  }
}

@singleton
class DismissGuidanceTipUseCase {
  DismissGuidanceTipUseCase(this._sessionService, this._progress);

  final GuidanceSessionService _sessionService;
  final UserGuidanceProgressGateway _progress;

  Future<UserGuidanceProgress> call(Session session, String topic) async {
    final userId = await _sessionService.requireUser(session);
    final itemKey = 'tip:$topic';
    final existing = await _progress.find(
      session,
      userId: userId,
      itemKey: itemKey,
    );
    return _progress.upsert(
      session,
      UserGuidanceProgress(
        id: existing?.id,
        userId: userId,
        itemKey: itemKey,
        completedAt: existing?.completedAt,
        dismissedAt: DateTime.now(),
      ),
    );
  }
}
