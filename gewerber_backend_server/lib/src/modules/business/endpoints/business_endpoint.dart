import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/business_scoped_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/create_business_use_case.dart';
import '../application/get_business_use_case.dart';
import '../application/list_my_businesses_use_case.dart';
import '../application/update_business_use_case.dart';

class BusinessEndpoint extends BusinessScopedEndpoint {
  Future<Business> create(Session session, CreateBusinessRequest request) {
    return getIt<CreateBusinessUseCase>().call(session, request);
  }

  Future<Business> get(Session session, {int? businessId}) {
    return getIt<GetBusinessUseCase>().call(session, businessId: businessId);
  }

  Future<Business> update(Session session, UpdateBusinessRequest request) {
    return getIt<UpdateBusinessUseCase>().call(session, request);
  }

  Future<List<Business>> listMine(Session session) {
    return getIt<ListMyBusinessesUseCase>().call(session);
  }
}
