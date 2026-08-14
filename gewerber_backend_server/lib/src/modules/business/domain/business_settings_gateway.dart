import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';

abstract interface class BusinessSettingsGateway {
  Future<BusinessSettings?> findByBusinessId(Session session, int businessId);

  Future<BusinessSettings> create(
    Session session,
    BusinessSettings settings, {
    Transaction? transaction,
  });

  Future<BusinessSettings> update(Session session, BusinessSettings settings);
}
