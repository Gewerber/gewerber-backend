/// Page-size rules shared by all tenant-scoped list endpoints.
///
/// Every list use case must derive its effective page size with
/// [clampListLimit] so that clients cannot request unbounded result sets.
library;

import 'dart:math' as math;

/// Page size used when the client does not send a `limit`.
const int defaultListLimit = 100;

/// Hard upper bound for a single page, regardless of what the client asks for.
const int maxListLimit = 200;

/// Caps a client-provided [limit]: defaults to [defaultListLimit] when absent,
/// never exceeds [maxListLimit] (`min(limit ?? 100, 200)`).
///
/// Negative values are treated as absent (a negative SQL `LIMIT` would mean
/// "no limit" in PostgreSQL and defeat the cap); an explicit `0` is honored
/// and returns an empty page.
int clampListLimit(int? limit) {
  if (limit == null || limit < 0) return defaultListLimit;
  return math.min(limit, maxListLimit);
}
