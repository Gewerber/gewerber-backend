import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/account_anonymization_gateway.dart';

@Singleton(as: AccountAnonymizationGateway)
class ServerpodAccountAnonymizationGateway
    implements AccountAnonymizationGateway {
  @override
  Future<void> severPersonalLinks(
    Session session,
    UuidValue userId, {
    required Transaction transaction,
  }) async {
    // Each update is a single bulk statement (`UPDATE ... WHERE userId = ?`)
    // so the number of round trips does not grow with the data volume.
    await Membership.db.updateWhere(
      session,
      where: (t) => t.userId.equals(userId),
      columnValues: (t) => [t.userId(null)],
      transaction: transaction,
      noReturn: true,
    );

    await Document.db.updateWhere(
      session,
      where: (t) => t.uploadedById.equals(userId),
      columnValues: (t) => [t.uploadedById(null)],
      transaction: transaction,
      noReturn: true,
    );

    await AuditEntry.db.updateWhere(
      session,
      where: (t) => t.userId.equals(userId),
      columnValues: (t) => [t.userId(null)],
      transaction: transaction,
      noReturn: true,
    );

    await UserGuidanceProgress.db.updateWhere(
      session,
      where: (t) => t.userId.equals(userId),
      columnValues: (t) => [t.userId(null)],
      transaction: transaction,
      noReturn: true,
    );
  }
}
