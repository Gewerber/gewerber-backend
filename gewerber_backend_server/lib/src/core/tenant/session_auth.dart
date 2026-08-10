import 'package:serverpod/serverpod.dart';

extension SessionAuth on Session {
  UuidValue? get authUserId {
    final info = authenticated;
    if (info == null) return null;
    return UuidValue.fromString(info.userIdentifier);
  }
}
