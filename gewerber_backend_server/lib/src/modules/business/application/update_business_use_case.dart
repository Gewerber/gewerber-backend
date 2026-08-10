import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/business_gateway.dart';

@singleton
class UpdateBusinessUseCase {
  UpdateBusinessUseCase(this._tenantResolver, this._businesses, this._audit);

  final TenantResolver _tenantResolver;
  final BusinessGateway _businesses;
  final AuditService _audit;

  Future<Business> call(Session session, UpdateBusinessRequest request) async {
    final tenant = await _tenantResolver.requireAdmin(
      session,
      businessId: request.businessId,
    );
    final existing = await _businesses.findById(session, tenant.businessId);
    if (existing == null) {
      throw NotFoundException(
        entityType: 'Business',
        entityId: '${tenant.businessId}',
      );
    }
    _validate(request);

    final updated = existing.copyWith(
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
      updatedAt: DateTime.now().toUtc(),
    );
    final saved = await _businesses.update(session, updated);

    await _audit.log(
      session,
      action: 'business.update',
      entityType: 'Business',
      entityId: '${saved.id}',
      changes: _diff(existing, saved),
      tenant: tenant,
    );
    return saved;
  }

  void _validate(UpdateBusinessRequest request) {
    if (request.name.trim().isEmpty) {
      throw ValidationException(
        message: 'Business name is required.',
        field: 'name',
      );
    }
    if (request.currency.length != 3) {
      throw ValidationException(
        message: 'Currency must be a 3-letter code.',
        field: 'currency',
      );
    }
  }

  Map<String, String> _diff(Business before, Business after) {
    final changes = <String, String>{};
    void check(String field, Object? a, Object? b) {
      if ('$a' != '$b') changes[field] = '$a -> $b';
    }

    check('name', before.name, after.name);
    check('legalForm', before.legalForm, after.legalForm);
    check(
      'isKleinunternehmer',
      before.isKleinunternehmer,
      after.isKleinunternehmer,
    );
    check('vatId', before.vatId, after.vatId);
    check('email', before.email, after.email);
    check('phone', before.phone, after.phone);
    check('address', before.address, after.address);
    check('locale', before.locale, after.locale);
    check('currency', before.currency, after.currency);
    return changes;
  }
}
