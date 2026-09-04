@TestOn('vm')
@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Dedicated integration tests for the `businessSettings` endpoint.
///
/// Pinned behavior (from the use cases, not assumed):
/// - `get` resolves the tenant via `TenantResolver.resolve` (read access for
///   every member, settings row is created with defaults when missing),
/// - `update` resolves via `TenantResolver.requireAdmin` (owner/admin only),
/// - validation lives in `UpdateBusinessSettingsUseCase._validate`:
///   `paymentTermsDays >= 0`, `1 <= invoiceNumberMinDigits <= 10`,
///   `roundingGranularityMinutes >= 1`.
void main() {
  const ownerId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const memberId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';
  const outsiderId = 'c3d4e5f6-a7b8-4c9d-8e0f-1a2b3c4d5e6f';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given BusinessSettingsEndpoint', (sessionBuilder, endpoints) {
    late TestSessionBuilder ownerSession;
    late TestSessionBuilder memberSession;
    late TestSessionBuilder outsiderSession;
    late Session rawSession;

    setUp(() async {
      ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(ownerId, {}),
      );
      memberSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(memberId, {}),
      );
      outsiderSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          outsiderId,
          {},
        ),
      );
      rawSession = sessionBuilder.build();
    });

    /// Creates a business through the endpoint (owner membership is created
    /// for the caller) and returns its id.
    Future<int> createBusiness(TestSessionBuilder session, String name) async {
      final business = await endpoints.business.create(
        session,
        CreateBusinessRequest(name: name),
      );
      return business.id!;
    }

    UpdateBusinessSettingsRequest updateRequestFor(
      int businessId, {
      int paymentTermsDays = 30,
      String? invoiceNumberPrefix = 'RE',
      bool invoiceNumberIncludeYear = false,
      int invoiceNumberMinDigits = 6,
      RoundingMode roundingMode = RoundingMode.up,
      int roundingGranularityMinutes = 15,
    }) {
      return UpdateBusinessSettingsRequest(
        businessId: businessId,
        paymentTermsDays: paymentTermsDays,
        invoiceNumberPrefix: invoiceNumberPrefix,
        invoiceNumberIncludeYear: invoiceNumberIncludeYear,
        invoiceNumberMinDigits: invoiceNumberMinDigits,
        roundingMode: roundingMode,
        roundingGranularityMinutes: roundingGranularityMinutes,
      );
    }

    group('happy path', () {
      test(
        'when getting settings of a fresh business then defaults are returned',
        () async {
          final businessId = await createBusiness(ownerSession, 'Frisches');

          final settings = await endpoints.businessSettings.get(
            ownerSession,
            businessId: businessId,
          );

          expect(settings.id, isNotNull);
          expect(settings.businessId, businessId);
          expect(settings.paymentTermsDays, 14);
          expect(settings.invoiceNumberPrefix, isNull);
          expect(settings.invoiceNumberIncludeYear, true);
          expect(settings.invoiceNumberMinDigits, 4);
          expect(settings.roundingMode, RoundingMode.none);
          expect(settings.roundingGranularityMinutes, 1);
        },
      );

      test(
        'when updating then new values are returned and persisted',
        () async {
          final businessId = await createBusiness(ownerSession, 'Aenderung');

          final updated = await endpoints.businessSettings.update(
            ownerSession,
            updateRequestFor(businessId),
          );

          expect(updated.businessId, businessId);
          expect(updated.paymentTermsDays, 30);
          expect(updated.invoiceNumberPrefix, 'RE');
          expect(updated.invoiceNumberIncludeYear, false);
          expect(updated.invoiceNumberMinDigits, 6);
          expect(updated.roundingMode, RoundingMode.up);
          expect(updated.roundingGranularityMinutes, 15);

          final fetched = await endpoints.businessSettings.get(
            ownerSession,
            businessId: businessId,
          );
          expect(fetched.paymentTermsDays, 30);
          expect(fetched.invoiceNumberPrefix, 'RE');
          expect(fetched.invoiceNumberIncludeYear, false);
          expect(fetched.invoiceNumberMinDigits, 6);
          expect(fetched.roundingMode, RoundingMode.up);
          expect(fetched.roundingGranularityMinutes, 15);
        },
      );

      test(
        'when updating with boundary values then they are accepted',
        () async {
          final businessId = await createBusiness(ownerSession, 'Grenzen');

          final lowerBound = await endpoints.businessSettings.update(
            ownerSession,
            updateRequestFor(
              businessId,
              paymentTermsDays: 0,
              invoiceNumberMinDigits: 1,
              roundingGranularityMinutes: 1,
            ),
          );
          expect(lowerBound.paymentTermsDays, 0);
          expect(lowerBound.invoiceNumberMinDigits, 1);
          expect(lowerBound.roundingGranularityMinutes, 1);

          final upperBound = await endpoints.businessSettings.update(
            ownerSession,
            updateRequestFor(businessId, invoiceNumberMinDigits: 10),
          );
          expect(upperBound.invoiceNumberMinDigits, 10);
        },
      );
    });

    group('validation', () {
      test(
        'when paymentTermsDays is negative then ValidationException with field',
        () async {
          final businessId = await createBusiness(ownerSession, 'Negativ');

          await expectLater(
            () => endpoints.businessSettings.update(
              ownerSession,
              updateRequestFor(businessId, paymentTermsDays: -1),
            ),
            throwsA(
              isA<ValidationException>().having(
                (e) => e.field,
                'field',
                'paymentTermsDays',
              ),
            ),
          );
        },
      );

      test(
        'when invoiceNumberMinDigits is below 1 then ValidationException with field',
        () async {
          final businessId = await createBusiness(ownerSession, 'Zu klein');

          await expectLater(
            () => endpoints.businessSettings.update(
              ownerSession,
              updateRequestFor(businessId, invoiceNumberMinDigits: 0),
            ),
            throwsA(
              isA<ValidationException>().having(
                (e) => e.field,
                'field',
                'invoiceNumberMinDigits',
              ),
            ),
          );
        },
      );

      test(
        'when invoiceNumberMinDigits is above 10 then ValidationException with field',
        () async {
          final businessId = await createBusiness(ownerSession, 'Zu gross');

          await expectLater(
            () => endpoints.businessSettings.update(
              ownerSession,
              updateRequestFor(businessId, invoiceNumberMinDigits: 11),
            ),
            throwsA(
              isA<ValidationException>().having(
                (e) => e.field,
                'field',
                'invoiceNumberMinDigits',
              ),
            ),
          );
        },
      );

      test(
        'when roundingGranularityMinutes is below 1 then ValidationException with field',
        () async {
          final businessId = await createBusiness(ownerSession, 'Null Minuten');

          await expectLater(
            () => endpoints.businessSettings.update(
              ownerSession,
              updateRequestFor(businessId, roundingGranularityMinutes: 0),
            ),
            throwsA(
              isA<ValidationException>().having(
                (e) => e.field,
                'field',
                'roundingGranularityMinutes',
              ),
            ),
          );
        },
      );
    });

    group('auth and roles', () {
      test(
        'when a plain member gets settings then read access is allowed',
        () async {
          // Pinned behavior: `get` only requires membership (`resolve`), not
          // an admin role.
          final businessId = await createBusiness(ownerSession, 'Lesezugriff');
          await Membership.db.insertRow(
            rawSession,
            Membership(
              userId: UuidValue.fromString(memberId),
              businessId: businessId,
              role: MembershipRole.member,
            ),
          );

          final settings = await endpoints.businessSettings.get(
            memberSession,
            businessId: businessId,
          );

          expect(settings.businessId, businessId);
        },
      );

      test(
        'when a plain member updates then ForbiddenException is thrown',
        () async {
          final businessId = await createBusiness(ownerSession, 'Kein Admin');
          await Membership.db.insertRow(
            rawSession,
            Membership(
              userId: UuidValue.fromString(memberId),
              businessId: businessId,
              role: MembershipRole.member,
            ),
          );

          await expectLater(
            () => endpoints.businessSettings.update(
              memberSession,
              updateRequestFor(businessId),
            ),
            throwsA(isA<ForbiddenException>()),
          );
        },
      );

      test(
        'when unauthenticated gets settings then ServerpodUnauthenticatedException',
        () async {
          final businessId = await createBusiness(ownerSession, 'Auth Get');
          final unauthenticated = sessionBuilder.copyWith(
            authentication: AuthenticationOverride.unauthenticated(),
          );

          await expectLater(
            () => endpoints.businessSettings.get(
              unauthenticated,
              businessId: businessId,
            ),
            throwsA(isA<ServerpodUnauthenticatedException>()),
          );
        },
      );

      test(
        'when unauthenticated updates then ServerpodUnauthenticatedException',
        () async {
          final businessId = await createBusiness(ownerSession, 'Auth Update');
          final unauthenticated = sessionBuilder.copyWith(
            authentication: AuthenticationOverride.unauthenticated(),
          );

          await expectLater(
            () => endpoints.businessSettings.update(
              unauthenticated,
              updateRequestFor(businessId),
            ),
            throwsA(isA<ServerpodUnauthenticatedException>()),
          );
        },
      );
    });

    group('tenant isolation', () {
      test(
        'when another user gets or updates foreign settings then ForbiddenException',
        () async {
          final businessAId = await createBusiness(ownerSession, 'Gewerbe A');
          final businessBId = await createBusiness(
            outsiderSession,
            'Gewerbe B',
          );

          await expectLater(
            () => endpoints.businessSettings.get(
              outsiderSession,
              businessId: businessAId,
            ),
            throwsA(isA<ForbiddenException>()),
          );
          await expectLater(
            () => endpoints.businessSettings.update(
              outsiderSession,
              updateRequestFor(businessAId),
            ),
            throwsA(isA<ForbiddenException>()),
          );

          // The foreign settings row must be untouched.
          final untouched = await endpoints.businessSettings.get(
            ownerSession,
            businessId: businessAId,
          );
          expect(untouched.businessId, businessAId);
          expect(untouched.paymentTermsDays, 14);

          // Sanity: the outsider can still read their own settings.
          final own = await endpoints.businessSettings.get(
            outsiderSession,
            businessId: businessBId,
          );
          expect(own.businessId, businessBId);
        },
      );

      test(
        'when an authenticated user without membership gets default settings '
        'then NotFoundException is thrown',
        () async {
          await expectLater(
            () => endpoints.businessSettings.get(outsiderSession),
            throwsA(isA<NotFoundException>()),
          );
        },
      );
    });
  });
}
