import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/session_auth.dart';
import '../../../generated/protocol.dart';
import '../domain/user_profile_gateway.dart';

@singleton
class UpdateUserProfileUseCase {
  UpdateUserProfileUseCase(this._profiles, this._audit);

  final UserProfileGateway _profiles;
  final AuditService _audit;

  Future<UserProfile> call(
    Session session,
    UpdateUserProfileRequest request,
  ) async {
    final userId = session.authUserId;
    if (userId == null) {
      throw ForbiddenException(message: 'Not authenticated.');
    }

    final existing = await _profiles.findByUserId(session, userId);
    final base = existing ?? UserProfile(userId: userId);

    final updated = base.copyWith(
      displayName: request.displayName?.trim(),
      locale: request.locale,
      timeZone: request.timeZone,
      themeMode: request.themeMode,
      updatedAt: DateTime.now().toUtc(),
    );
    final saved = existing == null
        ? await _profiles.create(session, updated)
        : await _profiles.update(session, updated);

    await _audit.log(
      session,
      action: 'user_profile.update',
      entityType: 'UserProfile',
      entityId: '${saved.id}',
    );
    return saved;
  }
}
