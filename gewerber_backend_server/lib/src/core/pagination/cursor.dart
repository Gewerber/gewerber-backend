/// Opaque cursors shared by all keyset-paginated list endpoints.
///
/// A cursor encodes the position of the last row of the previous page
/// (`businessId`, `id` and the formatted sort value) as base64url-encoded
/// JSON. It is intentionally opaque: clients pass it back verbatim and must
/// repeat the same filters/ordering they used when the cursor was issued.
///
/// Cursors are versioned (`v`) so the payload format can evolve; unknown
/// versions are rejected with a [ValidationException].
library;

import 'dart:convert';

import '../../generated/protocol.dart';

/// Current payload version of the cursor format.
const int cursorVersion = 1;

/// The position a decoded cursor points to: the last row of the previous
/// page, scoped to the business (tenant) it was minted for.
typedef ListCursorPosition = ({int businessId, int lastId, String sortValue});

/// Encodes the last row of a page into an opaque, URL-safe cursor string.
String encodeListCursor({
  required int businessId,
  required int lastId,
  required String sortValue,
}) {
  final payload = jsonEncode({
    'v': cursorVersion,
    'b': businessId,
    'i': lastId,
    's': sortValue,
  });
  return base64Url.encode(utf8.encode(payload));
}

/// Decodes an opaque cursor produced by [encodeListCursor].
///
/// Returns `null` when [cursor] is absent (request for the first page).
/// Throws a [ValidationException] for any malformed, tampered or
/// unknown-version cursor so garbage never reaches the database layer.
ListCursorPosition? decodeListCursor(String? cursor) {
  if (cursor == null || cursor.isEmpty) return null;

  try {
    final json = jsonDecode(utf8.decode(base64Url.decode(cursor)));
    if (json is! Map<String, dynamic>) {
      throw const FormatException('cursor payload is not an object');
    }
    if (json['v'] != cursorVersion) {
      throw const FormatException('unsupported cursor version');
    }
    final businessId = json['b'];
    final lastId = json['i'];
    final sortValue = json['s'];
    if (businessId is! int || lastId is! int || sortValue is! String) {
      throw const FormatException('cursor payload has invalid fields');
    }
    return (businessId: businessId, lastId: lastId, sortValue: sortValue);
  } on FormatException {
    throw ValidationException(
      message: 'Malformed pagination cursor.',
      field: 'cursor',
    );
  } on ArgumentError {
    // base64Url.decode throws ArgumentError for characters outside the
    // alphabet; surface it with the same serializable exception.
    throw ValidationException(
      message: 'Malformed pagination cursor.',
      field: 'cursor',
    );
  }
}

/// Parses the ISO-8601 sort value carried by a cursor into a [DateTime],
/// rejecting well-formed envelopes with unusable payloads.
DateTime decodeCursorSortDate(ListCursorPosition position) {
  try {
    return DateTime.parse(position.sortValue).toUtc();
  } on FormatException {
    throw ValidationException(
      message: 'Malformed pagination cursor.',
      field: 'cursor',
    );
  }
}
