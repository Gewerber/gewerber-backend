import '../../../generated/protocol.dart';

/// Advances [date] by one [interval], preserving calendar semantics
/// (e.g. `monthly` keeps the day-of-month, so Jan 31 -> Feb 28/29 via
/// DateTime overflow handling).
DateTime advanceRecurrence(DateTime date, RecurrenceInterval interval) {
  final local = date.toLocal();
  return switch (interval) {
    RecurrenceInterval.daily => local.add(const Duration(days: 1)),
    RecurrenceInterval.weekly => local.add(const Duration(days: 7)),
    RecurrenceInterval.monthly => DateTime(
      local.year,
      local.month + 1,
      local.day,
    ),
    RecurrenceInterval.quarterly => DateTime(
      local.year,
      local.month + 3,
      local.day,
    ),
    RecurrenceInterval.yearly => DateTime(
      local.year + 1,
      local.month,
      local.day,
    ),
  };
}
