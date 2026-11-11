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
    for (final (candidate, verified) in <(String?, bool)>[
      (emailAccount?.email, true),
      (google?.email, true),
      (apple?.email, apple?.isEmailVerified ?? false),
      (microsoft?.email, true),
      (facebook?.email, false),
    ]) {
      final email = _present(candidate);
      if (email != null) {
        primaryEmail = email;
        emailVerified = verified;
        break;
      }
    }

    return AuthIdentity(
      primaryEmail: primaryEmail,
      emailVerified: emailVerified,
      // Declaration order of `AuthProvider`, independent of the lookups above.
      providers: [
        if (google != null) AuthProvider.google,
        if (apple != null) AuthProvider.apple,
        if (facebook != null) AuthProvider.facebook,
        if (microsoft != null) AuthProvider.microsoft,
      ],
    );
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
