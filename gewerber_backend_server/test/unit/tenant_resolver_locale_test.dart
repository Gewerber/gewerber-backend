import 'package:gewerber_backend_server/src/core/i18n/locale_message_catalog.dart';
import 'package:gewerber_backend_server/src/core/tenant/tenant_resolver.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/business/data/serverpod_tenant_resolver.dart';
import 'package:gewerber_backend_server/src/modules/business/domain/business_gateway.dart';
import 'package:gewerber_backend_server/src/modules/business/domain/membership_gateway.dart';
import 'package:gewerber_backend_server/src/modules/user/domain/user_profile_gateway.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

/// Minimal fake: unimplemented [Session] members route through `noSuchMethod`.
///
/// Only [authenticated] is faked for real, because that is what the
/// `SessionAuth` extension reads to derive the authenticated user id.
class _FakeSession implements Session {
  _FakeSession(this.userId);

  final UuidValue? userId;

  @override
  AuthenticationInfo? get authenticated => userId == null
      ? null
      : AuthenticationInfo(userId!.uuid, {}, authId: 'test-auth');

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeMemberships implements MembershipGateway {
  _FakeMemberships(this._memberships);

  final List<Membership> _memberships;

  @override
  Future<List<Membership>> findByUser(
    Session session,
    UuidValue userId,
  ) async => _memberships;

  @override
  Future<Membership?> find(
    Session session, {
    required UuidValue userId,
    required int businessId,
  }) async => _memberships.where((m) => m.businessId == businessId).firstOrNull;

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeBusinesses implements BusinessGateway {
  _FakeBusinesses(this._byId);

  final Map<int, Business> _byId;

  @override
  Future<Business?> findById(Session session, int id) async => _byId[id];

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeProfiles implements UserProfileGateway {
  _FakeProfiles(this._profile);

  final UserProfile? _profile;

  @override
  Future<UserProfile?> findByUserId(
    Session session,
    UuidValue userId, {
    Transaction? transaction,
  }) async => _profile;

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

final _userId = UuidValue.fromString(
  'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d',
);

TenantResolver _resolver({
  List<Membership> memberships = const [],
  Map<int, Business> businesses = const {},
  UserProfile? profile,
}) => ServerpodTenantResolver(
  _FakeMemberships(memberships),
  _FakeBusinesses(businesses),
  _FakeProfiles(profile),
  const LocaleMessageCatalog(),
);

Membership _membership({int businessId = 7, MembershipRole? role}) =>
    Membership(
      id: 1,
      businessId: businessId,
      userId: _userId,
      role: role ?? MembershipRole.owner,
      createdAt: DateTime.utc(2026),
    );

UserProfile _profileWith(Locale locale) =>
    UserProfile(userId: _userId, locale: locale, createdAt: DateTime.utc(2026));

Business _businessWith(int id, Locale locale) => Business(
  id: id,
  name: 'Gewerbe',
  locale: locale,
  createdAt: DateTime.utc(2026),
);

void main() {
  group('locale resolution', () {
    test('prefers the user profile language', () async {
      final tenant = await _resolver(
        memberships: [_membership()],
        businesses: {7: _businessWith(7, Locale.de)},
        profile: _profileWith(Locale.en),
      ).resolve(_FakeSession(_userId));

      expect(tenant.locale, Locale.en);
    });

    test('falls back to the business language without a profile', () async {
      final tenant = await _resolver(
        memberships: [_membership()],
        businesses: {7: _businessWith(7, Locale.tr)},
      ).resolve(_FakeSession(_userId));

      expect(tenant.locale, Locale.tr);
    });

    test('falls back to de when neither is known', () async {
      final tenant = await _resolver(
        memberships: [_membership()],
      ).resolve(_FakeSession(_userId));

      expect(tenant.locale, Locale.de);
    });

    test('resolves for an explicit businessId', () async {
      final tenant = await _resolver(
        memberships: [_membership(businessId: 9)],
        businesses: {9: _businessWith(9, Locale.de)},
        profile: _profileWith(Locale.en),
      ).resolve(_FakeSession(_userId), businessId: 9);

      expect(tenant.businessId, 9);
      expect(tenant.locale, Locale.en);
    });
  });

  group('localized failures', () {
    test('an unauthenticated request gets the German message', () async {
      // No user means no language, so the fallback locale — and German is
      // strictly better than the English this returned before issue #57.
      await expectLater(
        () => _resolver().resolve(_FakeSession(null)),
        throwsA(
          isA<ForbiddenException>().having(
            (e) => e.message,
            'message',
            'Nicht angemeldet.',
          ),
        ),
      );
    });

    test('a non-member is told in their own language', () async {
      await expectLater(
        () => _resolver(
          profile: _profileWith(Locale.en),
        ).resolve(_FakeSession(_userId), businessId: 42),
        throwsA(
          isA<ForbiddenException>().having(
            (e) => e.message,
            'message',
            'Not a member of this business.',
          ),
        ),
      );
    });

    test('a non-admin gets a localized admin-permission error', () async {
      await expectLater(
        () => _resolver(
          memberships: [_membership(role: MembershipRole.member)],
          profile: _profileWith(Locale.en),
        ).requireAdmin(_FakeSession(_userId)),
        throwsA(
          isA<ForbiddenException>().having(
            (e) => e.message,
            'message',
            'Admin permissions required.',
          ),
        ),
      );
    });

    test('a user with no business still gets NotFound, unchanged', () async {
      // Deliberately left without a message: NotFoundException carries only
      // entityType/entityId, which the client renders. Adding a message would
      // mean changing the .spy.yaml and the wire format.
      await expectLater(
        () => _resolver().resolve(_FakeSession(_userId)),
        throwsA(
          isA<NotFoundException>().having(
            (e) => e.entityType,
            'entityType',
            'Business',
          ),
        ),
      );
    });
  });
}
