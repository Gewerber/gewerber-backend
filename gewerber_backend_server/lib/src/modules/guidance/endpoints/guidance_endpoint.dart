import 'package:serverpod/serverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/tenant/session_auth.dart';
import '../../../generated/protocol.dart';
import '../application/guidance_use_cases.dart';
import '../domain/guidance_content_provider.dart';
import '../domain/user_guidance_progress_gateway.dart';

/// Serves curated guidance content (tooltips, checklists, "What is this?"
/// popups) and tracks per-user progress. User-scoped, requires login.
class GuidanceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// All contextual tooltips.
  Future<List<GuidanceTip>> tips(Session session) async {
    return getIt<GuidanceContentProvider>().tips();
  }

  /// All checklists with their items.
  Future<List<ChecklistDefinition>> checklists(Session session) async {
    return getIt<GuidanceContentProvider>().checklists();
  }

  /// The signed-in user's progress (completed/dismissed items).
  Future<List<UserGuidanceProgress>> myProgress(Session session) async {
    final userId = session.authUserId;
    if (userId == null) {
      return const [];
    }
    return getIt<UserGuidanceProgressGateway>().findByUser(session, userId);
  }

  /// Marks a checklist item (or any guidance item key) as completed.
  Future<UserGuidanceProgress> markCompleted(Session session, String itemKey) {
    return getIt<MarkGuidanceCompletedUseCase>().call(session, itemKey);
  }

  /// Dismisses a tooltip so it is not shown again.
  Future<UserGuidanceProgress> dismissTip(Session session, String topic) {
    return getIt<DismissGuidanceTipUseCase>().call(session, topic);
  }
}
