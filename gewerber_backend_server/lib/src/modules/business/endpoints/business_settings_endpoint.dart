import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/business_scoped_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/get_business_settings_use_case.dart';
import '../application/update_business_settings_use_case.dart';

class BusinessSettingsEndpoint extends BusinessScopedEndpoint {
  Future<BusinessSettings> get(Session session, {int? businessId}) {
    return getIt<GetBusinessSettingsUseCase>().call(
      session,
      businessId: businessId,
    );
  }

  Future<BusinessSettings> update(
    Session session,
    UpdateBusinessSettingsRequest request,
  ) {
    return getIt<UpdateBusinessSettingsUseCase>().call(session, request);
  }
}
