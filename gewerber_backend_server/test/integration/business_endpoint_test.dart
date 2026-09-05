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
        taxNumber: '14/815/0815',
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
      // Steuernummer is tenant-scoped owner data: the owner gets it back.
      expect(fetched.taxNumber, '14/815/0815');

      final mine = await endpoints.business.listMine(authenticatedSession);
      expect(mine.length, 1);
      expect(mine.first.id, business.id);
    });

    test('when name is empty then ValidationException is thrown', () async {
      final request = CreateBusinessRequest(name: '   ');

      await expectLater(
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
          vatId: 'DE123456789',
          taxNumber: '21/815/0001',
          locale: created.locale,
          currency: created.currency,
        );

        final updated = await endpoints.business.update(
          authenticatedSession,
          updateRequest,
        );

        expect(updated.name, 'Updated Name');
        expect(updated.isKleinunternehmer, false);
        expect(updated.vatId, 'DE123456789');
        expect(updated.taxNumber, '21/815/0001');
        expect(updated.updatedAt.isAfter(created.updatedAt), true);
      },
    );

    test(
      'when unauthenticated user tries to list businesses then ForbiddenException is thrown',
      () async {
        final unauthenticatedSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.unauthenticated(),
        );

        await expectLater(
          () => endpoints.business.listMine(unauthenticatedSession),
          throwsA(isA<ServerpodUnauthenticatedException>()),
        );
      },
    );
  });
}
