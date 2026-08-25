import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

/// Cross-tenant read access to businesses and memberships.
abstract interface class AdminBusinessGateway {
  /// Keyset-paginated business search ordered by id; [query] matches
  /// case-insensitively against the business name.
  Future<List<Business>> searchBusinesses(
    Session session, {
    String? query,
    int? afterId,
    required int limit,
  });

  /// One business with all its memberships (business name included per row).
  Future<AdminBusinessDetail> getBusiness(Session session, int businessId);

  /// Changes a membership's role after validating that a business always
  /// keeps at least one owner. Concurrent role changes on the same business
  /// are serialized via a row lock on the parent business.
  ///
  /// Runs inside [transaction] when given (so the caller can audit in the
  /// same transaction); otherwise opens its own.
  Future<Membership> setMembershipRole(
    Session session,
    int membershipId,
    MembershipRole role, {
    Transaction? transaction,
  });
}
