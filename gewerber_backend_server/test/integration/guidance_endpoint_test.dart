@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const otherUserId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given GuidanceEndpoint', (sessionBuilder, endpoints) {
    late TestSessionBuilder authenticatedSession;

    setUp(() {
      authenticatedSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          testUserId,
          {},
        ),
      );
    });

    test('when listing tips then known topics are present', () async {
      final tips = await endpoints.guidance.tips(authenticatedSession);

      expect(tips, isNotEmpty);
      final topics = tips.map((t) => t.topic).toSet();
      expect(topics, contains('invoicing.kleinunternehmer'));
      expect(topics, contains('invoicing.reverseCharge'));
      for (final tip in tips) {
        expect(tip.title, isNotEmpty);
        expect(tip.body, isNotEmpty);
      }
    });

    test('when listing checklists then items are included', () async {
      final checklists = await endpoints.guidance.checklists(
        authenticatedSession,
      );

      expect(checklists.length, greaterThanOrEqualTo(2));
      final onboarding = checklists.firstWhere((c) => c.key == 'onboarding');
      expect(onboarding.items.length, greaterThanOrEqualTo(3));
      for (final item in onboarding.items) {
        expect(item.key, startsWith('onboarding/'));
        expect(item.title, isNotEmpty);
      }
    });

    test('when marking completed then progress is stored once', () async {
      const itemKey = 'onboarding/business-profile';

      await endpoints.guidance.markCompleted(authenticatedSession, itemKey);
      await endpoints.guidance.markCompleted(authenticatedSession, itemKey);

      final progress = await endpoints.guidance.myProgress(
        authenticatedSession,
      );
      expect(progress.length, 1);
      expect(progress.first.itemKey, itemKey);
      expect(progress.first.completedAt, isNotNull);
      expect(progress.first.dismissedAt, isNull);
    });

    test('when dismissing a tip then progress uses tip: prefix', () async {
      await endpoints.guidance.dismissTip(
        authenticatedSession,
        'invoicing.kleinunternehmer',
      );

      final progress = await endpoints.guidance.myProgress(
        authenticatedSession,
      );
      expect(progress.length, 1);
      expect(progress.first.itemKey, 'tip:invoicing.kleinunternehmer');
      expect(progress.first.dismissedAt, isNotNull);
      expect(progress.first.completedAt, isNull);
    });

    test('when completing after dismissing then both are kept', () async {
      await endpoints.guidance.dismissTip(authenticatedSession, 'some-topic');
      await endpoints.guidance.markCompleted(
        authenticatedSession,
        'tip:some-topic',
      );

      final progress = await endpoints.guidance.myProgress(
        authenticatedSession,
      );
      expect(progress.length, 1);
      expect(progress.first.completedAt, isNotNull);
      expect(progress.first.dismissedAt, isNotNull);
    });

    test('when another user works then progress stays separate', () async {
      await endpoints.guidance.markCompleted(
        authenticatedSession,
        'onboarding/first-invoice',
      );

      final otherSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          otherUserId,
          {},
        ),
      );

      final otherProgress = await endpoints.guidance.myProgress(otherSession);
      expect(otherProgress, isEmpty);
    });

    test('when unauthenticated then access is denied', () async {
      final unauthenticatedSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.unauthenticated(),
      );

      await expectLater(
        () => endpoints.guidance.tips(unauthenticatedSession),
        throwsA(isA<ServerpodUnauthenticatedException>()),
      );
    });
  });
}
