import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as core;
import 'package:serverpod_auth_idp_server/providers/email.dart' as idp;

import '../../../core/admin/admin_role_resolver.dart';
import '../../../generated/protocol.dart';
import '../../user/domain/user_profile_gateway.dart';
import '../domain/admin_directory_gateway.dart';

/// Directory reads over the email IdP accounts, user profiles and the admin
/// allowlist. Every real Gewerber user signs in via the email IdP, so
/// `EmailAccount` is the canonical directory table; profiles are attached
/// per page in a single batched query.
@Singleton(as: AdminDirectoryGateway)
class ServerpodAdminDirectoryGateway implements AdminDirectoryGateway {
  const ServerpodAdminDirectoryGateway(this._profiles, this._roleResolver);

  final UserProfileGateway _profiles;
  final AdminRoleResolver _roleResolver;

  @override
  Future<List<AdminUserSummary>> searchUsers(
    Session session, {
    String? query,
    String? afterEmail,
    required int limit,
  }) async {
    final normalized = query?.trim() ?? '';
    final accounts = await idp.EmailAccount.db.find(
      session,
      where: (t) {
        var expression = Constant.bool(true) as Expression;
        if (normalized.isNotEmpty) {
          expression &= t.email.ilike('%$normalized%');
        }
        if (afterEmail != null) {
          expression &= t.email > afterEmail;
        }
        return expression;
      },
      orderBy: (t) => t.email,
      limit: limit,
    );
    if (accounts.isEmpty) return const [];

    final userIds = accounts.map((a) => a.authUserId).toSet();
    final profiles = await UserProfile.db.find(
      session,
      where: (t) => t.userId.inSet(userIds),
    );
    final profileByUser = {for (final p in profiles) p.userId: p};
    final rolesByUser = await _rolesByUser(session, userIds);
    final authUsersById = await _authUsersById(session, userIds);

    return accounts.map((account) {
      final authUser = authUsersById[account.authUserId];
      final profile = profileByUser[account.authUserId];
      return AdminUserSummary(
        userId: account.authUserId,
        email: account.email,
        displayName: profile?.displayName,
        blocked: authUser?.blocked ?? false,
        emailConfirmed: true,
        globalRole: rolesByUser[account.authUserId],
        profileCreatedAt: profile?.createdAt,
        deletedAt: profile?.deletedAt,
      );
    }).toList();
  }

  @override
  Future<AdminUserDossier> getUserDossier(
    Session session,
    UuidValue userId,
  ) async {
    try {
      await core.AuthUsers().get(session, authUserId: userId);
    } on core.AuthUserNotFoundException {
      throw NotFoundException(entityType: 'AuthUser', entityId: '$userId');
    }

    final account = await idp.EmailAccount.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
    );
    final profile = await _profiles.findByUserId(session, userId);
    final memberships = await Membership.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );
    final businesses = memberships.isEmpty
        ? const <Business>[]
        : await Business.db.find(
            session,
            where: (t) =>
                t.id.inSet(memberships.map((m) => m.businessId).toSet()),
          );
    final businessNames = {for (final b in businesses) b.id!: b.name};

    final role = await _roleResolver.findByUser(session, userId);

    return AdminUserDossier(
      profile: profile,
      email: account?.email,
      authStatus: AdminAuthStatus(
        blocked: await _isBlocked(session, userId),
        emailConfirmed: account != null,
        email: account?.email,
        authUserCreatedAt: await _authUserCreatedAt(session, userId),
      ),
      memberships: memberships
          .map(
            (m) => AdminMembershipInfo(
              membership: m,
              businessName: businessNames[m.businessId] ?? '<deleted>',
            ),
          )
          .toList(),
      globalRole: role?.role,
    );
  }

  Future<bool> _isBlocked(Session session, UuidValue userId) async {
    final row = await core.AuthUser.db.findById(session, userId);
    return row?.blocked ?? false;
  }

  Future<DateTime?> _authUserCreatedAt(
    Session session,
    UuidValue userId,
  ) async {
    final row = await core.AuthUser.db.findById(session, userId);
    return row?.createdAt;
  }

  Future<Map<UuidValue, core.AuthUser>> _authUsersById(
    Session session,
    Set<UuidValue> userIds,
  ) async {
    final rows = await core.AuthUser.db.find(
      session,
      where: (t) => t.id.inSet(userIds),
    );
    return {for (final row in rows) row.id!: row};
  }

  Future<Map<UuidValue, AdminRole?>> _rolesByUser(
    Session session,
    Set<UuidValue> userIds,
  ) async {
    final rows = await AdminUser.db.find(
      session,
      where: (t) => t.userId.inSet(userIds),
    );
    return {for (final row in rows) row.userId: row.role};
  }
}
