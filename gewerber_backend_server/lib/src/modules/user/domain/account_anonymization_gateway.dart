import 'package:serverpod/serverpod.dart';

/// Severs personal references to a user in business data that must be kept
/// (GoBD retention: businesses, invoices, customers, documents, audit trail).
///
/// GDPR Art. 17 requires that the *personal links* are removed while the
/// business records themselves stay intact. Implementations must run inside
/// the caller's transaction so the anonymization is atomic with the deletion.
abstract interface class AccountAnonymizationGateway {
  /// Nulls out every reference to [userId]:
  /// - `membership.userId`
  /// - `document.uploadedById`
  /// - `audit_entry.userId`
  /// - `user_guidance_progress.userId`
  Future<void> severPersonalLinks(
    Session session,
    UuidValue userId, {
    required Transaction transaction,
  });
}
