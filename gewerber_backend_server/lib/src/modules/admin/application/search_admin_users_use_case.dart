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

  /// Keyset-paginated by email; the cursor carries the last email of the
  /// previous page (`{'e': ...}`).
  Future<AdminUserSummaryPage> call(
    Session session, {
    String? query,
    int? limit,
    String? cursor,
  }) async {
    final effectiveLimit = clampAdminListLimit(limit);
    final position = decodeAdminCursor(cursor);
    final afterEmail = cursorString(position, 'e');

    // One extra row detects a following page without a count query.
    final rows = await _directory.searchUsers(
      session,
      query: query,
      afterEmail: afterEmail,
      limit: effectiveLimit + 1,
    );

    final hasMore = rows.length > effectiveLimit;
    final items = hasMore ? rows.sublist(0, effectiveLimit) : rows;

    return AdminUserSummaryPage(
      items: items,
      nextCursor: hasMore && items.isNotEmpty
          ? encodeAdminCursor({'e': items.last.email!})
          : null,
      limit: effectiveLimit,
    );
  }
}
