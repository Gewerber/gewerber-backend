import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/i18n/locale_resolver.dart';
import '../../../core/i18n/message_catalog.dart';
import '../../../core/i18n/messages.dart';
import '../../../core/tenant/session_auth.dart';
import '../../../core/tenant/tenant_context.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../../user/domain/user_profile_gateway.dart';
import '../domain/business_gateway.dart';
import '../domain/membership_gateway.dart';

@Singleton(as: TenantResolver)
class ServerpodTenantResolver implements TenantResolver {
  ServerpodTenantResolver(
    this._memberships,
    this._businesses,
    this._profiles,
    this._messages,
  );

  final MembershipGateway _memberships;
  final BusinessGateway _businesses;
  final UserProfileGateway _profiles;
  final MessageCatalog _messages;

  @override
  Future<TenantContext> resolve(Session session, {int? businessId}) async {
    final userId = session.authUserId;
    if (userId == null) {
      // No user means no language to speak, so the fallback locale.
      throw ForbiddenException(
        message: _messages.text(
          Messages.errorNotAuthenticated,
          locale: fallbackLocale,
        ),
      );
    }

    if (businessId == null) {
      final memberships = await _memberships.findByUser(session, userId);
      if (memberships.isEmpty) {
        throw NotFoundException(entityType: 'Business');
      }
      final membership = memberships.first;
      return TenantContext(
        userId: userId,
        businessId: membership.businessId,
        role: membership.role,
        locale: await _resolveLocale(
          session,
          userId,
          membership.businessId,
        ),
      );
    }

    final membership = await _memberships.find(
      session,
      userId: userId,
      businessId: businessId,
    );
    if (membership == null) {
      throw ForbiddenException(
        message: _messages.text(
          Messages.errorNotBusinessMember,
          locale: await _resolveLocale(session, userId, businessId),
        ),
      );
    }
    return TenantContext(
      userId: userId,
      businessId: businessId,
      role: membership.role,
      locale: await _resolveLocale(session, userId, businessId),
    );
  }

  @override
  Future<TenantContext> requireAdmin(Session session, {int? businessId}) async {
    final tenant = await resolve(session, businessId: businessId);
    if (!tenant.isAdmin) {
      throw ForbiddenException(
        message: _messages.text(
          Messages.errorAdminPermissionsRequired,
          locale: tenant.locale,
        ),
      );
    }
    return tenant;
  }

  /// Language for the caller's own screen text.
  ///
  /// Costs one primary-key read of `user_profile` and, only when the user has
  /// no profile yet or has switched to a business whose language differs, one
  /// read of `business`. Both are small indexed lookups on tables that are
  /// tiny relative to the invoicing data every business-scoped request already
  /// touches, and the locale is needed to render nearly every error and much of
  /// the guidance surface — so resolving it once per request is cheaper than
  /// having each call site re-resolve it.
  Future<Locale> _resolveLocale(
    Session session,
    UuidValue userId,
    int? businessId,
  ) async {
    final profile = await _profiles.findByUserId(session, userId);
    if (businessId == null) {
      return LocaleResolver.forUserInterface(userProfile: profile?.locale);
    }
    final business = await _businesses.findById(session, businessId);
    return LocaleResolver.forUserInterface(
      userProfile: profile?.locale,
      business: business?.locale,
    );
  }
}
