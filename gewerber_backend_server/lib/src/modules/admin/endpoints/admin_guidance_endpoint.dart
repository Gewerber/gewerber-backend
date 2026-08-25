import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/endpoints/admin_endpoint.dart';
import '../../../generated/protocol.dart';
import '../application/guidance_admin_use_cases.dart';

/// Administration of guidance content: read the effective tips (curated
/// in-code content merged with admin overrides), upsert overrides.
class AdminGuidanceEndpoint extends AdminEndpoint {
  /// The effective tips as users see them in `guidance.tips`.
  Future<List<GuidanceTip>> guidanceTipsList(Session session) async {
    await requireAdmin(session, minRole: AdminRole.moderator);
    return getIt<ListAdminGuidanceTipsUseCase>().call(session);
  }

  /// Creates or replaces an admin-managed tip by its unique topic. A topic
  /// that matches a curated tip overrides it; other topics are appended as
  /// new tips.
  Future<GuidanceTip> guidanceTipUpsert(
    Session session, {
    required String topic,
    required String title,
    required String body,
    required bool confirm,
  }) async {
    final actor = await requireAdmin(session, minRole: AdminRole.admin);
    return getIt<UpsertGuidanceTipUseCase>().call(
      session,
      actor: actor,
      topic: topic,
      title: title,
      body: body,
      confirm: confirm,
    );
  }
}
