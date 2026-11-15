@Tags(['integration'])
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:gewerber_backend_server/src/core/di/injection.dart';
import 'package:gewerber_backend_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as core;
import 'package:serverpod_auth_idp_server/providers/apple.dart'
    show AppleAccount;
import 'package:serverpod_auth_idp_server/providers/email.dart' as idp;
import 'package:serverpod_auth_idp_server/providers/facebook.dart'
    show FacebookAccount;
import 'package:serverpod_auth_idp_server/providers/google.dart'
    show GoogleAccount;
import 'package:serverpod_auth_idp_server/providers/microsoft.dart'
    show MicrosoftAccount;
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  const userAId = 'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c5d';
  const userBId = 'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d6e';
  // A user that never created a profile, business or any other data.
  const userCId = 'c3d4e5f6-a7b8-4c9d-8e1f-2a3b4c5d6e7f';
  // A user with an email identity, a Google identity and a refresh token, used
  // to prove the auth identities are purged with the account.
  const identitiesUserId = 'd5e6f7a8-b9c0-4d1e-8f2a-3b4c5d6e7f80';

  setUpAll(() async {
    await configureDependencies();
  });

  withServerpod('Given two accounts with business data', (
    sessionBuilder,
    endpoints,
  ) {
    late TestSessionBuilder sessionA;
    late TestSessionBuilder sessionB;
    late TestSessionBuilder sessionC;
    late int businessAId;
    late int businessBId;
    late int customerIdA;
    late int invoiceIdA;
    late int documentIdA;
    late int documentBId;

    setUp(() async {
      TestSessionBuilder authenticated(String userId) =>
          sessionBuilder.copyWith(
            authentication: AuthenticationOverride.authenticationInfo(
              userId,
              {},
            ),
          );
      sessionA = authenticated(userAId);
      sessionB = authenticated(userBId);
      sessionC = authenticated(userCId);

      // Account A: profile, membership, customer, invoice, document,
      // guidance progress and audit entries (written by the use cases).
      final businessA = await endpoints.business.create(
        sessionA,
        CreateBusinessRequest(name: 'Gewerbe A'),
      );
      businessAId = businessA.id!;
      await endpoints.userProfile.getMyProfile(sessionA);

      final customerA = await endpoints.customer.create(
        sessionA,
        CreateCustomerRequest(name: 'Kunde A'),
        businessId: businessAId,
      );
      customerIdA = customerA.id!;

      final invoiceA = await endpoints.invoice.create(
        sessionA,
        CreateInvoiceRequest(
          customerId: customerA.id,
          items: [
            InvoiceItemRequest(
              description: 'Arbeit',
              quantity: 2,
              unitPriceCents: 1500,
            ),
          ],
        ),
        businessId: businessAId,
      );
      invoiceIdA = invoiceA.id!;

      final documentA = await endpoints.document.upload(
        sessionA,
        UploadDocumentRequest(
          businessId: businessAId,
          kind: DocumentKind.attachment,
          fileName: 'receipt-a.txt',
          mimeType: 'text/plain',
          data: ByteData.sublistView(utf8.encode('beleg')),
        ),
      );
      documentIdA = documentA.id!;

      await endpoints.guidance.markCompleted(
        sessionA,
        'onboarding/business-profile',
      );

      // Account B: control account that must stay untouched.
      final businessB = await endpoints.business.create(
        sessionB,
        CreateBusinessRequest(name: 'Gewerbe B'),
      );
      businessBId = businessB.id!;
      final documentB = await endpoints.document.upload(
        sessionB,
        UploadDocumentRequest(
          businessId: businessBId,
          kind: DocumentKind.attachment,
          fileName: 'receipt-b.txt',
          mimeType: 'text/plain',
          data: ByteData.sublistView(utf8.encode('beleg b')),
        ),
      );
      documentBId = documentB.id!;
    });

    test(
      'when deleting the account then personal links are severed but business data is kept',
      () async {
        final userId = UuidValue.fromString(userAId);

        await endpoints.userProfile.deleteMyAccount(sessionA);

        final db = sessionBuilder.build();
        try {
          // Deletion marker on the profile.
          final profile = await UserProfile.db.findFirstRow(
            db,
            where: (t) => t.userId.equals(userId),
          );
          expect(profile, isNotNull);
          expect(profile!.deletedAt, isNotNull);

          // Membership row is kept (retention) but no longer points at the user.
          final memberships = await Membership.db.find(
            db,
            where: (t) => t.businessId.equals(businessAId),
          );
          expect(memberships, hasLength(1));
          expect(memberships.single.userId, isNull);
          expect(memberships.single.role, MembershipRole.owner);

          // Document row is kept; the uploader link is severed.
          final document = await Document.db.findById(db, documentIdA);
          expect(document!.fileName, 'receipt-a.txt');
          expect(document.uploadedById, isNull);

          // Audit trail is kept (GoBD) without personal attribution.
          final auditEntries = await AuditEntry.db.find(
            db,
            where: (t) => t.businessId.equals(businessAId),
          );
          expect(auditEntries, isNotEmpty);
          expect(
            auditEntries.every((entry) => entry.userId == null),
            isTrue,
          );

          // Guidance progress is kept anonymous.
          final progressOfUser = await UserGuidanceProgress.db.find(
            db,
            where: (t) => t.userId.equals(userId),
          );
          expect(progressOfUser, isEmpty);
          final severedProgress = await UserGuidanceProgress.db.find(
            db,
            where: (t) =>
                t.userId.equals(null) &
                t.itemKey.equals('onboarding/business-profile'),
          );
          expect(severedProgress, hasLength(1));

          // GoBD retention: business records are intact.
          final business = await Business.db.findById(db, businessAId);
          expect(business!.name, 'Gewerbe A');
          final customer = await Customer.db.findById(db, customerIdA);
          expect(customer!.name, 'Kunde A');
          final invoice = await Invoice.db.findById(db, invoiceIdA);
          expect(invoice, isNotNull);
          final items = await InvoiceItem.db.find(
            db,
            where: (t) => t.invoiceId.equals(invoiceIdA),
          );
          expect(items, hasLength(1));
        } finally {
          await db.close();
        }
      },
    );

    test(
      'when deleting twice then the second call throws NotFoundException',
      () async {
        await endpoints.userProfile.deleteMyAccount(sessionA);

        await expectLater(
          () => endpoints.userProfile.deleteMyAccount(sessionA),
          throwsA(
            isA<NotFoundException>().having(
              (e) => e.entityType,
              'entityType',
              'UserProfile',
            ),
          ),
        );
      },
    );

    test(
      'when using the deleted account then profile and business creation are blocked',
      () async {
        await endpoints.userProfile.deleteMyAccount(sessionA);

        // Repeated logins/endpoints detect the deletion via the marker.
        await expectLater(
          () => endpoints.userProfile.getMyProfile(sessionA),
          throwsA(isA<NotFoundException>()),
        );
        await expectLater(
          () => endpoints.userProfile.update(
            sessionA,
            UpdateUserProfileRequest(
              displayName: 'Zombie',
              locale: Locale.de,
              themeMode: AppTheme.system,
            ),
          ),
          throwsA(isA<NotFoundException>()),
        );

        // The deleted account must not be able to create new business data,
        // including personal data such as guidance progress.
        await expectLater(
          () => endpoints.business.create(
            sessionA,
            CreateBusinessRequest(name: 'Neues Gewerbe'),
          ),
          throwsA(isA<NotFoundException>()),
        );
        await expectLater(
          () => endpoints.guidance.markCompleted(
            sessionA,
            'onboarding/first-invoice',
          ),
          throwsA(isA<NotFoundException>()),
        );
        await expectLater(
          () => endpoints.guidance.dismissTip(
            sessionA,
            'invoicing.kleinunternehmer',
          ),
          throwsA(isA<NotFoundException>()),
        );
      },
    );

    test(
      'when marking guidance progress then writes work until deletion and are rejected afterwards',
      () async {
        const itemKey = 'onboarding/first-invoice';
        const topic = 'invoicing.kleinunternehmer';

        // Before deletion: guidance mutations work as before.
        final completed = await endpoints.guidance.markCompleted(
          sessionA,
          itemKey,
        );
        expect(completed.completedAt, isNotNull);
        final dismissed = await endpoints.guidance.dismissTip(
          sessionA,
          topic,
        );
        expect(dismissed.dismissedAt, isNotNull);

        await endpoints.userProfile.deleteMyAccount(sessionA);

        // After deletion: both mutations hit the tombstone guard.
        await expectLater(
          () => endpoints.guidance.markCompleted(sessionA, itemKey),
          throwsA(
            isA<NotFoundException>().having(
              (e) => e.entityType,
              'entityType',
              'UserProfile',
            ),
          ),
        );
        await expectLater(
          () => endpoints.guidance.dismissTip(sessionA, topic),
          throwsA(isA<NotFoundException>()),
        );

        // The rejected writes must not have re-created personal rows
        // (regression guard for the upsert path).
        final db = sessionBuilder.build();
        try {
          final progressOfUser = await UserGuidanceProgress.db.find(
            db,
            where: (t) => t.userId.equals(UuidValue.fromString(userAId)),
          );
          expect(progressOfUser, isEmpty);
        } finally {
          await db.close();
        }
      },
    );

    test(
      'when deleting one account then other users keep their personal links and access',
      () async {
        await endpoints.userProfile.deleteMyAccount(sessionA);

        final db = sessionBuilder.build();
        try {
          final membershipB = await Membership.db.findFirstRow(
            db,
            where: (t) => t.businessId.equals(businessBId),
          );
          expect(membershipB!.userId, UuidValue.fromString(userBId));

          final documentB = await Document.db.findById(db, documentBId);
          expect(documentB!.uploadedById, UuidValue.fromString(userBId));

          final auditEntriesB = await AuditEntry.db.find(
            db,
            where: (t) => t.businessId.equals(businessBId),
          );
          expect(auditEntriesB, isNotEmpty);
          expect(
            auditEntriesB.every(
              (entry) => entry.userId == UuidValue.fromString(userBId),
            ),
            isTrue,
          );
        } finally {
          await db.close();
        }

        // The other user can still use their account normally.
        final businesses = await endpoints.business.listMine(sessionB);
        expect(businesses.map((b) => b.id), contains(businessBId));
      },
    );

    test(
      'when an account without any data is deleted then a tombstone marker is kept',
      () async {
        // No profile/business was ever created for this user.
        await endpoints.userProfile.deleteMyAccount(sessionC);

        final db = sessionBuilder.build();
        try {
          final tombstone = await UserProfile.db.findFirstRow(
            db,
            where: (t) => t.userId.equals(UuidValue.fromString(userCId)),
          );
          expect(tombstone, isNotNull);
          expect(tombstone!.deletedAt, isNotNull);
        } finally {
          await db.close();
        }

        // Repeating the call reports the account as gone.
        await expectLater(
          () => endpoints.userProfile.deleteMyAccount(sessionC),
          throwsA(isA<NotFoundException>()),
        );
      },
    );

    test('when unauthenticated then deletion is denied', () async {
      final unauthenticated = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.unauthenticated(),
      );

      await expectLater(
        () => endpoints.userProfile.deleteMyAccount(unauthenticated),
        throwsA(isA<ServerpodUnauthenticatedException>()),
      );
    });
  });

  withServerpod('Given an account with auth identities', (
    sessionBuilder,
    endpoints,
  ) {
    test(
      'when deleting the account then every identity row and the refresh token '
      'are purged while the auth user and its tombstone stay',
      () async {
        final userId = UuidValue.fromString(identitiesUserId);
        final session = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            identitiesUserId,
            {},
          ),
        );

        final rawSession = sessionBuilder.build();
        try {
          // The auth user, one email IdP row, a Google row and a refresh
          // token. The remaining provider tables must simply be empty.
          await core.AuthUser.db.insertRow(
            rawSession,
            core.AuthUser(id: userId, scopeNames: {}),
          );
          await idp.EmailAccount.db.insertRow(
            rawSession,
            idp.EmailAccount(
              authUserId: userId,
              email: 'purge-me@example.com',
              passwordHash: '',
            ),
          );
          await GoogleAccount.db.insertRow(
            rawSession,
            GoogleAccount(
              authUserId: userId,
              email: 'purge-me@gmail.example',
              userIdentifier: 'google-sub-purge-me',
            ),
          );
          await core.RefreshToken.db.insertRow(
            rawSession,
            core.RefreshToken(
              authUserId: userId,
              scopeNames: {},
              method: 'email',
              fixedSecret: ByteData(16),
              rotatingSecretHash:
                  '\$argon2id\$v=19\$m=1,t=1,p=1\$c2FsdA==\$aGFzaA==',
            ),
          );
        } finally {
          await rawSession.close();
        }

        await endpoints.userProfile.deleteMyAccount(session);

        final db = sessionBuilder.build();
        try {
          // Every identity row for this auth user is gone.
          final emailAccounts = await idp.EmailAccount.db.find(
            db,
            where: (t) => t.authUserId.equals(userId),
          );
          expect(emailAccounts, isEmpty);
          final googleAccounts = await GoogleAccount.db.find(
            db,
            where: (t) => t.authUserId.equals(userId),
          );
          expect(googleAccounts, isEmpty);
          final appleAccounts = await AppleAccount.db.find(
            db,
            where: (t) => t.authUserId.equals(userId),
          );
          expect(appleAccounts, isEmpty);
          final facebookAccounts = await FacebookAccount.db.find(
            db,
            where: (t) => t.authUserId.equals(userId),
          );
          expect(facebookAccounts, isEmpty);
          final microsoftAccounts = await MicrosoftAccount.db.find(
            db,
            where: (t) => t.authUserId.equals(userId),
          );
          expect(microsoftAccounts, isEmpty);

          // No refresh token survives, so no new access token can be minted.
          final refreshTokens = await core.RefreshToken.db.find(
            db,
            where: (t) => t.authUserId.equals(userId),
          );
          expect(refreshTokens, isEmpty);

          // The auth user row stays: the tombstone and the audit trail depend
          // on it, and `deletedAt` remains enforceable.
          final authUser = await core.AuthUser.db.findById(db, userId);
          expect(authUser, isNotNull);

          final profile = await UserProfile.db.findFirstRow(
            db,
            where: (t) => t.userId.equals(userId),
          );
          expect(profile, isNotNull);
          expect(profile!.deletedAt, isNotNull);
        } finally {
          await db.close();
        }

        // The profile endpoint keeps reporting the account as deleted; `me()`
        // is not tombstone-guarded (pre-existing behavior) but reports no
        // identity and no provider any more, because the rows are gone.
        await expectLater(
          () => endpoints.userProfile.getMyProfile(session),
          throwsA(
            isA<NotFoundException>().having(
              (e) => e.entityType,
              'entityType',
              'UserProfile',
            ),
          ),
        );
        final identity = await endpoints.userProfile.me(session);
        expect(identity.primaryEmail, isNull);
        expect(identity.connectedProviders, isEmpty);
      },
    );
  });
}
