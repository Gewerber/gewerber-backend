import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/session_auth.dart';
import '../../../generated/protocol.dart';
import '../domain/account_deletion.dart';
import '../domain/user_profile_gateway.dart';

@singleton
class GetMyProfileUseCase {
  GetMyProfileUseCase(this._profiles);

  final UserProfileGateway _profiles;

  Future<UserProfile> call(Session session) async {
    final userId = session.authUserId;
    if (userId == null) {
      throw ForbiddenException(message: 'Not authenticated.');
    }
    final existing = await _profiles.findByUserId(session, userId);
    if (existing != null) {
      if (existing.deletedAt != null) {
        throwAccountDeleted(userId);
      }
      return existing;
    }
    try {
      return await _profiles.create(session, UserProfile(userId: userId));
    } on DatabaseQueryException catch (e) {
      // 23505 = unique_violation: a concurrent request created the row.
      if (e.code != '23505') rethrow;
      final created = await _profiles.findByUserId(session, userId);
      if (created == null) rethrow;
      return created;
    }
  }
}
