@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/di/service_locator.dart';
import 'package:gewerber_backend_server/src/core/entitlement/entitlement_guard.dart';
import 'package:gewerber_backend_server/src/core/entitlement/entitlement_provider.dart';
import 'package:gewerber_backend_server/src/core/endpoints/business_scoped_endpoint.dart';
import 'package:gewerber_backend_server/src/core/tenant/tenant_context.dart';
import 'package:gewerber_backend_server/src/core/tenant/tenant_resolver.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Entitlement provider fake that enables every feature except
/// [missingFeature].
class _MissingFeatureProvider implements EntitlementProvider {
  const _MissingFeatureProvider(this.missingFeature);

  final Feature missingFeature;

  @override
  Future<Set<Feature>> featuresFor(
    Session session,
    TenantContext tenant,
  ) async {
    return Feature.values.toSet()..remove(missingFeature);
  }
}

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given EntitlementGuard', (sessionBuilder, endpoints) {
    late TestSessionBuilder authenticatedSession;
    late int businessId;

    setUp(() async {
      authenticatedSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          testUserId,
          {},
        ),
      );
      final business = await endpoints.business.create(
        authenticatedSession,
        CreateBusinessRequest(name: 'Mein Gewerbe'),
      );
      businessId = business.id!;
    });

    test(
      'when feature is enabled then require passes without throwing',
      () async {
        getIt.pushNewScope();
        getIt.registerSingleton<EntitlementProvider>(
          const _MissingFeatureProvider(Feature.time_tracking),
        );
        try {
          final tenant = await getIt<TenantResolver>().resolve(
            authenticatedSession.build(),
            businessId: businessId,
          );

          await getIt<EntitlementGuard>().require(
            authenticatedSession.build(),
            tenant,
            Feature.invoicing,
          );
        } finally {
          await getIt.popScope();
        }
      },
    );

    test(
      'when feature is missing then require throws ForbiddenException '
      'naming the feature',
      () async {
        getIt.pushNewScope();
        getIt.registerSingleton<EntitlementProvider>(
          const _MissingFeatureProvider(Feature.time_tracking),
        );
        try {
          final tenant = await getIt<TenantResolver>().resolve(
            authenticatedSession.build(),
            businessId: businessId,
          );

          await expectLater(
            getIt<EntitlementGuard>().require(
              authenticatedSession.build(),
              tenant,
              Feature.time_tracking,
            ),
            throwsA(
              isA<ForbiddenException>().having(
                (e) => e.message,
                'message',
                'Feature not available: time_tracking',
              ),
            ),
          );
        } finally {
          await getIt.popScope();
        }
      },
    );

    test(
      'when a business endpoint is called then the requiredFeature '
      'choke point is a no-op and the endpoint works unchanged',
      () async {
        getIt.pushNewScope();
        getIt.registerSingleton<EntitlementProvider>(
          const _MissingFeatureProvider(Feature.time_tracking),
        );
        try {
          // requiredFeature is null on every OSS endpoint (including
          // BusinessEndpoint, which uses the base tenant() resolution
          // path), so the guard must not interfere.
          final mine = await endpoints.business.listMine(
            authenticatedSession,
          );
          expect(mine.map((b) => b.id), contains(businessId));

          final features = await endpoints.entitlement.list(
            authenticatedSession,
            businessId: businessId,
          );
          // time_tracking is disabled by the fake, the list endpoint
          // reports it faithfully — the guard is plumbing only.
          expect(features, isNot(contains(Feature.time_tracking)));
          expect(features, contains(Feature.invoicing));
        } finally {
          await getIt.popScope();
        }
      },
    );
  });

  withServerpod(
    'Given a BusinessScopedEndpoint subclass overriding requiredFeature',
    (sessionBuilder, endpoints) {
      late _GatedEndpoint gated;
      late TestSessionBuilder authenticatedSession;
      late Session session;
      late int businessId;

      setUp(() async {
        gated = _GatedEndpoint();
        authenticatedSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            testUserId,
            {},
          ),
        );
        session = authenticatedSession.build();
        // Each withServerpod group runs against its own database, so the
        // membership must exist here before the resolver can be driven.
        final business = await endpoints.business.create(
          authenticatedSession,
          CreateBusinessRequest(name: 'Gated Gewerbe'),
        );
        businessId = business.id!;
      });

      test(
        'when requiredFeature is set and missing then the resolve flow '
        'throws ForbiddenException',
        () async {
          getIt.pushNewScope();
          getIt.registerSingleton<EntitlementProvider>(
            const _MissingFeatureProvider(Feature.time_tracking),
          );
          try {
            // _GatedEndpoint overrides requiredFeature, so the base tenant()
            // resolution flow must enforce it before handing back a context.
            await expectLater(
              gated.tenant(session, businessId: businessId),
              throwsA(
                isA<ForbiddenException>().having(
                  (e) => e.message,
                  'message',
                  'Feature not available: time_tracking',
                ),
              ),
            );
          } finally {
            await getIt.popScope();
          }
        },
      );

      test(
        'when requiredFeature is enabled then the resolve flow returns '
        'the tenant context',
        () async {
          getIt.pushNewScope();
          getIt.registerSingleton<EntitlementProvider>(
            const _MissingFeatureProvider(Feature.time_tracking),
          );
          try {
            // _UngatedEndpoint keeps requiredFeature null (every OSS
            // endpoint does), so the same restrictive provider must not
            // interfere with tenant resolution.
            final tenant = await _UngatedEndpoint().tenant(
              session,
              businessId: businessId,
            );
            expect(tenant.businessId, businessId);
          } finally {
            await getIt.popScope();
          }
        },
      );
    },
  );
}

/// Test-only endpoint exposing the protected [BusinessScopedEndpoint.tenant]
/// resolution flow with a [BusinessScopedEndpoint.requiredFeature] override.
///
/// Never registered with Serverpod codegen or the endpoint registry — it
/// exists purely to drive the base-class choke point in tests.
class _GatedEndpoint extends BusinessScopedEndpoint {
  @override
  Feature? get requiredFeature => Feature.time_tracking;
}

/// Same as [_GatedEndpoint] but without the override (`requiredFeature`
/// stays `null`), mirroring every OSS endpoint.
class _UngatedEndpoint extends BusinessScopedEndpoint {}
