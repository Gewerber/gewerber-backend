import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

/// The canonical signal that an account has been soft-deleted (GDPR Art. 17).
///
/// Thrown by every endpoint that detects a deleted account, so the client can
/// react uniformly: sign out and inform the user that the account is gone.
Never throwAccountDeleted(UuidValue userId) {
  throw NotFoundException(
    entityType: 'UserProfile',
    entityId: userId.uuid,
  );
}
