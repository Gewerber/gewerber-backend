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
/// The identity is resolved provider-agnostically: the email IdP first, then
/// Google, Apple, Microsoft and Facebook. With `serverpod_auth_idp` 4.x an
/// `EmailAccount` row only exists after the registration verification code was
/// confirmed — there is no persistent "unverified" flag to flip — so this use
/// case remains a read-only compliance check (audited as such).
///
/// It throws [NotFoundException] only when the auth user does not exist or no
/// identity row carries an email address at all. A social user whose provider
/// does not confirm ownership (for example Facebook) is reported with
/// `emailConfirmed: false` and the address populated, not as "not found".
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
    if (state.email == null) {
      throw NotFoundException(
        entityType: 'AuthIdentity',
        entityId: '$userId',
      );
    }

    // Read-only check — the entry records that the state was inspected, it
    // does not claim a change. `provider` names the identity that supplied the
    // address (`email` for the email IdP).
    await _audit.log(
      session,
      action: 'admin.verifyEmailCheck',
      entityType: 'AuthUser',
      entityId: '$userId',
      changes: {
        'email': state.email ?? '',
        'emailConfirmed': '${state.emailConfirmed}',
        'provider': state.emailProvider?.name ?? 'email',
      },
      userId: actor.userId,
    );

    return AdminAuthStatus(
      blocked: state.blocked,
      emailConfirmed: state.emailConfirmed,
      email: state.email,
      authUserCreatedAt: state.authUserCreatedAt,
      providers: state.providers,
    );
  }
}
