import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/session_auth.dart';
import '../../../generated/protocol.dart';
import '../domain/business_gateway.dart';
import '../domain/membership_gateway.dart';

@singleton
class ListMyBusinessesUseCase {
  ListMyBusinessesUseCase(this._businesses, this._memberships);

  final BusinessGateway _businesses;
  final MembershipGateway _memberships;

  Future<List<Business>> call(Session session) async {
    final userId = session.authUserId;
    if (userId == null) {
      throw ForbiddenException(message: 'Not authenticated.');
    }
    final memberships = await _memberships.findByUser(session, userId);
    final businesses = <Business>[];
    for (final membership in memberships) {
      final business = await _businesses.findById(
        session,
        membership.businessId,
      );
      if (business != null) businesses.add(business);
    }
    return businesses;
  }
}
