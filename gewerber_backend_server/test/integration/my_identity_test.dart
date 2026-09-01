@TestOn('vm')
@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// `userProfile.me()` identity discovery:
/// - returns the caller's own memberships with business display names,
///   ordered by ascending `businessId`,
/// - exposes the global admin role resolved from the `admin_user` allowlist
///   (or `null` for plain users),
/// - works for users without any membership,
/// - rejects unauthenticated calls (`requireLogin`).
void main() {
  const plainUserId = 'c3d4e5f6-a7b8-4c9d-8e0f-1a2b3c4d5e6f';
  const adminId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const moderatorId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

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
