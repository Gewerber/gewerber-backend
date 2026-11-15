import 'package:injectable/injectable.dart';
import 'package:serverpod/serverpod.dart';

import '../../../generated/protocol.dart';
import '../domain/admin_cursor.dart';
import '../domain/admin_directory_gateway.dart';
import '../domain/admin_list_limits.dart';

@singleton
class SearchAdminUsersUseCase {
  const SearchAdminUsersUseCase(this._directory);

  final AdminDirectoryGateway _directory;

  /// Keyset-paginated by `(email, userId)`; the cursor carries both keys of the
  /// last row of the previous page (`{'e': email, 'u': userId}`) so several
  /// users sharing one address paginate without skipping or looping.
  ///
  /// A legacy cursor with only `e` is still accepted and keeps the old
  /// email-only behavior.
  Future<AdminUserSummaryPage> call(
    Session session, {
    String? query,
    int? limit,
    String? cursor,
  }) async {
    final effectiveLimit = clampAdminListLimit(limit);
    final position = decodeAdminCursor(cursor);
    final afterEmail = cursorString(position, 'e');
    final afterUserId = cursorString(position, 'u');

    // One extra row detects a following page without a count query.
    final rows = await _directory.searchUsers(
      session,
      query: query,
      afterEmail: afterEmail,
      afterUserId: afterUserId,
      limit: effectiveLimit + 1,
    );

    final hasMore = rows.length > effectiveLimit;
    final items = hasMore ? rows.sublist(0, effectiveLimit) : rows;

    String? nextCursor;
    if (hasMore && items.isNotEmpty && items.last.email != null) {
      final last = items.last;
      nextCursor = encodeAdminCursor({
        'e': last.email,
        'u': last.userId.toString(),
      });
    }

    return AdminUserSummaryPage(
      items: items,
      nextCursor: nextCursor,
      limit: effectiveLimit,
    );
  }
}
