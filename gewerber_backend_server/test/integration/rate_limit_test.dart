@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/rate_limit/api_rate_limiter.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const otherUserId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given API rate limiting', (sessionBuilder, endpoints) {
    late TestSessionBuilder authenticatedSession;
    late TestSessionBuilder otherSession;
    late int businessId;
    late int otherBusinessId;

    Future<int> createBusiness(TestSessionBuilder session) async {
      final business = await endpoints.business.create(
        session,
        CreateBusinessRequest(
          name: 'Mein Gewerbe',
          vatId: 'DE123456789',
          address: Address(
            street: 'Musterstr. 1',
            zip: '10115',
            city: 'Berlin',
            country: Country.deu,
          ),
        ),
      );
      return business.id!;
    }

    setUp(() async {
      authenticatedSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          testUserId,
          {},
        ),
      );
      otherSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          otherUserId,
          {},
        ),
      );
      businessId = await createBusiness(authenticatedSession);
      otherBusinessId = await createBusiness(otherSession);
    });

    test('when exceeding the export budget then RateLimitException', () async {
      final budget = RateLimitedOperation.invoiceExport.maxAttempts;
      for (var i = 0; i < budget; i++) {
        await endpoints.invoice.exportJson(
          authenticatedSession,
          businessId: businessId,
        );
      }

      await expectLater(
        endpoints.invoice.exportJson(
          authenticatedSession,
          businessId: businessId,
        ),
        throwsA(isA<RateLimitException>()),
      );
    });

    test(
      'when one user is throttled then another user is unaffected',
      () async {
        final budget = RateLimitedOperation.invoiceExport.maxAttempts;
        for (var i = 0; i < budget; i++) {
          await endpoints.invoice.exportJson(
            authenticatedSession,
            businessId: businessId,
          );
        }
        await expectLater(
          endpoints.invoice.exportJson(
            authenticatedSession,
            businessId: businessId,
          ),
          throwsA(isA<RateLimitException>()),
        );

        await endpoints.invoice.exportJson(
          otherSession,
          businessId: otherBusinessId,
        );
      },
    );
  });
}
