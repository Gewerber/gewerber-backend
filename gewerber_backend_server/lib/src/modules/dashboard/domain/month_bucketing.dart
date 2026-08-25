/// UTC monthly bucketing for the dashboard trend.
///
/// Architect decision (v1): monthly buckets are computed in **UTC**, not in
/// the business locale — a German-business month boundary only differs from
/// UTC by a few hours around New Year, which is acceptable for an indicative
/// trend chart. `asOf` on the summary use case is an escape hatch for tests;
/// production callers omit it so buckets anchor at "now".
library;

/// Returns the first instant (UTC midnight) of the month containing [moment].
DateTime utcMonthStart(DateTime moment) =>
    DateTime.utc(moment.year, moment.month);

/// Shifts a UTC month start by [months] (may be negative). Day overflow is
/// impossible here because inputs are always day-1 midnights.
DateTime shiftUtcMonths(DateTime monthStart, int months) {
  final total = monthStart.year * 12 + monthStart.month - 1 + months;
  return DateTime.utc(total ~/ 12, total % 12 + 1);
}

/// The [count] most recent UTC month starts including the month of [anchor],
/// oldest first. E.g. anchor in August with count 3 yields Jun 1, Jul 1,
/// Aug 1 (all UTC).
List<DateTime> lastUtcMonthStarts(DateTime anchor, int count) => [
  for (var i = count - 1; i >= 0; i--)
    shiftUtcMonths(utcMonthStart(anchor), -i),
];

/// Exclusive end of the bucket that starts at [monthStart] — the first
/// instant of the following month. Handles leap years via [DateTime] normal-
/// ization: `DateTime.utc(2024, 13, 1)` is Mar 1 2024 after a Feb 29 exists.
DateTime utcMonthEnd(DateTime monthStart) => shiftUtcMonths(monthStart, 1);
