@TestOn('vm')
@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/di/service_locator.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/user/domain/auth_identity_gateway.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as core;
import 'package:serverpod_auth_idp_server/providers/apple.dart'
    show AppleAccount;
import 'package:serverpod_auth_idp_server/providers/email.dart' as email_idp;
import 'package:serverpod_auth_idp_server/providers/facebook.dart'
    show FacebookAccount;
import 'package:serverpod_auth_idp_server/providers/google.dart'
    show GoogleAccount;
import 'package:serverpod_auth_idp_server/providers/microsoft.dart'
    show MicrosoftAccount;
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// `userProfile.me()` identity discovery:
/// - returns the caller's own memberships with business display names,
///   ordered by ascending `businessId`,
/// - exposes the global admin role resolved from the `admin_user` allowlist
///   (or `null` for plain users),
/// - works for users without any membership,
/// - exposes the provider-backed `primaryEmail` and the `connectedProviders`
///   of the auth user (see also `ServerpodAuthIdentityGateway`),
/// - rejects unauthenticated calls (`requireLogin`).
void main() {
  const plainUserId = 'c3d4e5f6-a7b8-4c9d-8e0f-1a2b3c4d5e6f';
  const adminId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const moderatorId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';
  const emailUserId = 'd4e5f6a7-b8c9-4d0e-9f1a-2b3c4d5e6f70';
  const googleUserId = 'e5f6a7b8-c9d0-4e1f-a2b3-c4d5e6f70819';
  const mixedUserId = 'f6a7b8c9-d0e1-4f2a-b3c4-d5e6f7081920';
  const facebookUserId = '07a8b9c0-d1e2-4a3b-b4d5-e6f708192a3b';
  const appleUserId = '1a2b3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c5d';

  setUpAll(() async {
    await configureDependencies();
  });

  /// Creates a business plus a single membership row for [userId] and
  /// returns the business id.
  Future<int> seedMembership(
    Session session,
    UuidValue userId,
    String businessName,
    MembershipRole role,
  ) async {
    final business = await Business.db.insertRow(
      session,
      Business(name: businessName),
    );
    await Membership.db.insertRow(
      session,
      Membership(userId: userId, businessId: business.id!, role: role),
    );
    return business.id!;
  }

  withServerpod('Given an authenticated user', (sessionBuilder, endpoints) {
    late Session rawSession;

    setUp(() async {
      rawSession = sessionBuilder.build();
    });

    test(
      'when a plain user has two memberships then both are returned with '
      'names and roles, ordered by ascending businessId, without a global role',
      () async {
        final session = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            plainUserId,
            {},
          ),
        );
        final userId = UuidValue.fromString(plainUserId);
        // Businesses are created first so ids ascend with insertion; the
        // membership rows are inserted in reverse id order to prove the
        // deterministic ordering of the response.
        final lowerBusiness = await Business.db.insertRow(
          rawSession,
          Business(name: 'Erstes Gewerbe'),
        );
        final higherBusiness = await Business.db.insertRow(
          rawSession,
          Business(name: 'Zweites Gewerbe'),
        );
        expect(higherBusiness.id!, greaterThan(lowerBusiness.id!));
        await Membership.db.insertRow(
          rawSession,
          Membership(
            userId: userId,
            businessId: higherBusiness.id!,
            role: MembershipRole.member,
          ),
        );
        await Membership.db.insertRow(
          rawSession,
          Membership(
            userId: userId,
            businessId: lowerBusiness.id!,
            role: MembershipRole.owner,
          ),
        );

        final identity = await endpoints.userProfile.me(session);

        expect(identity.userId, userId);
        // No `admin_user` row exists.
        expect(identity.globalRole, isNull);
        expect(
          identity.memberships.map((m) => m.businessId),
          [lowerBusiness.id!, higherBusiness.id!],
        );
        expect(identity.memberships[0].businessName, 'Erstes Gewerbe');
        expect(identity.memberships[0].role, MembershipRole.owner);
        expect(identity.memberships[1].businessName, 'Zweites Gewerbe');
        expect(identity.memberships[1].role, MembershipRole.member);
      },
    );

    test('when an admin_user row grants admin then me reports it', () async {
      final session = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(adminId, {}),
      );
      final userId = UuidValue.fromString(adminId);
      await AdminUser.db.insertRow(
        rawSession,
        AdminUser(userId: userId, role: AdminRole.admin),
      );
      final businessId = await seedMembership(
        rawSession,
        userId,
        'Admin Gewerbe',
        MembershipRole.owner,
      );

      final identity = await endpoints.userProfile.me(session);

      expect(identity.userId, userId);
      expect(identity.globalRole, AdminRole.admin);
      expect(identity.memberships.single.businessId, businessId);
      expect(identity.memberships.single.businessName, 'Admin Gewerbe');
      expect(identity.memberships.single.role, MembershipRole.owner);
    });

    test(
      'when an admin_user row grants moderator then me reports it',
      () async {
        final session = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            moderatorId,
            {},
          ),
        );
        await AdminUser.db.insertRow(
          rawSession,
          AdminUser(
            userId: UuidValue.fromString(moderatorId),
            role: AdminRole.moderator,
          ),
        );

        final identity = await endpoints.userProfile.me(session);

        expect(identity.userId, UuidValue.fromString(moderatorId));
        expect(identity.globalRole, AdminRole.moderator);
      },
    );

    test(
      'when the user has no memberships then an empty list is returned '
      'without error',
      () async {
        final session = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            plainUserId,
            {},
          ),
        );

        final identity = await endpoints.userProfile.me(session);

        expect(identity.userId, UuidValue.fromString(plainUserId));
        expect(identity.globalRole, isNull);
        expect(identity.memberships, isEmpty);
        // No provider row was seeded for this user.
        expect(identity.primaryEmail, isNull);
        expect(identity.connectedProviders, isEmpty);
      },
    );

    test(
      'when the user registered with an email account then me reports its '
      'address and no social provider',
      () async {
        final session = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            emailUserId,
            {},
          ),
        );
        final userId = UuidValue.fromString(emailUserId);
        await core.AuthUser.db.insertRow(
          rawSession,
          core.AuthUser(id: userId, scopeNames: {}),
        );
        await email_idp.EmailAccount.db.insertRow(
          rawSession,
          email_idp.EmailAccount(
            authUserId: userId,
            email: 'owner@example.com',
            passwordHash: '',
          ),
        );

        final identity = await endpoints.userProfile.me(session);

        expect(identity.primaryEmail, 'owner@example.com');
        // The email IdP is not a social provider.
        expect(identity.connectedProviders, isEmpty);
      },
    );

    test(
      'when the user only signed in with Google then me reports the Google '
      'address, the provider list and a verified email',
      () async {
        final session = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            googleUserId,
            {},
          ),
        );
        final userId = UuidValue.fromString(googleUserId);
        await core.AuthUser.db.insertRow(
          rawSession,
          core.AuthUser(id: userId, scopeNames: {}),
        );
        await GoogleAccount.db.insertRow(
          rawSession,
          GoogleAccount(
            authUserId: userId,
            email: 'owner@gmail.example',
            userIdentifier: 'google-sub-1',
          ),
        );

        final identity = await endpoints.userProfile.me(session);
        final authIdentity = await getIt<AuthIdentityGateway>().resolve(
          rawSession,
          userId,
        );

        expect(identity.primaryEmail, 'owner@gmail.example');
        expect(identity.connectedProviders, [AuthProvider.google]);
        expect(authIdentity.primaryEmail, 'owner@gmail.example');
        expect(authIdentity.emailVerified, isTrue);
        expect(authIdentity.providers, [AuthProvider.google]);
      },
    );

    test(
      'when two providers hold accounts then the address follows the '
      'precedence order while the provider list follows the enum order',
      () async {
        final session = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            mixedUserId,
            {},
          ),
        );
        final userId = UuidValue.fromString(mixedUserId);
        await core.AuthUser.db.insertRow(
          rawSession,
          core.AuthUser(id: userId, scopeNames: {}),
        );
        await FacebookAccount.db.insertRow(
          rawSession,
          FacebookAccount(
            authUserId: userId,
            userIdentifier: 'facebook-sub-1',
            email: 'owner@facebook.example',
          ),
        );
        await MicrosoftAccount.db.insertRow(
          rawSession,
          MicrosoftAccount(
            authUserId: userId,
            userIdentifier: 'microsoft-sub-1',
            // Lower precedence than Google/Apple, but higher than Facebook.
            email: 'owner@microsoft.example',
          ),
        );

        final identity = await endpoints.userProfile.me(session);
        final authIdentity = await getIt<AuthIdentityGateway>().resolve(
          rawSession,
          userId,
        );

        expect(identity.primaryEmail, 'owner@microsoft.example');
        // Enum declaration order: google, apple, facebook, microsoft.
        expect(identity.connectedProviders, [
          AuthProvider.facebook,
          AuthProvider.microsoft,
        ]);
        expect(authIdentity.emailVerified, isTrue);
      },
    );

    test(
      'when Facebook is the only provider then the reported address is not '
      'treated as verified',
      () async {
        final userId = UuidValue.fromString(facebookUserId);
        await core.AuthUser.db.insertRow(
          rawSession,
          core.AuthUser(id: userId, scopeNames: {}),
        );
        await FacebookAccount.db.insertRow(
          rawSession,
          FacebookAccount(
            authUserId: userId,
            userIdentifier: 'facebook-sub-2',
            email: 'owner@facebook.example',
          ),
        );

        final authIdentity = await getIt<AuthIdentityGateway>().resolve(
          rawSession,
          userId,
        );

        expect(authIdentity.primaryEmail, 'owner@facebook.example');
        expect(authIdentity.emailVerified, isFalse);
        expect(authIdentity.providers, [AuthProvider.facebook]);
      },
    );

    test(
      'when Apple marks the address as unverified then the address is used '
      'but reported as unverified',
      () async {
        final userId = UuidValue.fromString(appleUserId);
        await core.AuthUser.db.insertRow(
          rawSession,
          core.AuthUser(id: userId, scopeNames: {}),
        );
        await AppleAccount.db.insertRow(
          rawSession,
          AppleAccount(
            authUserId: userId,
            userIdentifier: 'apple-sub-1',
            refreshToken: 'refresh-token',
            refreshTokenRequestedWithBundleIdentifier: false,
            email: 'owner@apple.example',
            isEmailVerified: false,
          ),
        );

        final authIdentity = await getIt<AuthIdentityGateway>().resolve(
          rawSession,
          userId,
        );

        expect(authIdentity.primaryEmail, 'owner@apple.example');
        expect(authIdentity.emailVerified, isFalse);
        expect(authIdentity.providers, [AuthProvider.apple]);
      },
    );

    test(
      'when an unauthenticated session calls me then the call is rejected',
      () async {
        final unauthenticated = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.unauthenticated(),
        );
        await expectLater(
          () => endpoints.userProfile.me(unauthenticated),
          throwsA(isA<ServerpodUnauthenticatedException>()),
        );
      },
    );
  });
}
