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

  withServerpod('Given BusinessEndpoint', (sessionBuilder, endpoints) {
    late TestSessionBuilder authenticatedSession;

    setUp(() {
      authenticatedSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          testUserId,
          {},
        ),
      );
    });

    test('when creating a business then owner membership is created', () async {
      final request = CreateBusinessRequest(
        name: 'Mein Gewerbe',
        legalForm: LegalForm.einzelunternehmen,
        isKleinunternehmer: true,
        email: 'owner@example.com',
        address: Address(street: 'Hauptstr. 1', zip: '10115', city: 'Berlin'),
      );

      final business = await endpoints.business.create(
        authenticatedSession,
        request,
      );

      expect(business.name, 'Mein Gewerbe');
      expect(business.isKleinunternehmer, true);
      expect(business.legalForm, LegalForm.einzelunternehmen);
      expect(business.currency, Currency.eur);
      expect(business.locale, Locale.de);
      expect(business.id, isNotNull);

      final fetched = await endpoints.business.get(authenticatedSession);
      expect(fetched.id, business.id);
      expect(fetched.name, 'Mein Gewerbe');

      final mine = await endpoints.business.listMine(authenticatedSession);
      expect(mine.length, 1);
      expect(mine.first.id, business.id);
    });

    test('when name is empty then ValidationException is thrown', () async {
      final request = CreateBusinessRequest(name: '   ');

      expect(
        () => endpoints.business.create(authenticatedSession, request),
        throwsA(isA<ValidationException>()),
      );
    });

    test(
      'when updating as owner then fields are changed and updatedAt is set',
      () async {
        final created = await endpoints.business.create(
          authenticatedSession,
          CreateBusinessRequest(name: 'Initial Name'),
        );

        final updateRequest = UpdateBusinessRequest(
          businessId: created.id!,
          name: 'Updated Name',
          legalForm: created.legalForm,
          isKleinunternehmer: false,
          locale: created.locale,
          currency: created.currency,
        );

        final updated = await endpoints.business.update(
          authenticatedSession,
          updateRequest,
        );

        expect(updated.name, 'Updated Name');
        expect(updated.isKleinunternehmer, false);
        expect(updated.updatedAt.isAfter(created.updatedAt), true);
      },
    );

    test(
      'when unauthenticated user tries to list businesses then ForbiddenException is thrown',
      () async {
        final unauthenticatedSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.unauthenticated(),
        );

        expect(
          () => endpoints.business.listMine(unauthenticatedSession),
          throwsA(isA<ServerpodUnauthenticatedException>()),
        );
      },
    );
  });
}
