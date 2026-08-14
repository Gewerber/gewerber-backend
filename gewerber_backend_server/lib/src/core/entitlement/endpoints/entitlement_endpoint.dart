import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../../di/service_locator.dart';
import '../../endpoints/business_scoped_endpoint.dart';
import '../entitlement_provider.dart';

class EntitlementEndpoint extends BusinessScopedEndpoint {
  Future<List<Feature>> list(Session session, {int? businessId}) async {
    final tenant = await super.tenant(session, businessId: businessId);
    final features = await getIt<EntitlementProvider>().featuresFor(
      session,
      tenant,
    );
    final result = features.toList()..sort((a, b) => a.name.compareTo(b.name));
    return result;
  }
}
