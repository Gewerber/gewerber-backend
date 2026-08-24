@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Manual time entry input must not surface database unique-index violations
/// (`time_entry_business_running_idx`, `(businessId, stoppedAt)` with
/// NULLS NOT DISTINCT) as 500s — a byte-identical end time within one
/// business is a user input problem and maps to `ValidationException`.
void main() {
  const userAId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const userBId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given manual time entry creation', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder sessionA;
    late TestSessionBuilder sessionB;
    late int businessAId;
    late int businessBId;

    setUp(() async {
      sessionA = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(userAId, {}),
      );
      sessionB = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(userBId, {}),
      );
      final businessA = await endpoints.business.create(
        sessionA,
        CreateBusinessRequest(name: 'Gewerbe A'),
      );
      businessAId = businessA.id!;
      final businessB = await endpoints.business.create(
        sessionB,
        CreateBusinessRequest(name: 'Gewerbe B'),
      );
      businessBId = businessB.id!;
    });

    test(
      'when creating two entries with the same end time then ValidationException',
      () async {
        // Both entries end at exactly 10:00 UTC.
        await endpoints.timeEntry.create(
          sessionA,
          CreateTimeEntryRequest(
            startedAt: DateTime.utc(2026, 7, 1, 9),
            durationMinutes: 60,
          ),
          businessId: businessAId,
        );

        await expectLater(
          () => endpoints.timeEntry.create(
            sessionA,
            CreateTimeEntryRequest(
              startedAt: DateTime.utc(2026, 7, 1, 9, 15),
              durationMinutes: 45,
            ),
            businessId: businessAId,
          ),
          throwsA(isA<ValidationException>()),
        );
      },
    );

    test(
      'when the same end time exists in another business then it is allowed',
      () async {
        final first = await endpoints.timeEntry.create(
          sessionA,
          CreateTimeEntryRequest(
            startedAt: DateTime.utc(2026, 7, 1, 9),
            durationMinutes: 60,
          ),
          businessId: businessAId,
        );

        // The index is scoped to (businessId, stoppedAt) — another business
        // may freely use the same end time.
        final other = await endpoints.timeEntry.create(
          sessionB,
          CreateTimeEntryRequest(
            startedAt: DateTime.utc(2026, 7, 1, 9),
            durationMinutes: 60,
          ),
          businessId: businessBId,
        );

        expect(other.stoppedAt, first.stoppedAt);
      },
    );
  });

  withServerpod('Given manual time entry updates', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder sessionA;
    late int businessAId;
    late TimeEntry endsAtTen;
    late TimeEntry endsAtThirteen;

    setUp(() async {
      sessionA = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(userAId, {}),
      );
      final businessA = await endpoints.business.create(
        sessionA,
        CreateBusinessRequest(name: 'Gewerbe A'),
      );
      businessAId = businessA.id!;
      endsAtTen = await endpoints.timeEntry.create(
        sessionA,
        CreateTimeEntryRequest(
          startedAt: DateTime.utc(2026, 7, 1, 9),
          durationMinutes: 60,
        ),
        businessId: businessAId,
      );
      endsAtThirteen = await endpoints.timeEntry.create(
        sessionA,
        CreateTimeEntryRequest(
          startedAt: DateTime.utc(2026, 7, 1, 12),
          durationMinutes: 60,
        ),
        businessId: businessAId,
      );
    });

    test(
      'when moving an entry onto an existing end time then ValidationException',
      () async {
        await expectLater(
          () => endpoints.timeEntry.update(
            sessionA,
            UpdateTimeEntryRequest(
              timeEntryId: endsAtThirteen.id!,
              startedAt: DateTime.utc(2026, 7, 1, 9),
              durationMinutes: 60,
              billable: true,
            ),
            businessId: businessAId,
          ),
          throwsA(isA<ValidationException>()),
        );
      },
    );

    test(
      'when updating an entry without changing its end time then it works',
      () async {
        final updated = await endpoints.timeEntry.update(
          sessionA,
          UpdateTimeEntryRequest(
            timeEntryId: endsAtTen.id!,
            description: 'Besprechung',
            startedAt: DateTime.utc(2026, 7, 1, 9),
            durationMinutes: 60,
            billable: true,
          ),
          businessId: businessAId,
        );

        expect(updated.description, 'Besprechung');
        expect(updated.stoppedAt, endsAtTen.stoppedAt);
      },
    );
  });
}
