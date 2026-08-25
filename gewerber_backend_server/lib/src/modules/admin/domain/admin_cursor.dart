/// Opaque keyset cursors for cross-tenant admin listings.
///
/// Unlike the tenant-scoped `encodeListCursor` from `core/pagination`, an
/// admin cursor carries a plain versioned JSON payload whose keys are defined
/// by the listing that minted it (`e` = last email, `i` = last id,
/// `d` = ISO date, ...). Clients pass it back verbatim and must repeat the
/// same filters/ordering. Malformed or unknown-version cursors are rejected
/// with a generated [ValidationException] so garbage never reaches SQL.
library;

import 'dart:convert';

import '../../../generated/protocol.dart';

/// Current payload version of the admin cursor format.
const int adminCursorVersion = 1;

/// Encodes a cursor payload as base64url of versioned JSON.
String encodeAdminCursor(Map<String, Object?> payload) {
  return base64Url.encode(
    utf8.encode(jsonEncode({'v': adminCursorVersion, ...payload})),
  );
}

/// Decodes an opaque cursor produced by [encodeAdminCursor].
///
/// Returns `null` when [cursor] is absent (request for the first page).
Map<String, Object?>? decodeAdminCursor(String? cursor) {
  if (cursor == null || cursor.isEmpty) return null;

  Object? json;
  try {
    json = jsonDecode(utf8.decode(base64Url.decode(cursor)));
  } on FormatException {
    throw ValidationException(
      message: 'Malformed pagination cursor.',
      field: 'cursor',
    );
  } on ArgumentError {
    throw ValidationException(
      message: 'Malformed pagination cursor.',
      field: 'cursor',
    );
  }

  if (json is! Map<String, dynamic>) {
    throw ValidationException(
      message: 'Malformed pagination cursor.',
      field: 'cursor',
    );
  }
  if (json['v'] != adminCursorVersion) {
    throw ValidationException(
      message: 'Unsupported cursor version.',
      field: 'cursor',
    );
  }
  return json;
}

/// Reads a required String field from a decoded cursor.
String? cursorString(Map<String, Object?>? cursor, String key) {
  final value = cursor?[key];
  if (value == null) return null;
  if (value is! String) {
    throw ValidationException(
      message: 'Malformed pagination cursor.',
      field: 'cursor',
    );
  }
  return value;
}

/// Reads a required int field from a decoded cursor.
int? cursorInt(Map<String, Object?>? cursor, String key) {
  final value = cursor?[key];
  if (value == null) return null;
  if (value is! int) {
    throw ValidationException(
      message: 'Malformed pagination cursor.',
      field: 'cursor',
    );
  }
  return value;
}
