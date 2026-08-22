@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/di/service_locator.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/time_tracking/application/stop_timer_use_case.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const testUserId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given TimeTracking', (sessionBuilder, endpoints) {
    late TestSessionBuilder authenticatedSession;
    late int businessId;
    late Project project;

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

      project = await endpoints.project.create(
        authenticatedSession,
        CreateProjectRequest(name: 'Webseite', hourlyRateCents: 10000),
        businessId: businessId,
      );
    });

    test('when creating a project then it is stored', () async {
      expect(project.id, isNotNull);
      expect(project.status, ProjectStatus.active);
      expect(project.hourlyRateCents, 10000);

      final fetched = await endpoints.project.get(
        authenticatedSession,
        project.id!,
        businessId: businessId,
      );
      expect(fetched.name, 'Webseite');
    });

    test('when project name is blank then ValidationException', () async {
      await expectLater(
        () => endpoints.project.create(
          authenticatedSession,
          CreateProjectRequest(name: '   '),
          businessId: businessId,
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('when updating and deleting a project then it is applied', () async {
      final updated = await endpoints.project.update(
        authenticatedSession,
        UpdateProjectRequest(
          projectId: project.id!,
          name: 'Webseite 2.0',
          status: ProjectStatus.archived,
          hourlyRateCents: 12000,
        ),
        businessId: businessId,
      );
      expect(updated.name, 'Webseite 2.0');
      expect(updated.status, ProjectStatus.archived);

      await endpoints.project.delete(
        authenticatedSession,
        project.id!,
        businessId: businessId,
      );
      await expectLater(
        () => endpoints.project.get(
          authenticatedSession,
          project.id!,
          businessId: businessId,
        ),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('when creating a task then it belongs to the project', () async {
      final task = await endpoints.task.create(
        authenticatedSession,
        CreateTaskRequest(projectId: project.id!, name: 'Design'),
        businessId: businessId,
      );
      expect(task.status, TaskStatus.open);

      final tasks = await endpoints.project.getTasks(
        authenticatedSession,
        project.id!,
        businessId: businessId,
      );
      expect(tasks.length, 1);
      expect(tasks.first.id, task.id);

      final done = await endpoints.task.update(
        authenticatedSession,
        UpdateTaskRequest(
          taskId: task.id!,
          name: 'Design',
          status: TaskStatus.done,
        ),
        businessId: businessId,
      );
      expect(done.status, TaskStatus.done);
    });

    test('when starting a timer then it is running', () async {
      final entry = await endpoints.timeEntry.startTimer(
        authenticatedSession,
        StartTimerRequest(
          projectId: project.id,
          description: 'Implementierung',
        ),
        businessId: businessId,
      );

      expect(entry.stoppedAt, isNull);
      expect(entry.durationMinutes, isNull);
      expect(entry.billable, true);
    });

    test('when a timer is already running then ConflictException', () async {
      await endpoints.timeEntry.startTimer(
        authenticatedSession,
        StartTimerRequest(projectId: project.id),
        businessId: businessId,
      );

      await expectLater(
        () => endpoints.timeEntry.startTimer(
          authenticatedSession,
          StartTimerRequest(projectId: project.id),
          businessId: businessId,
        ),
        throwsA(isA<ConflictException>()),
      );
    });

    test('when stopping a timer then the duration is stored', () async {
      final startedAt = DateTime(2026, 8, 20, 9);
      await endpoints.timeEntry.startTimer(
        authenticatedSession,
        StartTimerRequest(projectId: project.id, startedAt: startedAt),
        businessId: businessId,
      );

      final stopped = await getIt<StopTimerUseCase>().call(
        authenticatedSession.build(),
        now: startedAt.add(const Duration(hours: 1, minutes: 30)),
        businessId: businessId,
      );

      expect(stopped.stoppedAt, isNotNull);
      expect(stopped.durationMinutes, 90);

      final running = await endpoints.timeEntry.list(
        authenticatedSession,
        businessId: businessId,
      );
      expect(running.where((e) => e.stoppedAt == null), isEmpty);
    });

    test(
      'when stopping without a running timer then NotFoundException',
      () async {
        await expectLater(
          () => endpoints.timeEntry.stopTimer(
            authenticatedSession,
            businessId: businessId,
          ),
          throwsA(isA<NotFoundException>()),
        );
      },
    );

    test('when rounding is configured then stop rounds up', () async {
      final settings = await endpoints.businessSettings.get(
        authenticatedSession,
        businessId: businessId,
      );
      await endpoints.businessSettings.update(
        authenticatedSession,
        UpdateBusinessSettingsRequest(
          businessId: businessId,
          paymentTermsDays: settings.paymentTermsDays,
          invoiceNumberIncludeYear: settings.invoiceNumberIncludeYear,
          invoiceNumberMinDigits: settings.invoiceNumberMinDigits,
          roundingMode: RoundingMode.up,
          roundingGranularityMinutes: 15,
        ),
      );

      final startedAt = DateTime(2026, 8, 20, 9);
      await endpoints.timeEntry.startTimer(
        authenticatedSession,
        StartTimerRequest(projectId: project.id, startedAt: startedAt),
        businessId: businessId,
      );

      final stopped = await getIt<StopTimerUseCase>().call(
        authenticatedSession.build(),
        now: startedAt.add(const Duration(minutes: 7)),
        businessId: businessId,
      );
      expect(stopped.durationMinutes, 15);
    });

    test('when creating a manual entry then duration is fixed', () async {
      final entry = await endpoints.timeEntry.create(
        authenticatedSession,
        CreateTimeEntryRequest(
          projectId: project.id,
          description: 'Workshop',
          startedAt: DateTime(2026, 8, 19, 14),
          durationMinutes: 120,
        ),
        businessId: businessId,
      );

      expect(entry.durationMinutes, 120);
      expect(entry.stoppedAt!.difference(entry.startedAt).inMinutes, 120);
    });

    test('when manual duration is zero then ValidationException', () async {
      await expectLater(
        () => endpoints.timeEntry.create(
          authenticatedSession,
          CreateTimeEntryRequest(
            projectId: project.id,
            startedAt: DateTime(2026, 8, 19),
            durationMinutes: 0,
          ),
          businessId: businessId,
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('when editing a manual entry then values are updated', () async {
      final entry = await endpoints.timeEntry.create(
        authenticatedSession,
        CreateTimeEntryRequest(
          projectId: project.id,
          startedAt: DateTime(2026, 8, 19, 14),
          durationMinutes: 60,
        ),
        businessId: businessId,
      );

      final updated = await endpoints.timeEntry.update(
        authenticatedSession,
        UpdateTimeEntryRequest(
          timeEntryId: entry.id!,
          projectId: project.id,
          description: 'Nachbearbeitung',
          startedAt: DateTime(2026, 8, 19, 15),
          durationMinutes: 45,
          billable: false,
        ),
        businessId: businessId,
      );

      expect(updated.durationMinutes, 45);
      expect(updated.description, 'Nachbearbeitung');
      expect(updated.billable, false);
    });

    test('when editing the running timer then ConflictException', () async {
      final running = await endpoints.timeEntry.startTimer(
        authenticatedSession,
        StartTimerRequest(projectId: project.id),
        businessId: businessId,
      );

      await expectLater(
        () => endpoints.timeEntry.update(
          authenticatedSession,
          UpdateTimeEntryRequest(
            timeEntryId: running.id!,
            startedAt: running.startedAt,
            durationMinutes: 10,
            billable: true,
          ),
          businessId: businessId,
        ),
        throwsA(isA<ConflictException>()),
      );
    });

    test('when deleting an entry then it is removed', () async {
      final entry = await endpoints.timeEntry.create(
        authenticatedSession,
        CreateTimeEntryRequest(
          projectId: project.id,
          startedAt: DateTime(2026, 8, 19),
          durationMinutes: 30,
        ),
        businessId: businessId,
      );

      await endpoints.timeEntry.delete(
        authenticatedSession,
        entry.id!,
        businessId: businessId,
      );

      await expectLater(
        () => endpoints.timeEntry.get(
          authenticatedSession,
          entry.id!,
          businessId: businessId,
        ),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('when listing entries then filters apply', () async {
      final otherProject = await endpoints.project.create(
        authenticatedSession,
        CreateProjectRequest(name: 'App'),
        businessId: businessId,
      );

      await endpoints.timeEntry.create(
        authenticatedSession,
        CreateTimeEntryRequest(
          projectId: project.id,
          startedAt: DateTime(2026, 8, 1),
          durationMinutes: 60,
        ),
        businessId: businessId,
      );
      await endpoints.timeEntry.create(
        authenticatedSession,
        CreateTimeEntryRequest(
          projectId: otherProject.id,
          startedAt: DateTime(2026, 8, 2),
          durationMinutes: 30,
        ),
        businessId: businessId,
      );

      final all = await endpoints.timeEntry.list(
        authenticatedSession,
        businessId: businessId,
      );
      expect(all.length, 2);

      final filtered = await endpoints.timeEntry.list(
        authenticatedSession,
        projectId: project.id,
        businessId: businessId,
      );
      expect(filtered.length, 1);
      expect(filtered.first.projectId, project.id);

      final ranged = await endpoints.timeEntry.list(
        authenticatedSession,
        from: DateTime(2026, 8, 2),
        businessId: businessId,
      );
      expect(ranged.length, 1);
      expect(ranged.first.projectId, otherProject.id);
    });

    test(
      'when requesting a report then totals and lines are computed',
      () async {
        final task = await endpoints.task.create(
          authenticatedSession,
          CreateTaskRequest(projectId: project.id!, name: 'Design'),
          businessId: businessId,
        );

        await endpoints.timeEntry.create(
          authenticatedSession,
          CreateTimeEntryRequest(
            projectId: project.id,
            taskId: task.id,
            startedAt: DateTime(2026, 8, 3, 9),
            durationMinutes: 90,
          ),
          businessId: businessId,
        );
        await endpoints.timeEntry.create(
          authenticatedSession,
          CreateTimeEntryRequest(
            projectId: project.id,
            startedAt: DateTime(2026, 8, 4, 9),
            durationMinutes: 30,
            billable: false,
          ),
          businessId: businessId,
        );

        final report = await endpoints.timeEntry.report(
          authenticatedSession,
          DateTime(2026, 8, 1),
          DateTime(2026, 8, 31),
          businessId: businessId,
        );

        expect(report.totalMinutes, 120);
        expect(report.billableMinutes, 90);
        expect(report.lines.length, 2);

        final taskLine = report.lines.firstWhere((l) => l.taskId == task.id);
        expect(taskLine.taskName, 'Design');
        expect(taskLine.projectName, 'Webseite');
        expect(taskLine.totalMinutes, 90);
        expect(taskLine.entryCount, 1);
      },
    );
  });
}
