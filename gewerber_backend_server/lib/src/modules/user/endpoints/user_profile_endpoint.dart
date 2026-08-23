import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../generated/protocol.dart';
import '../application/delete_my_account_use_case.dart';
import '../application/export_my_data_use_case.dart';
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

  /// Soft-deletes the account of the logged-in user (GDPR Art. 17): sets a
  /// `deletedAt` marker and severs all personal links in retained business
  /// data (GoBD retention). Repeating the call throws [NotFoundException].
  Future<void> deleteMyAccount(Session session) {
    return getIt<DeleteMyAccountUseCase>().call(session);
  }

  /// Exports all data of the logged-in user as a ZIP archive (GDPR Art. 20):
  /// profile, memberships, guidance progress and every business the user is
  /// a member of with its customers, invoices (+items), projects, tasks,
  /// time entries, transactions and documents. Foreign tenants are not
  /// included.
  Future<ByteData> exportMyData(Session session) {
    return getIt<ExportMyDataUseCase>().call(session);
  }
}
