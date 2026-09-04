@TestOn('vm')
@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/di/service_locator.dart';
import 'package:gewerber_backend_server/src/core/tenant/tenant_resolver.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Default-tenant resolution without an explicit `businessId`:
///
/// A user holding memberships in two businesses must deterministically be
/// resolved into the business whose membership has the earliest `createdAt`,
/// regardless of business ids or insertion order (see
/// `ServerpodTenantResolver.resolve` and
/// `ServerpodMembershipGateway.findByUser`).
void main() {
  const testUserId = 'd4e5f6a7-b8c9-4d0e-8f1a-2b3c4d5e6f7a';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod(
    'Given a user with memberships in two businesses',
    (sessionBuilder, endpoints) {
      late TestSessionBuilder authenticatedSession;
      late Session rawSession;
      late UuidValue userId;

      setUp(() async {
        authenticatedSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            testUserId,
            {},
          ),
        );
        rawSession = sessionBuilder.build();
        userId = UuidValue.fromString(testUserId);
      });

      /// Inserts a business plus a membership for the test user with an
      /// explicit [createdAt] and returns the business id.
      Future<int> seedBusiness(
        String name,
        DateTime createdAt,
      ) async {
        final business = await Business.db.insertRow(
          rawSession,
          Business(name: name),
        );
        await Membership.db.insertRow(
          rawSession,
          Membership(
            userId: userId,
            businessId: business.id!,
            role: MembershipRole.owner,
            createdAt: createdAt,
          ),
        );
        return business.id!;
      }

      test(
        'when resolving without businessId then the membership with the '
        'earliest createdAt wins',
        () async {
          // The business with the higher id (inserted last) owns the older
          // membership — a resolution by id or insertion order would fail.
          final newerBusinessId = await seedBusiness(
            'Neueres Gewerbe',
            DateTime.utc(2026, 1, 2),
          );
          final olderBusinessId = await seedBusiness(
            'Älteres Gewerbe',
            DateTime.utc(2026, 1, 1),
          );
          expect(olderBusinessId, greaterThan(newerBusinessId));

          final tenant = await getIt<TenantResolver>().resolve(
            authenticatedSession.build(),
          );

          expect(tenant.userId, userId);
          expect(tenant.businessId, olderBusinessId);
          expect(tenant.role, MembershipRole.owner);
        },
      );

      test(
        'when calling a business-scoped endpoint without businessId then the '
        'default business is the earliest membership',
        () async {
          final laterBusinessId = await seedBusiness(
            'Späteres Gewerbe',
            DateTime.utc(2026, 2, 2),
          );
          final earlierBusinessId = await seedBusiness(
            'Früheres Gewerbe',
            DateTime.utc(2026, 2, 1),
          );

          // List invoices without an explicit businessId: the use case must
          // resolve the tenant through the default (earliest) membership and
          // therefore never mix in invoices of the later business.
          final invoices = await endpoints.invoice.list(authenticatedSession);
          expect(invoices, isEmpty);

          final tenant = await getIt<TenantResolver>().resolve(
            authenticatedSession.build(),
          );
          expect(tenant.businessId, earlierBusinessId);
          expect(tenant.businessId, isNot(laterBusinessId));
        },
      );
    },
    rollbackDatabase: RollbackDatabase.afterEach,
  );
}
