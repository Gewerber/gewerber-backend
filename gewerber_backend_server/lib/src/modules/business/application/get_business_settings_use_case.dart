import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/business_settings_gateway.dart';

@singleton
class GetBusinessSettingsUseCase {
  GetBusinessSettingsUseCase(this._tenantResolver, this._settings);

  final TenantResolver _tenantResolver;
  final BusinessSettingsGateway _settings;

  Future<BusinessSettings> call(Session session, {int? businessId}) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    final existing = await _settings.findByBusinessId(
      session,
      tenant.businessId,
    );
    if (existing != null) {
      return existing;
    }
    try {
      return await _settings.create(
        session,
        BusinessSettings(businessId: tenant.businessId),
      );
    } on DatabaseQueryException catch (e) {
      // 23505 = unique_violation: a concurrent request created the row.
      if (e.code != '23505') rethrow;
      final created = await _settings.findByBusinessId(
        session,
        tenant.businessId,
      );
      if (created == null) rethrow;
      return created;
    }
  }
}
