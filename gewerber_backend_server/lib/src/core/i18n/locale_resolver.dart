import '../../generated/protocol.dart';
import 'message_catalog.dart';

/// Decides which [Locale] a given rendered surface should use.
///
/// Deliberately a set of **pure static functions** over nullable inputs rather
/// than a service with state or DI: precedence is a policy question, and
/// encoding it as total functions makes every branch directly unit-testable
/// without a database, a session, or a `getIt` registration. There is no
/// request-scoped mutable state to thread, and no way for a caller to forget
/// the fallback — the signature forces it.
///
/// ## Precedence rationale
///
/// A locale is a property of the *reader*, but some surfaces are legal
/// documents whose wording is fixed when they are issued. The rules differ
/// because of that:
///
///  - **Documents** (invoice PDF, ZUGFeRD, XRechnung) use the locale snapshotted
///    on the record at issue time. Re-rendering a document must never change
///    its language because the user later switched their profile, or because
///    the business was reconfigured — the same bytes must come back for the
///    same stored state. Hence `invoice.locale` first, with `business.locale`
///    only as the historical fallback for records written before an invoice
///    locale was captured.
///  - **Business correspondence** (payment reminders) uses `business.locale`:
///    the recipient of a dunning email is the business, and it may be configured
///    differently from the individual user who triggered the send.
///  - **Everything the signed-in user reads on their own screen** (validation
///    and conflict errors, guidance content) uses `userProfile.locale` first,
///    because that is a personal UI preference with no legal content attached.
///
/// Passing `null` for every input yields [fallbackLocale], so an unconfigured
/// request renders exactly as it did before issue #57.
abstract final class LocaleResolver {
  /// Locale for an issued invoice document (PDF, ZUGFeRD, XRechnung).
  ///
  /// [invoice] and [business] are nullable so a partially-loaded record — or
  /// one created without an explicit locale — degrades instead of throwing.
  static Locale forInvoice({Locale? invoice, Locale? business}) =>
      invoice ?? business ?? fallbackLocale;

  /// Locale for correspondence sent on behalf of a business, such as a payment
  /// reminder e-mail.
  static Locale forBusinessCorrespondence({Locale? business, Locale? user}) =>
      business ?? user ?? fallbackLocale;

  /// Locale for a signed-in user's own UI text: errors, guidance, tooltips.
  ///
  /// [business] is the fallback for callers that already hold a business but
  /// have not loaded the profile, which keeps the common in-request path cheap
  /// (no extra query) while still honouring the personal preference whenever
  /// the profile is available.
  static Locale forUserInterface({Locale? userProfile, Locale? business}) =>
      userProfile ?? business ?? fallbackLocale;

  /// Locale for the global admin surface, driven by `gewerber-mcp` and the
  /// admin tooling rather than by a business.
  static Locale forAdminSurface({Locale? userProfile}) =>
      userProfile ?? fallbackLocale;

  /// Locale for transactional auth e-mails (address verification, password
  /// reset).
  ///
  /// These fire while the account is being created, so there is no business and
  /// usually no persisted profile to read a preference from; [requested] lets a
  /// caller pass one explicitly when it has one in hand. Without it the mail
  /// falls back to [fallbackLocale].
  ///
  /// Follow-up: `CreateEmailRegistrationRequest` carries no locale, so a user
  /// who picks a language at sign-up cannot yet receive mail in it. Threading a
  /// locale through the auth request is the natural fix and is out of scope for
  /// the i18n foundation.
  static Locale forAuthEmail({Locale? requested}) =>
      requested ?? fallbackLocale;
}
