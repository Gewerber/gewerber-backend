@TestOn('vm')
@Tags(['integration'])
library;

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as core;
import 'package:serverpod_auth_idp_server/providers/email.dart' as idp;
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Admin API authorization and workflows:
/// - users without an `admin_user` row are rejected (Forbidden),
/// - moderators may read but not mutate,
/// - admins ban/unban users, change membership roles (last owner protected)
///   and cancel invoices, every mutation audited,
/// - destructive mutations require an explicit `confirm: true`,
/// - email verification checks are read-only and audited as such,
/// - listings paginate with keyset cursors capped at 200 rows per page.
void main() {
  // Fixed identifiers so sessions can be built with matching auth overrides.
  const adminId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const moderatorId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';
  const plainUserId = 'c3d4e5f6-a7b8-4c9d-8e0f-1a2b3c4d5e6f';
  const targetUserId = 'd4e5f6a7-b8c9-4d0e-9f1a-2b3c4d5e6f7a';
  const extraUserId = 'e5f6a7b8-c9d0-4e1f-a2b3-c4d5e6f7a8b9';

  late Session rawSession;

  setUpAll(() async {
    await configureDependencies();
  });

  /// Inserts the auth/profile rows backing a user id used in session
  /// overrides. Email accounts are required by the directory search.
  /// Returns the parsed user id.
  Future<UuidValue> seedUser(
    Session session,
    String userId, {
    String? email,
    bool blocked = false,
  }) async {
    final id = UuidValue.fromString(userId);
    await core.AuthUser.db.insertRow(
      session,
      core.AuthUser(id: id, scopeNames: {}, blocked: blocked),
    );
    if (email != null) {
      await idp.EmailAccount.db.insertRow(
        session,
        idp.EmailAccount(
          authUserId: id,
          email: email,
          passwordHash: '',
        ),
      );
      await UserProfile.db.insertRow(
        session,
        UserProfile(userId: id, displayName: email.split('@').first),
      );
    }
    return id;
  }

  Future<Business> seedBusiness(
    Session session,
    String name, {
    required UuidValue ownerId,
  }) async {
    final business = await Business.db.insertRow(session, Business(name: name));
    await Membership.db.insertRow(
      session,
      Membership(
        userId: ownerId,
        businessId: business.id!,
        role: MembershipRole.owner,
      ),
    );
    return business;
  }

  withServerpod('Given AdminEndpoint', (sessionBuilder, endpoints) {
    late TestSessionBuilder adminSession;
    late TestSessionBuilder moderatorSession;
    late TestSessionBuilder noRoleSession;

    setUp(() async {
      rawSession = sessionBuilder.build();

      // Seed roles directly through their models (no SQL, no endpoint).
      for (final entry in {
        UuidValue.fromString(adminId): AdminRole.admin,
        UuidValue.fromString(moderatorId): AdminRole.moderator,
      }.entries) {
        await AdminUser.db.insertRow(
          rawSession,
          AdminUser(userId: entry.key, role: entry.value),
        );
      }
      // Auth identities for the admins themselves.
      await seedUser(rawSession, adminId);
      await seedUser(rawSession, moderatorId);

      adminSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(adminId, {}),
      );
      moderatorSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          moderatorId,
          {},
        ),
      );
      noRoleSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          plainUserId,
          {},
        ),
      );
    });

    group('authorization', () {
      test(
        'when a user without any role reads then Forbidden is thrown',
        () async {
          await expectLater(
            () => endpoints.adminStats.statsOverview(noRoleSession),
            throwsA(isA<ForbiddenException>()),
          );
        },
      );

      test(
        'when a user without any role writes then Forbidden is thrown',
        () async {
          await expectLater(
            () => endpoints.adminUsers.usersBan(
              noRoleSession,
              userId: UuidValue.fromString(targetUserId),
              reason: 'test',
              confirm: true,
            ),
            throwsA(isA<ForbiddenException>()),
          );
        },
      );

      test('when a moderator reads then the call succeeds', () async {
        final stats = await endpoints.adminStats.statsOverview(
          moderatorSession,
        );
        expect(stats.usersTotal, greaterThanOrEqualTo(2));
      });

      test('when a moderator writes then Forbidden is thrown', () async {
        await expectLater(
          () => endpoints.adminUsers.usersBan(
            moderatorSession,
            userId: UuidValue.fromString(targetUserId),
            reason: 'not allowed',
            confirm: true,
          ),
          throwsA(isA<ForbiddenException>()),
        );
      });

      test(
        'when an unauthenticated session reads then the call is rejected',
        () async {
          final unauthenticated = sessionBuilder.copyWith(
            authentication: AuthenticationOverride.unauthenticated(),
          );
          await expectLater(
            () => endpoints.adminStats.statsOverview(unauthenticated),
            throwsA(isA<ServerpodUnauthenticatedException>()),
          );
        },
      );
    });

    group('confirm guard', () {
      test(
        'when confirm is false then ValidationException is thrown',
        () async {
          final target = await seedUser(rawSession, targetUserId);
          await expectLater(
            () => endpoints.adminUsers.usersBan(
              adminSession,
              userId: target,
              reason: 'forgot confirm',
              confirm: false,
            ),
            throwsA(isA<ValidationException>()),
          );
          final state = await core.AuthUser.db.findById(rawSession, target);
          expect(state?.blocked, false);
        },
      );
    });

    group('email verification check', () {
      test(
        'when checking a registered user then the status is confirmed and '
        'the check is audited',
        () async {
          final target = await seedUser(
            rawSession,
            targetUserId,
            email: 'verified@example.com',
          );

          final status = await endpoints.adminUsers.usersVerifyEmail(
            adminSession,
            userId: target,
          );

          expect(status.emailConfirmed, true);
          expect(status.email, 'verified@example.com');

          final logged = await AuditEntry.db.find(
            rawSession,
            where: (t) => t.action.equals('admin.verifyEmailCheck'),
          );
          expect(logged, hasLength(1));
          expect(logged.single.changes?['email'], 'verified@example.com');
        },
      );

      test(
        'when the user has no email account then NotFound is thrown',
        () async {
          // Auth user exists but never completed an email registration.
          final target = await seedUser(rawSession, targetUserId);

          await expectLater(
            () => endpoints.adminUsers.usersVerifyEmail(
              adminSession,
              userId: target,
            ),
            throwsA(isA<NotFoundException>()),
          );
        },
      );

      test(
        'when the auth user does not exist at all then NotFound is thrown',
        () async {
          await expectLater(
            () => endpoints.adminUsers.usersVerifyEmail(
              adminSession,
              userId: UuidValue.fromString(targetUserId),
            ),
            throwsA(isA<NotFoundException>()),
          );
        },
      );
    });

    group('ban / unban workflow', () {
      test(
        'when banning a user then dossier shows blocked and audit exists',
        () async {
          final target = await seedUser(rawSession, targetUserId);

          final dossier = await endpoints.adminUsers.usersBan(
            adminSession,
            userId: target,
            reason: 'chargeback abuse',
            confirm: true,
          );

          expect(dossier.authStatus.blocked, true);

          final stored = await core.AuthUser.db.findById(rawSession, target);
          expect(stored?.blocked, true);
          // Refresh tokens are gone immediately.
          final tokens = await core.RefreshToken.db.find(
            rawSession,
            where: (t) => t.authUserId.equals(target),
          );
          expect(tokens, isEmpty);

          final unblocked = await endpoints.adminUsers.usersUnban(
            adminSession,
            userId: target,
            confirm: true,
          );
          expect(unblocked.authStatus.blocked, false);

          final actions = await AuditEntry.db.find(
            rawSession,
            where: (t) =>
                t.action.equals('admin.userBan') |
                t.action.equals('admin.userUnban'),
          );
          expect(actions.map((e) => e.action).toSet(), {
            'admin.userBan',
            'admin.userUnban',
          });
        },
      );

      test('when banning yourself then Conflict is thrown', () async {
        await expectLater(
          () => endpoints.adminUsers.usersBan(
            adminSession,
            userId: UuidValue.fromString(adminId),
            reason: 'self',
            confirm: true,
          ),
          throwsA(isA<ConflictException>()),
        );
      });

      test('when getting an unknown user then NotFound is thrown', () async {
        await expectLater(
          () => endpoints.adminUsers.usersGet(
            adminSession,
            UuidValue.fromString(targetUserId),
          ),
          throwsA(isA<NotFoundException>()),
        );
      });

      test(
        'when searching users by email substring then matches are returned',
        () async {
          await seedUser(rawSession, targetUserId, email: 'findme@example.com');

          final page = await endpoints.adminUsers.usersSearch(
            adminSession,
            query: 'findme',
          );

          expect(page.items, hasLength(1));
          expect(page.items.single.email, 'findme@example.com');
          expect(page.nextCursor, isNull);
        },
      );
    });

    group('pagination', () {
      test(
        'when the cursor is malformed then ValidationException is thrown',
        () async {
          await expectLater(
            () => endpoints.adminUsers.usersSearch(
              adminSession,
              cursor: '!!!not-a-cursor!!!',
            ),
            throwsA(isA<ValidationException>()),
          );
        },
      );

      test(
        'when paging through usersSearch then the cursor roundtrips',
        () async {
          await seedUser(rawSession, targetUserId, email: 'page-a@example.com');
          await seedUser(rawSession, plainUserId, email: 'page-b@example.com');
          await seedUser(rawSession, extraUserId, email: 'page-c@example.com');

          final first = await endpoints.adminUsers.usersSearch(
            adminSession,
            query: 'page-',
            limit: 2,
          );
          expect(first.items.map((u) => u.email).toList(), [
            'page-a@example.com',
            'page-b@example.com',
          ]);
          expect(first.nextCursor, isNotNull);

          final second = await endpoints.adminUsers.usersSearch(
            adminSession,
            query: 'page-',
            limit: 2,
            cursor: first.nextCursor,
          );
          expect(second.items.map((u) => u.email).toList(), [
            'page-c@example.com',
          ]);
          expect(second.nextCursor, isNull);
        },
      );

      test('when limit exceeds 200 then it is capped to 200', () async {
        await seedUser(rawSession, targetUserId, email: 'capped@example.com');

        final page = await endpoints.adminUsers.usersSearch(
          adminSession,
          limit: 100000,
        );

        expect(page.limit, 200);
      });
    });

    group('membership roles', () {
      test('when demoting the last owner then Conflict is thrown', () async {
        final owner = UuidValue.fromString(targetUserId);
        await seedUser(rawSession, targetUserId);
        final business = await seedBusiness(
          rawSession,
          'Solo Gewerbe',
          ownerId: owner,
        );

        final detail = await endpoints.adminBusinesses.businessesGet(
          adminSession,
          business.id!,
        );
        final ownerMembership = detail.memberships.single.membership;
        expect(ownerMembership.role, MembershipRole.owner);

        await expectLater(
          () => endpoints.adminBusinesses.membershipsSetRole(
            adminSession,
            membershipId: ownerMembership.id!,
            role: MembershipRole.member,
            confirm: true,
          ),
          throwsA(isA<ConflictException>()),
        );
      });

      test('when a second owner exists then demotion succeeds', () async {
        final firstOwner = UuidValue.fromString(targetUserId);
        await seedUser(rawSession, targetUserId);
        final business = await seedBusiness(
          rawSession,
          'Team Gewerbe',
          ownerId: firstOwner,
        );
        await Membership.db.insertRow(
          rawSession,
          Membership(
            userId: UuidValue.fromString(adminId),
            businessId: business.id!,
            role: MembershipRole.owner,
          ),
        );

        final detail = await endpoints.adminBusinesses.businessesGet(
          adminSession,
          business.id!,
        );
        final firstMembership = detail.memberships
            .map((m) => m.membership)
            .firstWhere((m) => m.userId == firstOwner);

        final updated = await endpoints.adminBusinesses.membershipsSetRole(
          adminSession,
          membershipId: firstMembership.id!,
          role: MembershipRole.member,
          confirm: true,
        );

        expect(updated.role, MembershipRole.member);

        final logged = await AuditEntry.db.find(
          rawSession,
          where: (t) => t.action.equals('admin.membershipSetRole'),
        );
        expect(logged, hasLength(1));
        expect(logged.single.changes?['from'], 'owner');
        expect(logged.single.changes?['to'], 'member');
      });
    });

    group('invoice administration', () {
      late int invoiceId;

      setUp(() async {
        final business = await seedBusiness(
          rawSession,
          'Rechnungs Gewerbe',
          ownerId: UuidValue.fromString(targetUserId),
        );
        final invoice = await Invoice.db.insertRow(
          rawSession,
          Invoice(
            businessId: business.id!,
            number: 'ADM-0001',
            status: InvoiceStatus.sent,
            issueDate: DateTime.utc(2026, 8, 1),
            dueDate: DateTime.utc(2026, 8, 15),
          ),
        );
        invoiceId = invoice.id!;
      });

      test(
        'when listing invoices across tenants then the invoice is found',
        () async {
          final page = await endpoints.adminInvoices.invoicesList(
            moderatorSession,
            status: InvoiceStatus.sent,
          );
          expect(page.items.map((i) => i.id), contains(invoiceId));
        },
      );

      test(
        'when cancelling a sent invoice then status changes to cancelled',
        () async {
          final updated = await endpoints.adminInvoices.invoiceCancelAdmin(
            adminSession,
            invoiceId: invoiceId,
            reason: 'duplicate',
            confirm: true,
          );
          expect(updated.status, InvoiceStatus.cancelled);
        },
      );

      test('when cancelling a paid invoice then Conflict is thrown', () async {
        final invoice = await Invoice.db.findById(rawSession, invoiceId);
        invoice!.status = InvoiceStatus.paid;
        await Invoice.db.updateRow(rawSession, invoice);

        await expectLater(
          () => endpoints.adminInvoices.invoiceCancelAdmin(
            adminSession,
            invoiceId: invoiceId,
            reason: 'too late',
            confirm: true,
          ),
          throwsA(isA<ConflictException>()),
        );
      });

      test(
        'when cancelling a draft invoice then Conflict is thrown',
        () async {
          // Drafts are owned and deleted by their tenant, not by admins.
          await Invoice.db.updateRow(
            rawSession,
            (await Invoice.db.findById(rawSession, invoiceId))!
              ..status = InvoiceStatus.draft,
          );

          await expectLater(
            () => endpoints.adminInvoices.invoiceCancelAdmin(
              adminSession,
              invoiceId: invoiceId,
              reason: 'not sent yet',
              confirm: true,
            ),
            throwsA(isA<ConflictException>()),
          );
        },
      );
    });

    group('guidance tips', () {
      test(
        'when upserting a tip override then it appears in the merged list',
        () async {
          final before = await endpoints.adminGuidance.guidanceTipsList(
            moderatorSession,
          );
          expect(before, isNotEmpty);

          final saved = await endpoints.adminGuidance.guidanceTipUpsert(
            adminSession,
            topic: 'invoicing.kleinunternehmer',
            title: 'Überarbeiteter Hinweis',
            body: 'Neuer Text für die Kleinunternehmerregelung.',
            confirm: true,
          );
          expect(saved.title, 'Überarbeiteter Hinweis');

          final after = await endpoints.adminGuidance.guidanceTipsList(
            moderatorSession,
          );
          final overridden = after.firstWhere(
            (t) => t.topic == 'invoicing.kleinunternehmer',
          );
          expect(overridden.title, 'Überarbeiteter Hinweis');
        },
      );

      test(
        'when a moderator tries to upsert then Forbidden is thrown',
        () async {
          await expectLater(
            () => endpoints.adminGuidance.guidanceTipUpsert(
              moderatorSession,
              topic: 'x.y',
              title: 'T',
              body: 'B',
              confirm: true,
            ),
            throwsA(isA<ForbiddenException>()),
          );
        },
      );
    });

    group('audit query', () {
      test('when mutations happened then they are queryable', () async {
        // Each withServerpod test rolls back, so the mutation and the query
        // must happen in the same test.
        final target = await seedUser(rawSession, targetUserId);
        await endpoints.adminUsers.usersUnban(
          adminSession,
          userId: target,
          confirm: true,
        );

        final byAction = await endpoints.adminAudit.auditQuery(
          moderatorSession,
          action: 'admin.userUnban',
        );
        expect(byAction.items, hasLength(1));
        expect(byAction.items.single.entityType, 'AuthUser');
        // The mutation was performed by the seeded admin.
        expect(
          byAction.items.single.userId,
          UuidValue.fromString(adminId),
        );

        final byActor = await endpoints.adminAudit.auditQuery(
          moderatorSession,
          actorUserId: UuidValue.fromString(adminId),
          limit: 5,
        );
        expect(
          byActor.items.map((e) => e.action),
          everyElement('admin.userUnban'),
        );
      });

      test(
        'when no filter is given then recent entries are returned',
        () async {
          final target = await seedUser(rawSession, targetUserId);
          await endpoints.adminUsers.usersBan(
            adminSession,
            userId: target,
            reason: 'audit trail',
            confirm: true,
          );

          final all = await endpoints.adminAudit.auditQuery(moderatorSession);
          expect(all.items, isNotEmpty);
          expect(all.limit, 50);
        },
      );

      test(
        'when since is in the future then no entries are returned',
        () async {
          final target = await seedUser(rawSession, targetUserId);
          await endpoints.adminUsers.usersBan(
            adminSession,
            userId: target,
            reason: 'since filter',
            confirm: true,
          );

          final afterAll = await endpoints.adminAudit.auditQuery(
            moderatorSession,
            action: 'admin.userBan',
            since: DateTime.now().toUtc().subtract(const Duration(hours: 1)),
          );
          expect(afterAll.items, hasLength(1));

          final future = await endpoints.adminAudit.auditQuery(
            moderatorSession,
            action: 'admin.userBan',
            since: DateTime.now().toUtc().add(const Duration(hours: 1)),
          );
          expect(future.items, isEmpty);
        },
      );
    });
  });
}
