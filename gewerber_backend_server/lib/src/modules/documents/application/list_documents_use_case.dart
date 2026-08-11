import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../core/tenant/tenant_resolver.dart';
import '../../../generated/protocol.dart';
import '../domain/document_gateway.dart';

@singleton
class ListDocumentsUseCase {
  ListDocumentsUseCase(this._tenantResolver, this._documents);

  final TenantResolver _tenantResolver;
  final DocumentGateway _documents;

  Future<List<Document>> call(
    Session session, {
    int? businessId,
    DocumentKind? kind,
    String? relatedEntityType,
    String? relatedEntityId,
    int limit = 100,
    int offset = 0,
  }) async {
    final tenant = await _tenantResolver.resolve(
      session,
      businessId: businessId,
    );
    return _documents.find(
      session,
      businessId: tenant.businessId,
      kind: kind,
      relatedEntityType: relatedEntityType,
      relatedEntityId: relatedEntityId,
      limit: limit,
      offset: offset,
    );
  }
}
