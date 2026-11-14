import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as core;

import '../../../core/admin/admin_role_resolver.dart';
import '../../../generated/protocol.dart';
import '../../user/domain/auth_identity_gateway.dart';
import '../../user/domain/user_profile_gateway.dart';
import '../domain/admin_directory_gateway.dart';

/// Directory reads over the provider-agnostic identity rows, user profiles and
/// the admin allowlist.
///
/// A user may sign in through the email IdP or any social provider (and may
/// hold several account rows at once), so no single provider table is the
/// canonical directory. [AuthIdentityGateway.findEmails] unions all five and
/// this gateway merges its rows into one summary per auth user, attaching
/// profiles, roles and blocked flags per page in batched queries.
@Singleton(as: AdminDirectoryGateway)
class ServerpodAdminDirectoryGateway implements AdminDirectoryGateway {
  const ServerpodAdminDirectoryGateway(
    this._profiles,
    this._roleResolver,
    this._identities,
  );

  final UserProfileGateway _profiles;
  final AdminRoleResolver _roleResolver;
  final AuthIdentityGateway _identities;

  @override
  Future<List<AdminUserSummary>> searchUsers(
    Session session, {
    String? query,
    String? afterEmail,
    String? afterUserId,
    required int limit,
  }) async {
    // One extra identity row lets the caller detect a following page after
    // merging multiple providers into one entry per user.
    final identityRows = await _identities.findEmails(
      session,
      query: query,
      afterEmail: afterEmail,
      afterUserId: afterUserId,
      limit: limit + 1,
    );
    final users = _mergeIdentities(identityRows)
        .where((user) => _isAfterCursor(user, afterEmail, afterUserId))
        .take(limit)
        .toList();
    if (users.isEmpty) return const [];

    final userIds = users.map((u) => u.userId).toSet();
    final profiles = await UserProfile.db.find(
      session,
      where: (t) => t.userId.inSet(userIds),
    );
    final profileByUser = {for (final p in profiles) p.userId: p};
    final rolesByUser = await _rolesByUser(session, userIds);
    final authUsersById = await _authUsersById(session, userIds);

    return users.map((user) {
      final authUser = authUsersById[user.userId];
      final profile = profileByUser[user.userId];
      return AdminUserSummary(
        userId: user.userId,
        email: user.email,
        displayName: profile?.displayName,
        blocked: authUser?.blocked ?? false,
        emailConfirmed: user.emailVerified,
        globalRole: rolesByUser[user.userId],
        profileCreatedAt: profile?.createdAt,
        deletedAt: profile?.deletedAt,
        connectedProviders: user.sortedProviders,
      );
    }).toList();
  }

  @override
  Future<AdminUserDossier> getUserDossier(
    Session session,
    UuidValue userId,
  ) async {
    final core.AuthUserModel authUser;
    try {
      authUser = await core.AuthUsers().get(session, authUserId: userId);
    } on core.AuthUserNotFoundException {
      throw NotFoundException(entityType: 'AuthUser', entityId: '$userId');
    }

    final identity = await _identities.resolve(session, userId);
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
      email: identity.primaryEmail,
      authStatus: AdminAuthStatus(
        blocked: authUser.blocked,
        emailConfirmed: identity.emailVerified,
        email: identity.primaryEmail,
        authUserCreatedAt: authUser.createdAt,
        providers: identity.providers,
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

  /// Collapses the per-provider rows of one auth user into a single entry.
  ///
  /// The displayed address follows the same precedence as
  /// `AuthIdentityGateway.resolve` (email IdP, Google, Apple, Microsoft,
  /// Facebook); providers keep the enum declaration order.
  static List<_DirectoryEntry> _mergeIdentities(
    List<IdentityEmailRow> rows,
  ) {
    final entries = <UuidValue, _DirectoryEntry>{};
    for (final row in rows) {
      final entry = entries.putIfAbsent(
        row.authUserId,
        () => _DirectoryEntry(
          userId: row.authUserId,
          email: row.email,
          emailVerified: row.emailVerified,
          emailProvider: row.provider,
        ),
      );
      if (_providerRank(row.provider) < _providerRank(entry.emailProvider)) {
        entry
          ..email = row.email
          ..emailVerified = row.emailVerified
          ..emailProvider = row.provider;
      }
      if (row.provider != null) entry.providers.add(row.provider!);
    }

    return entries.values.toList()..sort((a, b) {
      final byEmail = a.email.toLowerCase().compareTo(b.email.toLowerCase());
      if (byEmail != 0) return byEmail;
      return a.userId.toString().compareTo(b.userId.toString());
    });
  }

  /// Applies the `(email, userId)` keyset boundary after merging.
  ///
  /// A cursor without `userId` is the legacy email-only cursor: every row at or
  /// below the last address is skipped, exactly like the old listing.
  static bool _isAfterCursor(
    _DirectoryEntry entry,
    String? afterEmail,
    String? afterUserId,
  ) {
    if (afterEmail == null) return true;
    final byEmail = entry.email.toLowerCase().compareTo(
      afterEmail.toLowerCase(),
    );
    if (byEmail != 0) return byEmail > 0;
    if (afterUserId == null) return false;
    return entry.userId.toString().compareTo(afterUserId) > 0;
  }

  /// Lower rank wins the displayed address. `null` is the email IdP.
  static int _providerRank(AuthProvider? provider) {
    return switch (provider) {
      null => 0,
      AuthProvider.google => 1,
      AuthProvider.apple => 2,
      AuthProvider.microsoft => 3,
      AuthProvider.facebook => 4,
    };
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

/// Mutable accumulator during [ServerpodAdminDirectoryGateway._mergeIdentities].
class _DirectoryEntry {
  _DirectoryEntry({
    required this.userId,
    required this.email,
    required this.emailVerified,
    required this.emailProvider,
  });

  final UuidValue userId;
  String email;
  bool emailVerified;
  AuthProvider? emailProvider;
  final Set<AuthProvider> providers = {};

  /// Enum declaration order (`google`, `apple`, `facebook`, `microsoft`).
  List<AuthProvider> get sortedProviders =>
      providers.toList()..sort((a, b) => a.index.compareTo(b.index));
}
