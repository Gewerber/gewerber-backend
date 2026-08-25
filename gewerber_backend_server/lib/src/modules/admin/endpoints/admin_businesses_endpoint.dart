import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/admin_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/read_admin_use_cases.dart';
import '../application/set_membership_role_use_case.dart';

/// Cross-tenant business and membership administration. Reads are available
/// to moderators; role changes require the `admin` role.
class AdminBusinessesEndpoint extends AdminEndpoint {
  /// Keyset-paginated business search by name substring.
  Future<AdminBusinessPage> businessesSearch(
    Session session, {
    String? query,
    int? limit,
    String? cursor,
  }) async {
    await requireAdmin(session, minRole: AdminRole.moderator);
    return getIt<SearchAdminBusinessesUseCase>().call(
      session,
      query: query,
      limit: limit,
      cursor: cursor,
    );
  }

  /// One business with all of its memberships.
  Future<AdminBusinessDetail> businessesGet(
    Session session,
    int businessId,
  ) async {
    await requireAdmin(session, minRole: AdminRole.moderator);
    return getIt<GetAdminBusinessUseCase>().call(session, businessId);
  }

  /// Changes the tenant role of a membership. Refuses to demote the last
  /// owner of a business ([ConflictException]).
  Future<Membership> membershipsSetRole(
    Session session, {
    required int membershipId,
    required MembershipRole role,
    required bool confirm,
  }) async {
    final actor = await requireAdmin(session, minRole: AdminRole.admin);
    return getIt<SetMembershipRoleUseCase>().call(
      session,
      actor: actor,
      membershipId: membershipId,
      role: role,
      confirm: confirm,
    );
  }
}
