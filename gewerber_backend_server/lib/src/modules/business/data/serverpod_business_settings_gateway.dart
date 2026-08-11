import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/business_settings_gateway.dart';

@Singleton(as: BusinessSettingsGateway)
class ServerpodBusinessSettingsGateway implements BusinessSettingsGateway {
  @override
  Future<BusinessSettings?> findByBusinessId(Session session, int businessId) {
    return BusinessSettings.db.findFirstRow(
      session,
      where: (t) => t.businessId.equals(businessId),
    );
  }

  @override
  Future<BusinessSettings> create(
    Session session,
    BusinessSettings settings, {
    Transaction? transaction,
  }) {
    return BusinessSettings.db.insertRow(
      session,
      settings,
      transaction: transaction,
    );
  }

  @override
  Future<BusinessSettings> update(Session session, BusinessSettings settings) {
    return BusinessSettings.db.updateRow(session, settings);
  }
}
