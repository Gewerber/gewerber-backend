import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class UserProfileGateway {
  Future<UserProfile?> findByUserId(Session session, UuidValue userId);

  Future<UserProfile> create(
    Session session,
    UserProfile profile, {
    Transaction? transaction,
  });

  Future<UserProfile> update(Session session, UserProfile profile);
}
