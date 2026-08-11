import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/business_settings_gateway.dart';

@singleton
class UpdateBusinessSettingsUseCase {
  UpdateBusinessSettingsUseCase(
    this._tenantResolver,
    this._settings,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final BusinessSettingsGateway _settings;
  final AuditService _audit;

  Future<BusinessSettings> call(
    Session session,
    UpdateBusinessSettingsRequest request,
  ) async {
    final tenant = await _tenantResolver.requireAdmin(
      session,
      businessId: request.businessId,
    );
    final existing = await _settings.findByBusinessId(
      session,
      tenant.businessId,
    );
    final base =
        existing ?? BusinessSettings(businessId: tenant.businessId);
    _validate(request);

    final updated = base.copyWith(
      paymentTermsDays: request.paymentTermsDays,
      invoiceNumberPrefix: request.invoiceNumberPrefix,
      invoiceNumberIncludeYear: request.invoiceNumberIncludeYear,
      invoiceNumberMinDigits: request.invoiceNumberMinDigits,
      roundingMode: request.roundingMode,
      roundingGranularityMinutes: request.roundingGranularityMinutes,
      updatedAt: DateTime.now().toUtc(),
    );
    final saved = existing == null
        ? await _settings.create(session, updated)
        : await _settings.update(session, updated);

    await _audit.log(
      session,
      action: 'business_settings.update',
      entityType: 'BusinessSettings',
      entityId: '${saved.id}',
      tenant: tenant,
    );
    return saved;
  }

  void _validate(UpdateBusinessSettingsRequest request) {
    if (request.paymentTermsDays < 0) {
      throw ValidationException(
        message: 'Payment terms must not be negative.',
        field: 'paymentTermsDays',
      );
    }
    if (request.invoiceNumberMinDigits < 1 ||
        request.invoiceNumberMinDigits > 10) {
      throw ValidationException(
        message: 'Invoice number digits must be between 1 and 10.',
        field: 'invoiceNumberMinDigits',
      );
    }
    if (request.roundingGranularityMinutes < 1) {
      throw ValidationException(
        message: 'Rounding granularity must be at least 1 minute.',
        field: 'roundingGranularityMinutes',
      );
    }
  }
}
