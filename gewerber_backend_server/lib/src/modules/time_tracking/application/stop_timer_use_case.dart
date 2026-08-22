import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/audit/audit_service.dart';
import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../../business/domain/business_settings_gateway.dart';
import '../domain/time_entry_gateway.dart';
import '../domain/time_rounding.dart';

/// Stops the running timer of the business: computes the duration, applies
/// the business rounding rules and stores the result on the entry.
@singleton
class StopTimerUseCase {
  StopTimerUseCase(
    this._tenantResolver,
    this._entries,
    this._settings,
    this._audit,
  );

  final TenantResolver _tenantResolver;
  final TimeEntryGateway _entries;
  final BusinessSettingsGateway _settings;
  final AuditService _audit;

  Future<TimeEntry> call(
    Session session, {
    DateTime? now,
    int? businessId,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );

    final running = await _entries.findRunning(session, tenant.businessId);
    if (running == null) {
      throw NotFoundException(entityType: 'TimeEntry');
    }

    final stoppedAt = now ?? DateTime.now();
    final rawMinutes = stoppedAt.difference(running.startedAt).inSeconds / 60;
    if (rawMinutes < 0) {
      throw ValidationException(
        message: 'Stop time must be after the start time.',
        field: 'stoppedAt',
      );
    }

    final settings = await _settings.findByBusinessId(
      session,
      tenant.businessId,
    );
    final rounded = TimeRounding.apply(
      minutes: rawMinutes.ceil(),
      mode: settings?.roundingMode ?? RoundingMode.none,
      granularityMinutes: settings?.roundingGranularityMinutes ?? 1,
    );

    final updated = await _entries.update(
      session,
      running.copyWith(
        stoppedAt: stoppedAt,
        durationMinutes: rounded,
        updatedAt: DateTime.now(),
      ),
    );
    await _audit.log(
      session,
      action: 'time_entry.stopTimer',
      entityType: 'TimeEntry',
      entityId: '${updated.id}',
      changes: {'durationMinutes': '$rounded'},
      tenant: tenant,
    );
    return updated;
  }
}
