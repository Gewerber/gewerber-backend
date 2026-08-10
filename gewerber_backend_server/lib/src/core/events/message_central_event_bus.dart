import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import 'event_bus.dart';

@Singleton(as: EventBus)
class MessageCentralEventBus implements EventBus {
  @override
  Future<void> publish(
    Session session,
    String channel,
    SerializableModel event,
  ) async {
    await session.messages.postMessage(channel, event);
  }

  @override
  Stream<T> subscribe<T extends SerializableModel>(
    Session session,
    String channel,
  ) {
    return session.messages.createStream<T>(channel);
  }
}
