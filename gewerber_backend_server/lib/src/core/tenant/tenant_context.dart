import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';

class TenantContext {
  const TenantContext({
    required this.userId,
    required this.businessId,
    required this.role,
  });

  final UuidValue userId;
  final int businessId;
  final MembershipRole role;

  bool get isAdmin =>
      role == MembershipRole.owner || role == MembershipRole.admin;
}
