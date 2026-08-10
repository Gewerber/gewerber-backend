import 'package:serverpod/serverpod.dart';

abstract interface class EventBus {
  Future<void> publish(
    Session session,
    String channel,
    SerializableModel event,
  );

  Stream<T> subscribe<T extends SerializableModel>(
    Session session,
    String channel,
  );
}
