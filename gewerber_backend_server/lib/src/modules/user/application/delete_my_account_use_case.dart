import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/session_auth.dart';
import '../../../generated/protocol.dart';
import '../domain/account_anonymization_gateway.dart';
import '../domain/account_deletion.dart';
import '../domain/user_profile_gateway.dart';

/// Soft-deletes the account of the currently authenticated user.
///
/// Semantics (GDPR Art. 17 vs. GoBD retention):
/// - A `deletedAt` marker is set on the user's [UserProfile] (created as a
///   tombstone if the user never had one). Subsequent logins/endpoints detect
///   the deletion via this marker.
/// - All personal links in retained business data are severed in the same
///   transaction (`membership.userId`, `document.uploadedById`,
///   `audit_entry.userId`, `user_guidance_progress.userId` are nulled).
/// - Business records (businesses, invoices, customers, documents, audit
///   trail) are NOT deleted — German tax law (GoBD) requires their retention.
///
/// Repeating the call throws [NotFoundException] — the active account no
/// longer exists.
@singleton
class DeleteMyAccountUseCase {
  DeleteMyAccountUseCase(this._profiles, this._anonymization, this._audit);

  final UserProfileGateway _profiles;
  final AccountAnonymizationGateway _anonymization;
  final AuditService _audit;

  Future<void> call(Session session) async {
    final userId = session.authUserId;
    if (userId == null) {
      throw ForbiddenException(message: 'Not authenticated.');
    }

    await session.db.transaction((transaction) async {
      final existing = await _profiles.findByUserId(
        session,
        userId,
        transaction: transaction,
      );
      if (existing != null && existing.deletedAt != null) {
        throwAccountDeleted(userId);
      }

      final deletedAt = DateTime.now().toUtc();
      if (existing == null) {
        try {
          await _profiles.create(
            session,
            UserProfile(userId: userId, deletedAt: deletedAt),
            transaction: transaction,
          );
        } on DatabaseQueryException catch (e) {
          // 23505 = unique_violation: a concurrent request created the
          // tombstone first — the account is already deleted.
          if (e.code != '23505') rethrow;
          throwAccountDeleted(userId);
        }
      } else {
        await _profiles.update(
          session,
          existing.copyWith(deletedAt: deletedAt),
          transaction: transaction,
        );
      }

      await _anonymization.severPersonalLinks(
        session,
        userId,
        transaction: transaction,
      );
    });

    // Written after commit and without tenant context: the entry itself must
    // not carry a personal link to the deleted account.
    await _audit.log(
      session,
      action: 'account.delete',
      entityType: 'UserProfile',
    );
  }
}
