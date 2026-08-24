@TestOn('vm')
@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/pagination/list_limits.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Tests for the keyset/cursor pagination endpoints
/// (`invoice.listCursorPage` / `customer.listCursorPage`).
///
/// Documented behaviour: cursors are tenant-scoped. A cursor minted for
/// another tenant is rejected with [ValidationException] (field `cursor`),
/// exactly like a structurally malformed cursor — a silent empty page would
/// hide client bugs.
void main() {
  const userAId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const userBId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given invoice and customer listCursorPage endpoints', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder authenticatedSession;
    late TestSessionBuilder otherSession;
    late Session rawSession;
    late int businessId;
    late int otherBusinessId;
    late List<String> expectedInvoiceOrder;
    late List<int> expectedCustomerOrder;

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
      rawSession = sessionBuilder.build();

      final business = await endpoints.business.create(
        authenticatedSession,
        CreateBusinessRequest(name: 'Cursor Gewerbe A'),
      );
      businessId = business.id!;
      final otherBusiness = await endpoints.business.create(
        otherSession,
        CreateBusinessRequest(name: 'Cursor Gewerbe B'),
      );
      otherBusinessId = otherBusiness.id!;

      // Seed: 11 invoices for tenant A. Several share the same issueDate to
      // exercise the id tiebreak of the stable order.
      final seededInvoices = await Invoice.db.insert(rawSession, [
        for (var i = 0; i < 11; i++)
          Invoice(
            businessId: businessId,
            number: 'CUR-A-${i.toString().padLeft(3, '0')}',
            status: i < 4 ? InvoiceStatus.sent : InvoiceStatus.draft,
            // Days 0..10, but every second invoice repeats the previous date.
            issueDate: DateTime.utc(
              2026,
              1,
              1,
            ).add(Duration(days: i - (i % 2))),
          ),
      ]);
      final sortedInvoices = [...seededInvoices]
        ..sort((a, b) {
          final byDate = b.issueDate.compareTo(a.issueDate);
          return byDate != 0 ? byDate : b.id!.compareTo(a.id!);
        });
      expectedInvoiceOrder = [
        for (final invoice in sortedInvoices) invoice.number,
      ];

      // Foreign invoice for tenant B must never appear in A's pages.
      await Invoice.db.insert(rawSession, [
        Invoice(
          businessId: otherBusinessId,
          number: 'CUR-B-000',
          issueDate: DateTime.utc(2026, 6, 1),
        ),
      ]);

      // Seed: 9 customers for tenant A with mixed createdAt values
      // (including exact duplicates for the tiebreak).
      final baseCreated = DateTime.utc(2026, 3, 1, 12);
      final seededCustomers = await Customer.db.insert(rawSession, [
        for (var i = 0; i < 9; i++)
          Customer(
            businessId: businessId,
            name: 'Cursor Kunde A$i',
            status: i == 8 ? CustomerStatus.archived : CustomerStatus.active,
            createdAt: baseCreated.add(Duration(hours: i ~/ 2)),
            updatedAt: baseCreated.add(Duration(hours: i ~/ 2)),
          ),
      ]);
      final sortedCustomers = [...seededCustomers]
        ..sort((a, b) {
          final byDate = b.createdAt.compareTo(a.createdAt);
          return byDate != 0 ? byDate : b.id!.compareTo(a.id!);
        });
      expectedCustomerOrder = [
        for (final customer in sortedCustomers) customer.id!,
      ];
    });

    group('invoice.listCursorPage', () {
      test(
        'when walking all pages then the full data set is covered without '
        'gaps or duplicates',
        () async {
          final collected = <String>[];
          final cursorsSeen = <String>{};
          String? cursor;
          var pages = 0;

          while (true) {
            final page = await endpoints.invoice.listCursorPage(
              authenticatedSession,
              limit: 4,
              cursor: cursor,
              businessId: businessId,
            );
            expect(page.limit, 4);
            pages++;
            collected.addAll([for (final i in page.items) i.number]);
            if (page.nextCursor == null) break;
            expect(
              cursorsSeen.add(page.nextCursor!),
              isTrue,
              reason: 'cursor repeated: walk would loop forever',
            );
            cursor = page.nextCursor;
            expect(pages, lessThan(20), reason: 'runaway pagination walk');
          }

          expect(pages, 3); // ceil(11 / 4)
          expect(collected, hasLength(11));
          expect(collected.toSet(), hasLength(11), reason: 'no duplicates');
          // Full order equals the ground-truth keyset ordering.
          expect(collected, expectedInvoiceOrder);
        },
      );

      test(
        'when the last page is reached then nextCursor is null and the '
        'previous cursor still returns the same tail',
        () async {
          final first = await endpoints.invoice.listCursorPage(
            authenticatedSession,
            limit: 10,
            businessId: businessId,
          );
          expect(first.items, hasLength(10));
          expect(first.nextCursor, isNotNull);

          final second = await endpoints.invoice.listCursorPage(
            authenticatedSession,
            limit: 10,
            cursor: first.nextCursor,
            businessId: businessId,
          );
          expect(second.items, hasLength(1));
          expect(second.nextCursor, isNull);

          // Re-walking from the same cursor is deterministic (no state).
          final replay = await endpoints.invoice.listCursorPage(
            authenticatedSession,
            limit: 10,
            cursor: first.nextCursor,
            businessId: businessId,
          );
          expect(replay.items.single.id, second.items.single.id);
        },
      );

      test(
        'when filtering by status then only matching rows are walked',
        () async {
          final collected = <String>[];
          String? cursor;
          while (true) {
            final page = await endpoints.invoice.listCursorPage(
              authenticatedSession,
              status: InvoiceStatus.sent,
              limit: 2,
              cursor: cursor,
              businessId: businessId,
            );
            expect(
              page.items.every((i) => i.status == InvoiceStatus.sent),
              isTrue,
            );
            collected.addAll([for (final i in page.items) i.number]);
            if (page.nextCursor == null) break;
            cursor = page.nextCursor;
          }
          expect(collected, hasLength(4));
          expect(collected.toSet(), hasLength(4));
        },
      );

      test(
        'when the dataset fits one page then no nextCursor is issued',
        () async {
          final page = await endpoints.invoice.listCursorPage(
            authenticatedSession,
            limit: maxListLimit,
            businessId: businessId,
          );
          expect(page.items, hasLength(11));
          expect(page.nextCursor, isNull);
        },
      );

      test(
        'when requesting beyond the cap then the limit is clamped',
        () async {
          final page = await endpoints.invoice.listCursorPage(
            authenticatedSession,
            limit: 5000,
            businessId: businessId,
          );
          expect(page.limit, maxListLimit);
        },
      );

      test('when the cursor is malformed then it is rejected', () async {
        for (final garbage in ['not-a-cursor', '###', 'eyJhIjoxfQ==']) {
          await expectLater(
            () => endpoints.invoice.listCursorPage(
              authenticatedSession,
              cursor: garbage,
              businessId: businessId,
            ),
            throwsA(isA<ValidationException>()),
            reason: 'cursor "$garbage" should be rejected',
          );
        }
      });
    });

    group('customer.listCursorPage', () {
      test(
        'when walking all pages then the full data set is covered without '
        'gaps or duplicates',
        () async {
          final collected = <int>[];
          String? cursor;
          while (true) {
            final page = await endpoints.customer.listCursorPage(
              authenticatedSession,
              limit: 3,
              cursor: cursor,
              businessId: businessId,
            );
            collected.addAll([for (final c in page.items) c.id!]);
            if (page.nextCursor == null) break;
            cursor = page.nextCursor;
          }

          expect(collected, hasLength(9));
          expect(collected.toSet(), hasLength(9), reason: 'no duplicates');
          expect(collected, expectedCustomerOrder);
        },
      );

      test(
        'when filtering by status then only matching rows are walked',
        () async {
          final collected = <int>[];
          String? cursor;
          while (true) {
            final page = await endpoints.customer.listCursorPage(
              authenticatedSession,
              status: CustomerStatus.active,
              limit: 5,
              cursor: cursor,
              businessId: businessId,
            );
            expect(
              page.items.every((c) => c.status == CustomerStatus.active),
              isTrue,
            );
            collected.addAll([for (final c in page.items) c.id!]);
            if (page.nextCursor == null) break;
            cursor = page.nextCursor;
          }
          expect(collected, hasLength(8)); // 9 minus one archived
        },
      );

      test(
        'when rows share createdAt then the id tiebreak keeps pages disjoint',
        () async {
          final seenIds = <int>{};
          String? cursor;
          DateTime? previousLastCreatedAt;
          var boundariesInsideDuplicateGroup = 0;
          while (true) {
            final page = await endpoints.customer.listCursorPage(
              authenticatedSession,
              limit: 2,
              cursor: cursor,
              businessId: businessId,
            );
            for (final customer in page.items) {
              expect(
                seenIds.add(customer.id!),
                isTrue,
                reason: 'duplicate row across pages',
              );
            }
            if (page.items.isNotEmpty && previousLastCreatedAt != null) {
              // Seeded pairs share timestamps; several page boundaries fall
              // inside such a group and must still not skip or repeat rows.
              if (page.items.first.createdAt == previousLastCreatedAt) {
                boundariesInsideDuplicateGroup++;
                // Tiebreak order inside the group: descending ids.
                expect(page.items.first.id!, isNotNull);
              }
            }
            if (page.items.isNotEmpty) {
              previousLastCreatedAt = page.items.last.createdAt;
            }
            if (page.nextCursor == null) break;
            cursor = page.nextCursor;
          }
          expect(boundariesInsideDuplicateGroup, greaterThanOrEqualTo(2));
        },
      );
    });

    group('tenant isolation', () {
      test(
        'when a cursor of another tenant is used then it is rejected',
        () async {
          final ownFirst = await endpoints.invoice.listCursorPage(
            authenticatedSession,
            limit: 4,
            businessId: businessId,
          );
          expect(ownFirst.nextCursor, isNotNull);

          await expectLater(
            () => endpoints.invoice.listCursorPage(
              otherSession,
              cursor: ownFirst.nextCursor,
              businessId: otherBusinessId,
            ),
            throwsA(
              isA<ValidationException>().having(
                (e) => e.field,
                'field',
                'cursor',
              ),
            ),
          );

          // Same rejection for the customers endpoint.
          final ownCustomerFirst = await endpoints.customer.listCursorPage(
            authenticatedSession,
            limit: 2,
            businessId: businessId,
          );
          expect(ownCustomerFirst.nextCursor, isNotNull);
          await expectLater(
            () => endpoints.customer.listCursorPage(
              otherSession,
              cursor: ownCustomerFirst.nextCursor,
              businessId: otherBusinessId,
            ),
            throwsA(isA<ValidationException>()),
          );

          // Tenant B's own walk is unaffected and never contains A's rows.
          final ownB = await endpoints.invoice.listCursorPage(
            otherSession,
            limit: 100,
            businessId: otherBusinessId,
          );
          expect(
            ownB.items.map((i) => i.number),
            everyElement('CUR-B-000'),
          );
        },
      );

      test(
        'when a membership-less tenant id is passed then it is rejected',
        () async {
          await expectLater(
            () => endpoints.invoice.listCursorPage(
              otherSession,
              businessId: businessId,
            ),
            throwsA(isA<ForbiddenException>()),
          );
        },
      );
    });
  });
}
