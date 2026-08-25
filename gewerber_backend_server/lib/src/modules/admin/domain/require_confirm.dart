/// Shared guard for destructive admin mutations.
library;

import '../../../generated/protocol.dart';

/// Every mutating admin endpoint method takes an explicit `confirm` flag;
/// the MCP client must send `confirm: true` on purpose.
///
/// Throws a generated [ValidationException] unless [confirm] is true.
void requireConfirm(bool confirm) {
  if (!confirm) {
    throw ValidationException(
      message:
          'confirm required: set confirm=true to execute this destructive '
          'operation.',
      field: 'confirm',
    );
  }
}
