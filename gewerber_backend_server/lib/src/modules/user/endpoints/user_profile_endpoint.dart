import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../generated/protocol.dart';
import '../application/get_my_profile_use_case.dart';
import '../application/update_user_profile_use_case.dart';

class UserProfileEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<UserProfile> getMyProfile(Session session) {
    return getIt<GetMyProfileUseCase>().call(session);
  }

  Future<UserProfile> update(
    Session session,
    UpdateUserProfileRequest request,
  ) {
    return getIt<UpdateUserProfileUseCase>().call(session, request);
  }
}
