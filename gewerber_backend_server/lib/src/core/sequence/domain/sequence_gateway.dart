import 'package:serverpod/serverpod.dart';

abstract interface class SequenceGateway {
  /// Atomically increments and returns the next value of the sequence
  /// identified by ([businessId], [key], [year]). Starts at 1.
  Future<int> next(
    Session session, {
    required int businessId,
    required String key,
    required int year,
    Transaction? transaction,
  });
}
