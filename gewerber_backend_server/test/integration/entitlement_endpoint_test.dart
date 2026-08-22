@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given EntitlementEndpoint', (sessionBuilder, endpoints) {
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

    test('when listing entitlements then all features are enabled', () async {
      final features = await endpoints.entitlement.list(
        authenticatedSession,
        businessId: businessId,
      );

      // The default OSS binding enables every feature.
      expect(features.toSet(), Feature.values.toSet());
      expect(features, contains(Feature.invoicing));
      expect(features, contains(Feature.time_tracking));
      expect(features, contains(Feature.accounting));
    });

    test('when listing entitlements then result is sorted', () async {
      final features = await endpoints.entitlement.list(
        authenticatedSession,
        businessId: businessId,
      );

      final names = features.map((f) => f.name).toList();
      expect(names, orderedEquals([...names]..sort()));
    });
  });
}
