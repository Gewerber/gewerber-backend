/// Page-size rules for the admin API.
///
/// Mirrors [clampListLimit] from `core/pagination`, but admin listings default
/// to smaller pages (50) so an AI agent never pulls more data than needed;
/// the hard cap stays at 200.
library;

import 'dart:math' as math;

import '../../../core/pagination/list_limits.dart' show maxListLimit;

/// Page size used when the client does not send a `limit`.
const int defaultAdminListLimit = 50;

/// Caps a client-provided [limit]: defaults to [defaultAdminListLimit] when
/// absent, never exceeds the platform-wide cap of 200 rows per page.
int clampAdminListLimit(int? limit) {
  if (limit == null || limit < 0) return defaultAdminListLimit;
  return math.min(limit, maxListLimit);
}
