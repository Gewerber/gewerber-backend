@TestOn('vm')
@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/di/service_locator.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:gewerber_backend_server/src/modules/invoicing/application/process_recurring_invoices_use_case.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const userAId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const userBId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given recurring schedule management', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder authenticatedSession;
    late TestSessionBuilder otherSession;
    late int businessId;
    late int otherBusinessId;

    setUp(() async {
      authenticatedSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userAId,
          {},
        ),
      );
      otherSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(userBId, {}),
      );
      final business = await endpoints.business.create(
        authenticatedSession,
        CreateBusinessRequest(name: 'Gewerbe A'),
      );
      businessId = business.id!;
      final otherBusiness = await endpoints.business.create(
        otherSession,
        CreateBusinessRequest(name: 'Gewerbe B'),
      );
      otherBusinessId = otherBusiness.id!;
    });

    /// Creates a plain draft invoice for tenant A.
    Future<Invoice> createInvoice({DateTime? issueDate}) {
      return endpoints.invoice.create(
        authenticatedSession,
        CreateInvoiceRequest(
          issueDate: issueDate ?? DateTime(2026, 7, 1),
          items: [
            InvoiceItemRequest(
              description: 'Miete',
              quantity: 1,
              unitPriceCents: 50000,
              vatRate: VatRate.standard,
            ),
          ],
        ),
        businessId: businessId,
      );
    }

    group('create', () {
      test(
        'when no next date is given then it is recalculated from the issue date',
        () async {
          final invoice = await createInvoice();

          final schedule = await endpoints.recurringSchedule.create(
            authenticatedSession,
            CreateRecurringScheduleRequest(
              invoiceId: invoice.id!,
              interval: RecurrenceInterval.monthly,
            ),
            businessId: businessId,
          );

          expect(schedule.recurrenceInterval, RecurrenceInterval.monthly);
          // One interval after the source's issue date.
          expect(
            schedule.nextRecurrenceDate!.toUtc(),
            DateTime(2026, 8, 1).toUtc(),
          );
          expect(schedule.recurrenceOccurrencesCreated, 0);
        },
      );

      test('when bounds are given then they are stored', () async {
        final invoice = await createInvoice();

        final schedule = await endpoints.recurringSchedule.create(
          authenticatedSession,
          CreateRecurringScheduleRequest(
            invoiceId: invoice.id!,
            interval: RecurrenceInterval.weekly,
            nextRecurrenceDate: DateTime(2026, 7, 15),
            recurrenceEndDate: DateTime(2026, 12, 31),
            recurrenceMaxOccurrences: 10,
          ),
          businessId: businessId,
        );

        expect(schedule.recurrenceInterval, RecurrenceInterval.weekly);
        expect(
          schedule.nextRecurrenceDate!.toUtc(),
          DateTime(2026, 7, 15).toUtc(),
        );
        expect(
          schedule.recurrenceEndDate!.toUtc(),
          DateTime(2026, 12, 31).toUtc(),
        );
        expect(schedule.recurrenceMaxOccurrences, 10);
      });

      test(
        'when the end date is not after the next date then ValidationException',
        () async {
          final invoice = await createInvoice();

          await expectLater(
            () => endpoints.recurringSchedule.create(
              authenticatedSession,
              CreateRecurringScheduleRequest(
                invoiceId: invoice.id!,
                interval: RecurrenceInterval.monthly,
                nextRecurrenceDate: DateTime(2026, 9, 1),
                recurrenceEndDate: DateTime(2026, 8, 1),
              ),
              businessId: businessId,
            ),
            throwsA(
              isA<ValidationException>().having(
                (e) => e.field,
                'field',
                'recurrenceEndDate',
              ),
            ),
          );
        },
      );

      test(
        'when max occurrences is below one then ValidationException',
        () async {
          final invoice = await createInvoice();

          await expectLater(
            () => endpoints.recurringSchedule.create(
              authenticatedSession,
              CreateRecurringScheduleRequest(
                invoiceId: invoice.id!,
                interval: RecurrenceInterval.monthly,
                recurrenceMaxOccurrences: 0,
              ),
              businessId: businessId,
            ),
            throwsA(isA<ValidationException>()),
          );
        },
      );

      test('when a schedule already exists then ConflictException', () async {
        final invoice = await createInvoice();
        await endpoints.recurringSchedule.create(
          authenticatedSession,
          CreateRecurringScheduleRequest(
            invoiceId: invoice.id!,
            interval: RecurrenceInterval.monthly,
          ),
          businessId: businessId,
        );

        await expectLater(
          () => endpoints.recurringSchedule.create(
            authenticatedSession,
            CreateRecurringScheduleRequest(
              invoiceId: invoice.id!,
              interval: RecurrenceInterval.weekly,
            ),
            businessId: businessId,
          ),
          throwsA(isA<ConflictException>()),
        );
      });
    });

    group('get', () {
      test(
        'when the schedule exists then its source invoice is returned',
        () async {
          final invoice = await createInvoice();
          await endpoints.recurringSchedule.create(
            authenticatedSession,
            CreateRecurringScheduleRequest(
              invoiceId: invoice.id!,
              interval: RecurrenceInterval.monthly,
            ),
            businessId: businessId,
          );

          final schedule = await endpoints.recurringSchedule.get(
            authenticatedSession,
            invoice.id!,
            businessId: businessId,
          );
          expect(schedule.id, invoice.id);
          expect(schedule.recurrenceInterval, RecurrenceInterval.monthly);
        },
      );

      test('when the invoice has no schedule then NotFoundException', () async {
        final invoice = await createInvoice();

        await expectLater(
          () => endpoints.recurringSchedule.get(
            authenticatedSession,
            invoice.id!,
            businessId: businessId,
          ),
          throwsA(isA<NotFoundException>()),
        );
      });
    });

    group('list', () {
      test(
        'when several schedules exist then only recurring invoices are listed, upcoming first',
        () async {
          final plain = await createInvoice(issueDate: DateTime(2026, 6, 1));
          final first = await createInvoice(issueDate: DateTime(2026, 5, 1));
          final second = await createInvoice(issueDate: DateTime(2026, 4, 1));
          await endpoints.recurringSchedule.create(
            authenticatedSession,
            CreateRecurringScheduleRequest(
              invoiceId: first.id!,
              interval: RecurrenceInterval.monthly,
              nextRecurrenceDate: DateTime(2026, 9, 1),
            ),
            businessId: businessId,
          );
          await endpoints.recurringSchedule.create(
            authenticatedSession,
            CreateRecurringScheduleRequest(
              invoiceId: second.id!,
              interval: RecurrenceInterval.monthly,
              nextRecurrenceDate: DateTime(2026, 8, 1),
            ),
            businessId: businessId,
          );

          final schedules = await endpoints.recurringSchedule.list(
            authenticatedSession,
            businessId: businessId,
          );

          expect(schedules.map((s) => s.id), [second.id, first.id]);
          expect(schedules.map((s) => s.id), isNot(contains(plain.id)));
        },
      );
    });

    group('update', () {
      test(
        'when the interval changes without an explicit date then the next date is recalculated',
        () async {
          final invoice = await createInvoice();
          await endpoints.recurringSchedule.create(
            authenticatedSession,
            CreateRecurringScheduleRequest(
              invoiceId: invoice.id!,
              interval: RecurrenceInterval.monthly,
              nextRecurrenceDate: DateTime(2026, 8, 1),
            ),
            businessId: businessId,
          );

          final updated = await endpoints.recurringSchedule.update(
            authenticatedSession,
            UpdateRecurringScheduleRequest(
              invoiceId: invoice.id!,
              interval: RecurrenceInterval.weekly,
            ),
            businessId: businessId,
          );

          expect(updated.recurrenceInterval, RecurrenceInterval.weekly);
          // One new-interval step from the previously scheduled date.
          expect(
            updated.nextRecurrenceDate!.toUtc(),
            DateTime(2026, 8, 8).toUtc(),
          );
        },
      );

      test('when an explicit next date is given then it wins', () async {
        final invoice = await createInvoice();
        await endpoints.recurringSchedule.create(
          authenticatedSession,
          CreateRecurringScheduleRequest(
            invoiceId: invoice.id!,
            interval: RecurrenceInterval.monthly,
          ),
          businessId: businessId,
        );

        final updated = await endpoints.recurringSchedule.update(
          authenticatedSession,
          UpdateRecurringScheduleRequest(
            invoiceId: invoice.id!,
            nextRecurrenceDate: DateTime(2026, 10, 2),
          ),
          businessId: businessId,
        );

        expect(updated.recurrenceInterval, RecurrenceInterval.monthly);
        expect(
          updated.nextRecurrenceDate!.toUtc(),
          DateTime(2026, 10, 2).toUtc(),
        );
      });

      test(
        'when updating a non-scheduled invoice then NotFoundException',
        () async {
          final invoice = await createInvoice();

          await expectLater(
            () => endpoints.recurringSchedule.update(
              authenticatedSession,
              UpdateRecurringScheduleRequest(
                invoiceId: invoice.id!,
                interval: RecurrenceInterval.weekly,
              ),
              businessId: businessId,
            ),
            throwsA(isA<NotFoundException>()),
          );
        },
      );

      group('clear flags', () {
        /// Creates a schedule with both limits set.
        Future<int> createScheduleWithLimits() async {
          final invoice = await createInvoice();
          final schedule = await endpoints.recurringSchedule.create(
            authenticatedSession,
            CreateRecurringScheduleRequest(
              invoiceId: invoice.id!,
              interval: RecurrenceInterval.monthly,
              recurrenceEndDate: DateTime(2026, 12, 31),
              recurrenceMaxOccurrences: 6,
            ),
            businessId: businessId,
          );
          expect(schedule.recurrenceEndDate, isNotNull);
          expect(schedule.recurrenceMaxOccurrences, 6);
          return invoice.id!;
        }

        test(
          'when clearing the end date then the limit is removed',
          () async {
            final invoiceId = await createScheduleWithLimits();

            final updated = await endpoints.recurringSchedule.update(
              authenticatedSession,
              UpdateRecurringScheduleRequest(
                invoiceId: invoiceId,
                clearRecurrenceEndDate: true,
              ),
              businessId: businessId,
            );

            expect(updated.recurrenceEndDate, isNull);
            // The other limit is untouched.
            expect(updated.recurrenceMaxOccurrences, 6);
          },
        );

        test(
          'when clearing max occurrences then the limit is removed',
          () async {
            final invoiceId = await createScheduleWithLimits();

            final updated = await endpoints.recurringSchedule.update(
              authenticatedSession,
              UpdateRecurringScheduleRequest(
                invoiceId: invoiceId,
                clearMaxOccurrences: true,
              ),
              businessId: businessId,
            );

            expect(updated.recurrenceMaxOccurrences, isNull);
            // The other limit is untouched.
            expect(updated.recurrenceEndDate, isNotNull);
          },
        );

        test(
          'when a clear flag is combined with a value then the field is cleared',
          () async {
            final invoiceId = await createScheduleWithLimits();

            final updated = await endpoints.recurringSchedule.update(
              authenticatedSession,
              UpdateRecurringScheduleRequest(
                invoiceId: invoiceId,
                recurrenceEndDate: DateTime(2027, 3, 31),
                recurrenceMaxOccurrences: 12,
                clearRecurrenceEndDate: true,
                clearMaxOccurrences: true,
              ),
              businessId: businessId,
            );

            // The flags win over the values sent in the same request.
            expect(updated.recurrenceEndDate, isNull);
            expect(updated.recurrenceMaxOccurrences, isNull);
          },
        );

        test(
          'when no clear flag is set then a value replaces the current one',
          () async {
            final invoiceId = await createScheduleWithLimits();

            final updated = await endpoints.recurringSchedule.update(
              authenticatedSession,
              UpdateRecurringScheduleRequest(
                invoiceId: invoiceId,
                recurrenceEndDate: DateTime(2027, 1, 31),
              ),
              businessId: businessId,
            );

            expect(
              updated.recurrenceEndDate!.toUtc(),
              DateTime(2027, 1, 31).toUtc(),
            );
            expect(updated.recurrenceMaxOccurrences, 6);
          },
        );
      });
    });

    group('cancel', () {
      test('when cancelling then all recurrence fields are cleared', () async {
        final invoice = await createInvoice();
        await endpoints.recurringSchedule.create(
          authenticatedSession,
          CreateRecurringScheduleRequest(
            invoiceId: invoice.id!,
            interval: RecurrenceInterval.monthly,
            recurrenceEndDate: DateTime(2026, 12, 31),
            recurrenceMaxOccurrences: 6,
          ),
          businessId: businessId,
        );

        final cancelled = await endpoints.recurringSchedule.cancel(
          authenticatedSession,
          invoice.id!,
          businessId: businessId,
        );

        expect(cancelled.recurrenceInterval, isNull);
        expect(cancelled.nextRecurrenceDate, isNull);
        expect(cancelled.recurrenceEndDate, isNull);
        expect(cancelled.recurrenceMaxOccurrences, isNull);
        expect(cancelled.recurrenceOccurrencesCreated, 0);

        await expectLater(
          () => endpoints.recurringSchedule.get(
            authenticatedSession,
            invoice.id!,
            businessId: businessId,
          ),
          throwsA(isA<NotFoundException>()),
        );
        expect(
          await endpoints.recurringSchedule.list(
            authenticatedSession,
            businessId: businessId,
          ),
          isEmpty,
        );
      });

      test(
        'when cancelling after materialization then already created invoices are kept',
        () async {
          final invoice = await createInvoice();
          await endpoints.recurringSchedule.create(
            authenticatedSession,
            CreateRecurringScheduleRequest(
              invoiceId: invoice.id!,
              interval: RecurrenceInterval.monthly,
              nextRecurrenceDate: DateTime(2026, 8, 1),
            ),
            businessId: businessId,
          );
          final materialized = await getIt<ProcessRecurringInvoicesUseCase>()
              .call(authenticatedSession.build(), now: DateTime(2026, 8, 2));
          expect(materialized, 1);

          await endpoints.recurringSchedule.cancel(
            authenticatedSession,
            invoice.id!,
            businessId: businessId,
          );

          final invoices = await endpoints.invoice.list(
            authenticatedSession,
            businessId: businessId,
          );
          expect(invoices.length, 2);
          // No further materialization happens after cancellation.
          final again = await getIt<ProcessRecurringInvoicesUseCase>().call(
            authenticatedSession.build(),
            now: DateTime(2026, 9, 2),
          );
          expect(again, 0);
        },
      );

      test(
        'when cancelling a non-scheduled invoice then NotFoundException',
        () async {
          final invoice = await createInvoice();

          await expectLater(
            () => endpoints.recurringSchedule.cancel(
              authenticatedSession,
              invoice.id!,
              businessId: businessId,
            ),
            throwsA(isA<NotFoundException>()),
          );
        },
      );
    });

    group('tenant isolation (IDOR)', () {
      late int foreignInvoiceId;

      setUp(() async {
        final invoice = await createInvoice();
        await endpoints.recurringSchedule.create(
          authenticatedSession,
          CreateRecurringScheduleRequest(
            invoiceId: invoice.id!,
            interval: RecurrenceInterval.monthly,
          ),
          businessId: businessId,
        );
        foreignInvoiceId = invoice.id!;
      });

      test('when B reads a schedule of A then NotFoundException', () async {
        await expectLater(
          () => endpoints.recurringSchedule.get(
            otherSession,
            foreignInvoiceId,
            businessId: otherBusinessId,
          ),
          throwsA(isA<NotFoundException>()),
        );
      });

      test('when B updates a schedule of A then NotFoundException', () async {
        await expectLater(
          () => endpoints.recurringSchedule.update(
            otherSession,
            UpdateRecurringScheduleRequest(
              invoiceId: foreignInvoiceId,
              interval: RecurrenceInterval.weekly,
            ),
            businessId: otherBusinessId,
          ),
          throwsA(isA<NotFoundException>()),
        );
      });

      test('when B cancels a schedule of A then NotFoundException', () async {
        await expectLater(
          () => endpoints.recurringSchedule.cancel(
            otherSession,
            foreignInvoiceId,
            businessId: otherBusinessId,
          ),
          throwsA(isA<NotFoundException>()),
        );

        // The schedule of A is untouched.
        final schedule = await endpoints.recurringSchedule.get(
          authenticatedSession,
          foreignInvoiceId,
          businessId: businessId,
        );
        expect(schedule.recurrenceInterval, RecurrenceInterval.monthly);
      });

      test(
        'when B attaches a schedule to an invoice of A then NotFoundException',
        () async {
          await expectLater(
            () => endpoints.recurringSchedule.create(
              otherSession,
              CreateRecurringScheduleRequest(
                invoiceId: foreignInvoiceId,
                interval: RecurrenceInterval.weekly,
              ),
              businessId: otherBusinessId,
            ),
            throwsA(isA<NotFoundException>()),
          );
        },
      );

      test("when B lists schedules then A's are not included", () async {
        final schedules = await endpoints.recurringSchedule.list(
          otherSession,
          businessId: otherBusinessId,
        );
        expect(schedules, isEmpty);
      });
    });
  });
}
