import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/user_profile_gateway.dart';

@Singleton(as: UserProfileGateway)
class ServerpodUserProfileGateway implements UserProfileGateway {
  @override
  Future<UserProfile?> findByUserId(Session session, UuidValue userId) {
    return UserProfile.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
  }

  @override
  Future<UserProfile> create(
    Session session,
    UserProfile profile, {
    Transaction? transaction,
  }) {
    return UserProfile.db.insertRow(
      session,
      profile,
      transaction: transaction,
    );
  }

  @override
  Future<UserProfile> update(Session session, UserProfile profile) {
    return UserProfile.db.updateRow(session, profile);
  }
}
