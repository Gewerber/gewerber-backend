import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../domain/sequence_gateway.dart';

@Singleton(as: SequenceGateway)
class ServerpodSequenceGateway implements SequenceGateway {
  @override
  Future<int> next(
    Session session, {
    required int businessId,
    required String key,
    required int year,
    Transaction? transaction,
  }) async {
    final result = await session.db.unsafeQuery(
      'INSERT INTO "number_sequence" '
      '("businessId", "key", "year", "lastValue", "updatedAt") '
      'VALUES (@businessId, @key, @year, 1, now()) '
      'ON CONFLICT ("businessId", "key", "year") '
      'DO UPDATE SET "lastValue" = "number_sequence"."lastValue" + 1, '
      '"updatedAt" = now() '
      'RETURNING "lastValue"',
      parameters: QueryParameters.named({
        'businessId': businessId,
        'key': key,
        'year': year,
      }),
      transaction: transaction,
    );
    return (result.first.first as num).toInt();
  }
}
