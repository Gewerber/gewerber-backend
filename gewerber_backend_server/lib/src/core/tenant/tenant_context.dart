import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';

/// The authenticated caller's tenant: which user, which business, which role,
/// and which language their own screen text should be rendered in.
class TenantContext {
  const TenantContext({
    required this.userId,
    required this.businessId,
    required this.role,
    required this.locale,
  });

  final UuidValue userId;
  final int businessId;
  final MembershipRole role;

  /// Language for text this user reads on their own screen: validation and
  /// conflict errors, guidance, and other UI copy.
  ///
  /// Resolved once per request by `TenantResolver` from the user's own profile
  /// preference, falling back to the business locale and then to the catalog
  /// fallback locale. Required rather than optional so that a new
  /// construction site has to make a deliberate choice about language instead
  /// of silently inheriting the wrong one — which is exactly how `Locale`
  /// stayed written-but-never-read on the models before issue #57.
  ///
  /// Deliberately *not* the locale for documents: an invoice renders in the
  /// locale stored on the invoice, so re-rendering it cannot change language.
  /// See `LocaleResolver.forInvoice`.
  final Locale locale;

  bool get isAdmin =>
      role == MembershipRole.owner || role == MembershipRole.admin;
}
