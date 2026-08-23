@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/di/service_locator.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/time_tracking/application/stop_timer_use_case.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given the running-timer uniqueness', (
    sessionBuilder,
    endpoints,
  ) {
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

    test('when starting a second timer then ConflictException', () async {
      await endpoints.timeEntry.startTimer(
        authenticatedSession,
        StartTimerRequest(),
        businessId: businessId,
      );

      await expectLater(
        () => endpoints.timeEntry.startTimer(
          authenticatedSession,
          StartTimerRequest(),
          businessId: businessId,
        ),
        throwsA(isA<ConflictException>()),
      );
    });

    test(
      'when a running entry bypasses the guard then the unique index rejects it',
      () async {
        await endpoints.timeEntry.startTimer(
          authenticatedSession,
          StartTimerRequest(),
          businessId: businessId,
        );

        // Inserting a second row without a stoppedAt must be impossible at
        // the database level, even when the use case check is bypassed.
        final session = authenticatedSession.build();
        try {
          await expectLater(
            () => TimeEntry.db.insertRow(
              session,
              TimeEntry(businessId: businessId, startedAt: DateTime.now()),
            ),
            throwsA(
              isA<DatabaseQueryException>().having(
                (e) => e.constraintName,
                'constraintName',
                'time_entry_business_running_idx',
              ),
            ),
          );
        } finally {
          await session.close();
        }
      },
    );

    test('when the timer is stopped then a new timer can be started', () async {
      final first = await endpoints.timeEntry.startTimer(
        authenticatedSession,
        StartTimerRequest(),
        businessId: businessId,
      );
      await getIt<StopTimerUseCase>().call(
        authenticatedSession.build(),
        now: DateTime.now().add(const Duration(minutes: 5)),
        businessId: businessId,
      );

      // Stopped entries carry a stoppedAt and no longer block the index.
      final second = await endpoints.timeEntry.startTimer(
        authenticatedSession,
        StartTimerRequest(),
        businessId: businessId,
      );

      expect(second.id, isNot(first.id));
      expect(second.stoppedAt, isNull);
    });
  });
}
