@TestOn('vm')
@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/core/pagination/list_limits.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Tests for the offset-based pagination pilot (`invoice.listPage` /
/// `customer.listPage`). The legacy `list` endpoints must keep working
/// unchanged alongside them.
void main() {
  const userAId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const userBId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given invoice and customer listPage endpoints', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder authenticatedSession;
    late TestSessionBuilder otherSession;
    late int businessId;
    late int otherBusinessId;
    late int sentCount;
    late int customerCount;

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
        CreateBusinessRequest(name: 'Page Gewerbe A'),
      );
      businessId = business.id!;
      final otherBusiness = await endpoints.business.create(
        otherSession,
        CreateBusinessRequest(name: 'Page Gewerbe B'),
      );
      otherBusinessId = otherBusiness.id!;

      // Seed: 7 customers (2 archived), 12 invoices (5 sent with due dates,
      // 7 draft) for tenant A plus one foreign invoice/customer for tenant B.
      const totalCustomers = 7;
      customerCount = totalCustomers;
      await Customer.db.insert(sessionBuilder.build(), [
        for (var i = 0; i < totalCustomers; i++)
          Customer(
            businessId: businessId,
            name: 'Kunde A$i',
            status: i < 2 ? CustomerStatus.archived : CustomerStatus.active,
          ),
      ]);

      const totalInvoices = 12;
      sentCount = 5;
      await Invoice.db.insert(sessionBuilder.build(), [
        for (var i = 0; i < totalInvoices; i++)
          Invoice(
            businessId: businessId,
            number: 'PAGE-A-${i.toString().padLeft(3, '0')}',
            status: i < sentCount ? InvoiceStatus.sent : InvoiceStatus.draft,
            issueDate: DateTime(2026, 1, 1).add(Duration(days: i)),
            dueDate: DateTime(2026, 2, 1).add(Duration(days: i)),
          ),
      ]);

      await Customer.db.insert(sessionBuilder.build(), [
        Customer(businessId: otherBusinessId, name: 'Kunde B'),
      ]);
      await Invoice.db.insert(sessionBuilder.build(), [
        Invoice(
          businessId: otherBusinessId,
          number: 'PAGE-B-000',
          issueDate: DateTime(2026, 1, 1),
        ),
      ]);
    });

    group('invoice.listPage', () {
      test(
        'when listing without filters then totalCount matches all rows',
        () async {
          final page = await endpoints.invoice.listPage(
            authenticatedSession,
            businessId: businessId,
          );

          expect(page.totalCount, 12);
          expect(page.items.length, 12);
          expect(page.limit, defaultListLimit);
          expect(page.offset, 0);
        },
      );

      test(
        'when filtering by status then totalCount counts only matches',
        () async {
          final page = await endpoints.invoice.listPage(
            authenticatedSession,
            status: InvoiceStatus.sent,
            limit: 3,
            businessId: businessId,
          );

          expect(page.totalCount, sentCount);
          expect(page.items.length, 3);
          expect(
            page.items.every((i) => i.status == InvoiceStatus.sent),
            isTrue,
          );
        },
      );

      test('when paging then offset/limit slice the result set', () async {
        final first = await endpoints.invoice.listPage(
          authenticatedSession,
          limit: 5,
          offset: 0,
          businessId: businessId,
        );
        final second = await endpoints.invoice.listPage(
          authenticatedSession,
          limit: 5,
          offset: 5,
          businessId: businessId,
        );
        final third = await endpoints.invoice.listPage(
          authenticatedSession,
          limit: 5,
          offset: 10,
          businessId: businessId,
        );

        expect(first.totalCount, 12);
        expect(second.totalCount, 12);
        expect(third.totalCount, 12);
        expect(first.items, isNotEmpty);
        expect(second.items, hasLength(5));
        expect(third.items, hasLength(2));
        // Pages are disjoint and together cover everything.
        final numbers = [
          ...first.items.map((i) => i.number),
          ...second.items.map((i) => i.number),
          ...third.items.map((i) => i.number),
        ];
        expect(numbers.toSet().length, 12);

        // The pages match slices of the unpaginated list (same ordering).
        final all = await endpoints.invoice.list(
          authenticatedSession,
          businessId: businessId,
        );
        expect(
          numbers,
          all.sublist(0, 12).map((i) => i.number),
        );
      });

      test(
        'when requesting beyond the cap then the limit is clamped',
        () async {
          final page = await endpoints.invoice.listPage(
            authenticatedSession,
            limit: 500,
            businessId: businessId,
          );

          expect(page.limit, maxListLimit);
          // totalCount reflects the data set, not the clamped page size.
          expect(page.totalCount, 12);
        },
      );

      test(
        'when the tenant has no rows then an empty page is returned',
        () async {
          final page = await endpoints.invoice.listPage(
            otherSession,
            status: InvoiceStatus.overdue,
            businessId: otherBusinessId,
          );

          expect(page.totalCount, 0);
          expect(page.items, isEmpty);
        },
      );
    });

    group('customer.listPage', () {
      test(
        'when filtering by status then totalCount counts only matches',
        () async {
          final page = await endpoints.customer.listPage(
            authenticatedSession,
            status: CustomerStatus.active,
            limit: 4,
            offset: 1,
            businessId: businessId,
          );

          expect(page.totalCount, customerCount - 2); // 2 of 7 are archived
          expect(page.items.length, 4);
          expect(page.offset, 1);
          expect(page.limit, 4);
          expect(
            page.items.every((c) => c.status == CustomerStatus.active),
            isTrue,
          );
        },
      );

      test(
        'when requesting more than available then only existing rows are returned',
        () async {
          final page = await endpoints.customer.listPage(
            authenticatedSession,
            limit: 100,
            offset: 5,
            businessId: businessId,
          );

          expect(page.totalCount, customerCount);
          expect(page.items.length, customerCount - 5);
        },
      );
    });

    group('tenant isolation', () {
      test(
        "when B lists invoices then A's are not counted or returned",
        () async {
          final page = await endpoints.invoice.listPage(
            otherSession,
            businessId: otherBusinessId,
          );

          expect(page.totalCount, 1);
          expect(page.items.single.number, 'PAGE-B-000');
        },
      );

      test(
        'when a membership-less tenant id is passed then it is rejected',
        () async {
          await expectLater(
            () => endpoints.invoice.listPage(
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
