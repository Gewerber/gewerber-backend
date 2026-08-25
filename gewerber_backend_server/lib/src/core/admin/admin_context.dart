/// Authorization context of a global administrator, resolved per request
/// from the `admin_user` allowlist.
library;

import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';

/// Role hierarchy: `moderator` is read-only, `admin` may also mutate.
extension AdminRoleHierarchy on AdminRole {
  /// Higher rank satisfies lower minimums; `admin` outranks `moderator`.
  int get rank => switch (this) {
    AdminRole.moderator => 1,
    AdminRole.admin => 2,
  };

  /// Whether this role is sufficient for a call requiring [minRole].
  bool satisfies(AdminRole minRole) => rank >= minRole.rank;
}

/// Immutable result of a successful `requireAdmin` check.
class AdminContext {
  const AdminContext({required this.userId, required this.role});

  /// `AuthUser.id` of the acting administrator.
  final UuidValue userId;

  /// The granted global role.
  final AdminRole role;
}
