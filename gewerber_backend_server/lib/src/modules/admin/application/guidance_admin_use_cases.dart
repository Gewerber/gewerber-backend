import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/admin/admin_context.dart';
import '../../../core/audit/audit_service.dart';
import '../../../generated/protocol.dart';
import '../../guidance/domain/guidance_content_provider.dart';
import '../../guidance/domain/guidance_tip_override_gateway.dart';
import '../domain/require_confirm.dart';

/// The effective guidance tips: curated in-code content with admin overrides
/// applied on top (an override replaces the built-in tip of the same topic,
/// topics without a built-in counterpart are appended).
@singleton
class ListAdminGuidanceTipsUseCase {
  ListAdminGuidanceTipsUseCase(this._content, this._overrides);

  final GuidanceContentProvider _content;
  final GuidanceTipOverrideGateway _overrides;

  Future<List<GuidanceTip>> call(Session session) async {
    final base = _content.tips();
    final stored = await _overrides.listAll(session);
    if (stored.isEmpty) return base;

    final byTopic = {for (final tip in base) tip.topic: tip};
    for (final override in stored) {
      byTopic[override.topic] = GuidanceTip(
        topic: override.topic,
        title: override.title,
        body: override.body,
      );
    }
    return byTopic.values.toList();
  }
}

/// Creates or updates an admin-managed guidance tip.
@singleton
class UpsertGuidanceTipUseCase {
  UpsertGuidanceTipUseCase(this._overrides, this._audit);

  final GuidanceTipOverrideGateway _overrides;
  final AuditService _audit;

  Future<GuidanceTip> call(
    Session session, {
    required AdminContext actor,
    required String topic,
    required String title,
    required String body,
    required bool confirm,
  }) async {
    requireConfirm(confirm);

    final normalizedTopic = topic.trim();
    if (normalizedTopic.isEmpty ||
        title.trim().isEmpty ||
        body.trim().isEmpty) {
      throw ValidationException(
        message: 'topic, title and body must not be empty.',
        field: 'topic',
      );
    }

    final existing = await _overrides.upsert(
      session,
      GuidanceTipOverride(
        topic: normalizedTopic,
        title: title.trim(),
        body: body.trim(),
      ),
    );

    await _audit.log(
      session,
      action: 'admin.guidanceTipUpsert',
      entityType: 'GuidanceTipOverride',
      entityId: normalizedTopic,
      changes: {'title': existing.title},
      userId: actor.userId,
    );

    return GuidanceTip(
      topic: existing.topic,
      title: existing.title,
      body: existing.body,
    );
  }
}
