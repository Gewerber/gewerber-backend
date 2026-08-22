import '../../../generated/protocol.dart';

/// Applies the business rounding rules to a tracked duration.
class TimeRounding {
  const TimeRounding._();

  static int apply({
    required int minutes,
    required RoundingMode mode,
    required int granularityMinutes,
  }) {
    if (mode == RoundingMode.none || granularityMinutes <= 1) {
      return minutes;
    }
    final g = granularityMinutes;
    return switch (mode) {
      RoundingMode.none => minutes,
      RoundingMode.up => ((minutes + g - 1) ~/ g) * g,
      RoundingMode.down => (minutes ~/ g) * g,
      RoundingMode.nearest => ((minutes + g ~/ 2) ~/ g) * g,
    };
  }
}
