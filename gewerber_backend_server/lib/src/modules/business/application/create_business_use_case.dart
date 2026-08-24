import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/session_auth.dart';
import '../../../core/tenant/tenant_context.dart';
import '../../../generated/protocol.dart';
import '../../user/domain/account_deletion.dart';
import '../../user/domain/user_profile_gateway.dart';
import '../domain/business_gateway.dart';
import '../domain/membership_gateway.dart';

@singleton
class CreateBusinessUseCase {
  CreateBusinessUseCase(
    this._businesses,
    this._memberships,
    this._profiles,
    this._audit,
  );

  final BusinessGateway _businesses;
  final MembershipGateway _memberships;
  final UserProfileGateway _profiles;
  final AuditService _audit;

  Future<Business> call(Session session, CreateBusinessRequest request) async {
    final userId = session.authUserId;
    if (userId == null) {
      throw ForbiddenException(message: 'Not authenticated.');
    }
    // A soft-deleted account must not be able to create new business data
    // (GDPR Art. 17 — the personal links would otherwise be re-created).
    final profile = await _profiles.findByUserId(session, userId);
    if (profile != null && profile.deletedAt != null) {
      throwAccountDeleted(userId);
    }
    _validate(request);

    final business = await session.db.transaction((transaction) async {
      final created = await _businesses.create(
        session,
        Business(
          name: request.name.trim(),
          legalForm: request.legalForm,
          isKleinunternehmer: request.isKleinunternehmer,
          vatId: request.vatId,
          taxNumber: request.taxNumber,
          email: request.email,
          phone: request.phone,
          address: request.address,
          locale: request.locale,
          currency: request.currency,
        ),
        transaction: transaction,
      );
      await _memberships.create(
        session,
        Membership(
          userId: userId,
          businessId: created.id!,
          role: MembershipRole.owner,
        ),
        transaction: transaction,
      );

      // Same transaction as the change: business + owner membership + audit
      // entry are all-or-nothing.
      await _audit.log(
        session,
        action: 'business.create',
        entityType: 'Business',
        entityId: '${created.id}',
        tenant: TenantContext(
          userId: userId,
          businessId: created.id!,
          role: MembershipRole.owner,
        ),
        transaction: transaction,
      );
      return created;
    });

    return business;
  }

  void _validate(CreateBusinessRequest request) {
    if (request.name.trim().isEmpty) {
      throw ValidationException(
        message: 'Business name is required.',
        field: 'name',
      );
    }
  }
}
