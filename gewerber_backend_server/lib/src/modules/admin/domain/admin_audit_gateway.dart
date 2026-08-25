import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

/// Filtered read access to the audit trail.
abstract interface class AdminAuditGateway {
  /// Newest-first audit entries, optionally filtered by acting user, action
  /// and lower time bound. [limit] is applied as-is (clamped by the caller).
  Future<List<AdminAuditEntry>> query(
    Session session, {
    UuidValue? actorUserId,
    String? action,
    DateTime? since,
    required int limit,
  });
}
