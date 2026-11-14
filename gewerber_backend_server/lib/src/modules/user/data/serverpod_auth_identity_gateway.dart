import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/providers/apple.dart'
    show AppleAccount;
import 'package:serverpod_auth_idp_server/providers/email.dart'
    show EmailAccount;
import 'package:serverpod_auth_idp_server/providers/facebook.dart'
    show FacebookAccount;
import 'package:serverpod_auth_idp_server/providers/google.dart'
    show GoogleAccount;
import 'package:serverpod_auth_idp_server/providers/microsoft.dart'
    show MicrosoftAccount;

import '../../../generated/protocol.dart';
import '../domain/auth_identity_gateway.dart';

/// [AuthIdentityGateway] on top of the `serverpod_auth_idp` provider tables.
///
/// Account linking does not exist yet, so there is no join between providers:
/// every row is looked up for the one auth user whose token the caller sent.
@Singleton(as: AuthIdentityGateway)
class ServerpodAuthIdentityGateway implements AuthIdentityGateway {
  @override
  Future<AuthIdentity> resolve(Session session, UuidValue userId) async {
    final emailAccount = await EmailAccount.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
    );
    final google = await GoogleAccount.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
    );
    final apple = await AppleAccount.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
    );
    final microsoft = await MicrosoftAccount.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
    );
    final facebook = await FacebookAccount.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(userId),
    );

    // Displayed address precedence: email, Google, Apple, Microsoft, Facebook.
    //
    // Verification semantics per source:
    // - email: an `EmailAccount` row only exists after the registration
    //   challenge was completed with the code sent to that address, so it is
    //   confirmed by construction (`createEmailAuthentication` is the only
    //   path that bypasses the challenge, and it is reserved for trusted
    //   callers).
    // - Google/Microsoft: both models document their `email` as the address as
    //   verified by the provider.
    // - Apple: the model exposes `isEmailVerified` explicitly; null means the
    //   claim was not returned, which cannot be counted as verified.
    // - Facebook: returns the profile address without confirming ownership.
    String? primaryEmail;
    var emailVerified = false;
    AuthProvider? primaryEmailProvider;
    for (final (candidate, verified, provider)
        in <(String?, bool, AuthProvider?)>[
          (emailAccount?.email, true, null),
          (google?.email, true, AuthProvider.google),
          (apple?.email, apple?.isEmailVerified ?? false, AuthProvider.apple),
          (microsoft?.email, true, AuthProvider.microsoft),
          (facebook?.email, false, AuthProvider.facebook),
        ]) {
      final email = _present(candidate);
      if (email != null) {
        primaryEmail = email;
        emailVerified = verified;
        primaryEmailProvider = provider;
        break;
      }
    }

    return AuthIdentity(
      primaryEmail: primaryEmail,
      emailVerified: emailVerified,
      primaryEmailProvider: primaryEmailProvider,
      // Declaration order of `AuthProvider`, independent of the lookups above.
      providers: [
        if (google != null) AuthProvider.google,
        if (apple != null) AuthProvider.apple,
        if (facebook != null) AuthProvider.facebook,
        if (microsoft != null) AuthProvider.microsoft,
      ],
    );
  }

  @override
  Future<List<IdentityEmailRow>> findEmails(
    Session session, {
    String? query,
    String? afterEmail,
    String? afterUserId,
    required int limit,
  }) async {
    if (limit <= 0) return const [];
    final normalized = query?.trim() ?? '';
    final afterUuid = afterUserId == null ? null : _parseUuid(afterUserId);

    final rows = <IdentityEmailRow>[];

    // One query per identity table, each clamped to `limit` **and** filtered by
    // the same `(email, authUserId)` keyset boundary (`_directoryFilter`). The
    // boundary is what makes the clamp safe: the top `limit` rows of the union
    // are contained in the union of the per-table top `limit`, so no row that
    // belongs on this page can be trimmed away. Merging, dedupe and ordering
    // happen in Dart below — see the contract on the interface.
    final emailAccounts = await EmailAccount.db.find(
      session,
      where: (t) => _directoryFilter(
        email: t.email,
        authUserId: t.authUserId,
        query: normalized,
        afterEmail: afterEmail,
        afterUserId: afterUuid,
      ),
      orderByList: (t) => [t.email, t.authUserId],
      limit: limit,
    );
    for (final account in emailAccounts) {
      _addRow(
        rows,
        authUserId: account.authUserId,
        email: account.email,
        provider: null,
        emailVerified: true,
      );
    }

    final googleAccounts = await GoogleAccount.db.find(
      session,
      where: (t) => _directoryFilter(
        email: t.email,
        authUserId: t.authUserId,
        query: normalized,
        afterEmail: afterEmail,
        afterUserId: afterUuid,
      ),
      orderByList: (t) => [t.email, t.authUserId],
      limit: limit,
    );
    for (final account in googleAccounts) {
      _addRow(
        rows,
        authUserId: account.authUserId,
        email: account.email,
        provider: AuthProvider.google,
        emailVerified: true,
      );
    }

    final appleAccounts = await AppleAccount.db.find(
      session,
      where: (t) => _directoryFilter(
        email: t.email,
        authUserId: t.authUserId,
        query: normalized,
        afterEmail: afterEmail,
        afterUserId: afterUuid,
      ),
      orderByList: (t) => [t.email, t.authUserId],
      limit: limit,
    );
    for (final account in appleAccounts) {
      _addRow(
        rows,
        authUserId: account.authUserId,
        email: account.email,
        provider: AuthProvider.apple,
        emailVerified: account.isEmailVerified ?? false,
      );
    }

    final microsoftAccounts = await MicrosoftAccount.db.find(
      session,
      where: (t) => _directoryFilter(
        email: t.email,
        authUserId: t.authUserId,
        query: normalized,
        afterEmail: afterEmail,
        afterUserId: afterUuid,
      ),
      orderByList: (t) => [t.email, t.authUserId],
      limit: limit,
    );
    for (final account in microsoftAccounts) {
      _addRow(
        rows,
        authUserId: account.authUserId,
        email: account.email,
        provider: AuthProvider.microsoft,
        emailVerified: true,
      );
    }

    final facebookAccounts = await FacebookAccount.db.find(
      session,
      where: (t) => _directoryFilter(
        email: t.email,
        authUserId: t.authUserId,
        query: normalized,
        afterEmail: afterEmail,
        afterUserId: afterUuid,
      ),
      orderByList: (t) => [t.email, t.authUserId],
      limit: limit,
    );
    for (final account in facebookAccounts) {
      _addRow(
        rows,
        authUserId: account.authUserId,
        email: account.email,
        provider: AuthProvider.facebook,
        emailVerified: false,
      );
    }

    rows.sort(_compareRows);
    return rows;
  }

  /// Keyset predicate shared by all five identity tables.
  ///
  /// Every per-table query in [findEmails] applies this same boundary, so the
  /// per-table `limit` clamp trims a *suffix* of each provider's ordering
  /// rather than re-reading its leading rows on every page. The predicate is
  /// the exact `(email, authUserId)` keyset of the Dart merge:
  ///
  /// - no cursor: no boundary at all,
  /// - cursor without [afterUserId] (legacy): `email > afterEmail`,
  /// - cursor with both keys: `email > afterEmail` OR
  ///   (`email = afterEmail` AND `authUserId > afterUserId`).
  ///
  /// `Expression`'s `&` / `|` combinators express that disjunction inline, so
  /// no extra per-table equality query is needed. Each comparison uses the
  /// column's own collation, which is also what the per-table `ORDER BY`
  /// uses, so boundary and ordering can never disagree within a table. The
  /// Dart merge re-sorts case-insensitively for display.
  static Expression _directoryFilter({
    required ColumnString email,
    required ColumnUuid authUserId,
    required String query,
    required String? afterEmail,
    required UuidValue? afterUserId,
  }) {
    var expression = Constant.bool(true) as Expression;
    if (query.isNotEmpty) {
      expression &= email.ilike('%$query%');
    }
    if (afterEmail != null) {
      final strictlyAfter = email > afterEmail;
      expression &= afterUserId == null
          ? strictlyAfter
          : strictlyAfter |
                (email.equals(afterEmail) & (authUserId > afterUserId));
    }
    return expression;
  }

  /// Keeps at most one row per `(authUserId, provider)` and drops rows without
  /// a usable address.
  static void _addRow(
    List<IdentityEmailRow> rows, {
    required UuidValue authUserId,
    required String? email,
    required AuthProvider? provider,
    required bool emailVerified,
  }) {
    final present = _present(email);
    if (present == null) return;
    final duplicate = rows.any(
      (row) => row.authUserId == authUserId && row.provider == provider,
    );
    if (duplicate) return;
    rows.add(
      IdentityEmailRow(
        authUserId: authUserId,
        email: present,
        provider: provider,
        emailVerified: emailVerified,
      ),
    );
  }

  /// Deterministic `(email, userId)` order; addresses are compared
  /// case-insensitively because search is case-insensitive too.
  static int _compareRows(IdentityEmailRow a, IdentityEmailRow b) {
    final byEmail = a.email.toLowerCase().compareTo(b.email.toLowerCase());
    if (byEmail != 0) return byEmail;
    return a.authUserId.toString().compareTo(b.authUserId.toString());
  }

  static UuidValue _parseUuid(String value) {
    try {
      return UuidValue.withFormatValidation(value);
    } on FormatException {
      throw ValidationException(
        message: 'Malformed pagination cursor.',
        field: 'cursor',
      );
    }
  }

  /// Treats blank and whitespace-only addresses as absent.
  static String? _present(String? email) {
    final trimmed = email?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}
