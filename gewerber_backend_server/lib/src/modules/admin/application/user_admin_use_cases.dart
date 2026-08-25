import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/admin/admin_context.dart';
import '../../../core/audit/audit_service.dart';
import '../../../generated/protocol.dart';
import '../domain/admin_auth_gateway.dart';
import '../domain/admin_directory_gateway.dart';
import '../domain/require_confirm.dart';

/// Bans a user on the authentication level. No user data is deleted —
/// lifting the block with [UnbanUserUseCase] restores access (minus the
/// deleted refresh tokens).
///
/// Residual risk (accepted, see `ServerpodAdminAuthGateway`): block flag,
/// token purge and connection revocation are separate commits — they are not
/// wrapped in one transaction with the audit entry.
@singleton
class BanUserUseCase {
  BanUserUseCase(this._auth, this._directory, this._audit);

  final AdminAuthGateway _auth;
  final AdminDirectoryGateway _directory;
  final AuditService _audit;

  /// Returns the refreshed dossier of the banned user.
  Future<AdminUserDossier> call(
    Session session, {
    required AdminContext actor,
    required UuidValue userId,
    required String reason,
    required bool confirm,
  }) async {
    requireConfirm(confirm);
    if (reason.trim().isEmpty) {
      throw ValidationException(
        message: 'A ban reason is required.',
        field: 'reason',
      );
    }
    if (userId == actor.userId) {
      throw ConflictException(message: 'You cannot ban yourself.');
    }

    await _auth.ban(session, userId);

    final dossier = await _directory.getUserDossier(session, userId);
    await _audit.log(
      session,
      action: 'admin.userBan',
      entityType: 'AuthUser',
      entityId: '$userId',
      changes: {'reason': reason.trim(), 'blocked': 'true'},
      userId: actor.userId,
    );
    return dossier;
  }
}

@singleton
class UnbanUserUseCase {
  UnbanUserUseCase(this._auth, this._directory, this._audit);

  final AdminAuthGateway _auth;
  final AdminDirectoryGateway _directory;
  final AuditService _audit;

  Future<AdminUserDossier> call(
    Session session, {
    required AdminContext actor,
    required UuidValue userId,
    required bool confirm,
  }) async {
    requireConfirm(confirm);

    await _auth.unban(session, userId);

    final dossier = await _directory.getUserDossier(session, userId);
    await _audit.log(
      session,
      action: 'admin.userUnban',
      entityType: 'AuthUser',
      entityId: '$userId',
      changes: {'blocked': 'false'},
      userId: actor.userId,
    );
    return dossier;
  }
}

/// Reports the email verification state of a user.
///
/// With `serverpod_auth_idp` 4.x an `EmailAccount` row only exists after the
/// registration verification code was confirmed — there is no persistent
/// "unverified" flag to flip, so there is nothing to mutate. This use case is
/// therefore a read-only compliance check (audited as such): it verifies that
/// an email account exists and reports its status; it fails with
/// [NotFoundException] for users without any email account. It stays part of
/// the admin surface so the MCP workflow does not depend on IdP internals.
@singleton
class VerifyUserEmailUseCase {
  VerifyUserEmailUseCase(this._auth, this._audit);

  final AdminAuthGateway _auth;
  final AuditService _audit;

  Future<AdminAuthStatus> call(
    Session session, {
    required AdminContext actor,
    required UuidValue userId,
  }) async {
    final state = await _auth.authState(session, userId);
    if (!state.emailConfirmed) {
      throw NotFoundException(entityType: 'EmailAccount', entityId: '$userId');
    }

    // Read-only check — the entry records that the state was inspected, it
    // does not claim a change.
    await _audit.log(
      session,
      action: 'admin.verifyEmailCheck',
      entityType: 'EmailAccount',
      entityId: '$userId',
      changes: {'email': state.email ?? ''},
      userId: actor.userId,
    );

    return AdminAuthStatus(
      blocked: state.blocked,
      emailConfirmed: state.emailConfirmed,
      email: state.email,
      authUserCreatedAt: state.authUserCreatedAt,
    );
  }
}
