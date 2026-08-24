import 'package:serverpod/serverpod.dart';

import '../../../core/admin/admin_context.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/admin_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/read_admin_use_cases.dart';
import '../application/search_admin_users_use_case.dart';
import '../application/user_admin_use_cases.dart';

/// User directory reads and auth-level mutations (ban/unban/verify).
///
/// Reads are available to moderators; mutations require the `admin` role and
/// an explicit `confirm: true`.
class AdminUsersEndpoint extends AdminEndpoint {
  /// Keyset-paginated search over all users by email substring.
  Future<AdminUserSummaryPage> usersSearch(
    Session session, {
    String? query,
    int? limit,
    String? cursor,
  }) async {
    await requireAdmin(session, minRole: AdminRole.moderator);
    return getIt<SearchAdminUsersUseCase>().call(
      session,
      query: query,
      limit: limit,
      cursor: cursor,
    );
  }

  /// Full dossier of one user: profile, memberships with business names and
  /// auth status.
  Future<AdminUserDossier> usersGet(Session session, UuidValue userId) async {
    await requireAdmin(session, minRole: AdminRole.moderator);
    return getIt<GetUserDossierUseCase>().call(session, userId);
  }

  /// Blocks a user on the authentication level. `reason` is mandatory and
  /// stored in the audit trail; refresh tokens are invalidated immediately.
  /// No user data is deleted.
  Future<AdminUserDossier> usersBan(
    Session session, {
    required UuidValue userId,
    required String reason,
    required bool confirm,
  }) async {
    final actor = await requireAdmin(session, minRole: AdminRole.admin);
    return getIt<BanUserUseCase>().call(
      session,
      actor: actor,
      userId: userId,
      reason: reason,
      confirm: confirm,
    );
  }

  /// Lifts a ban. The user can sign in again; previously deleted refresh
  /// tokens are not restored.
  Future<AdminUserDossier> usersUnban(
    Session session, {
    required UuidValue userId,
    required bool confirm,
  }) async {
    final AdminContext actor = await requireAdmin(
      session,
      minRole: AdminRole.admin,
    );
    return getIt<UnbanUserUseCase>().call(
      session,
      actor: actor,
      userId: userId,
      confirm: confirm,
    );
  }

  /// Reports/confirms the email verification state of a user (idempotent:
  /// in the Serverpod email IdP an account only exists once its verification
  /// code was confirmed).
  Future<AdminAuthStatus> usersVerifyEmail(
    Session session, {
    required UuidValue userId,
    required bool confirm,
  }) async {
    final actor = await requireAdmin(session, minRole: AdminRole.admin);
    return getIt<VerifyUserEmailUseCase>().call(
      session,
      actor: actor,
      userId: userId,
      confirm: confirm,
    );
  }
}
