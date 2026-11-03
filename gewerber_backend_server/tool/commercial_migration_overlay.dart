/// Rewrites the project migration generated inside a release image so it can be
/// re-applied safely on every rebuild.
///
/// ## Why this exists
///
/// A release image resolves the real closed-source `commercial` module, so
/// `serverpod generate` produces a model whose six `commercial_*` tables are not
/// in the committed migration chain — the public chain is generated against the
/// stubs, and `ci.yml`'s privacy guard forbids private table names in this
/// repository. `serverpod create-migration` therefore emits an extra migration
/// inside the image that carries the module schema.
///
/// That image migration is **not committed** and its version is the build
/// timestamp, so every rebuild generates a new one. On an existing database the
/// new version is applied as a delta, which means the same `CREATE TABLE`
/// statements run again. Rewriting them to their `IF [NOT] EXISTS` form makes
/// the delta idempotent: a rebuild converges instead of failing with
/// "relation already exists".
///
/// Fresh databases are unaffected: Serverpod applies the latest migration's
/// full `definition.sql` once, not this delta.
///
/// ## Fail-closed
///
/// Only additive/idempotent forms are handled. Any other statement (a rename, a
/// dropped type, a `GRANT`, ...) aborts the build with the offending line, so a
/// module schema change that needs a hand-written migration cannot slip through
/// silently. The same applies to a non-commercial table: it means the committed
/// chain drifted from the resolved OSS modules, and the fix is to regenerate the
/// public chain (`serverpod create-migration` against the stubs) rather than to
/// paper over it in the image.
///
/// Usage (from the server package directory):
///
/// ```bash
/// dart tool/commercial_migration_overlay.dart \
///   --migrations-dir migrations \
///   --previous-version 20260928071125207 \
///   --require-table-prefix commercial_
/// ```
library;

import 'dart:io';

/// Directory names created by `serverpod create-migration`.
final _migrationVersion = RegExp(r'^\d{17}');

/// Thrown when the generated SQL cannot be made safely idempotent.
class OverlaySqlException implements Exception {
  OverlaySqlException(this.message, {this.line});

  /// Human-readable explanation printed by the build.
  final String message;

  /// The offending SQL line, when the failure is line-specific.
  final String? line;

  @override
  String toString() =>
      line == null ? message : '$message\n  offending line: $line';
}

/// Returns the lexicographically newest migration version in [migrationsDir].
///
/// Returns `null` when the directory holds no migration yet.
String? latestMigrationVersion(Directory migrationsDir) {
  if (!migrationsDir.existsSync()) return null;
  final versions =
      migrationsDir
          .listSync()
          .whereType<Directory>()
          .map(
            (directory) =>
                directory.uri.pathSegments.lastWhere((s) => s.isNotEmpty),
          )
          .where(_migrationVersion.hasMatch)
          .toList()
        ..sort();
  return versions.isEmpty ? null : versions.last;
}

/// Rewrites [sql] into an idempotent form.
///
/// [requiredTablePrefix] is enforced on every table the SQL creates or alters;
/// pass an empty string to disable the check.
String makeIdempotent(
  String sql, {
  required String requiredTablePrefix,
}) {
  final output = <String>[];
  final lines = sql.split('\n');

  void requireTable(String table) {
    if (requiredTablePrefix.isEmpty) return;
    if (!table.startsWith(requiredTablePrefix)) {
      throw OverlaySqlException(
        'The generated migration touches table "$table", which is outside '
        'the "$requiredTablePrefix" module namespace. The committed migration '
        'chain is stale relative to the resolved OSS modules — run '
        '`serverpod create-migration` against the stubs and commit the result.',
      );
    }
  }

  bool isPassthrough(String line) {
    final lower = line.toLowerCase();
    return RegExp(r'^(begin|commit);?$').hasMatch(lower) ||
        lower.startsWith('insert into "serverpod_migrations"') ||
        lower.startsWith('create or replace function');
  }

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    final trimmed = line.trimLeft();

    if (trimmed.isEmpty || trimmed.startsWith('--')) {
      output.add(line);
      continue;
    }
    // Continuation line of a multi-line statement (column definitions,
    // function bodies, the `REFERENCES ...` part of a foreign key, ...).
    if (line != trimmed) {
      output.add(line);
      continue;
    }
    if (isPassthrough(line)) {
      output.add(line);
      continue;
    }

    var handled = false;

    final createTable = RegExp(r'^CREATE TABLE "([^"]+)"(.*)$')
        .firstMatch(line);
    if (createTable != null) {
      final table = createTable.group(1)!;
      requireTable(table);
      output.add('CREATE TABLE IF NOT EXISTS "$table"${createTable.group(2)}');
      handled = true;
    }

    final createIndex = RegExp(
      r'^CREATE (UNIQUE )?INDEX "([^"]+)" ON "([^"]+)"(.*)$',
    ).firstMatch(line);
    if (createIndex != null) {
      final table = createIndex.group(3)!;
      requireTable(table);
      final unique = createIndex.group(1) ?? '';
      output.add(
        'CREATE ${unique}INDEX IF NOT EXISTS "${createIndex.group(2)}" '
        'ON "$table"${createIndex.group(4)}',
      );
      handled = true;
    }

    final addColumn = RegExp(
      r'^ALTER TABLE (ONLY )?"([^"]+)" ADD COLUMN "([^"]+)"(.*)$',
    ).firstMatch(line);
    if (addColumn != null) {
      final table = addColumn.group(2)!;
      requireTable(table);
      final only = addColumn.group(1) ?? '';
      output.add(
        'ALTER TABLE $only"$table" ADD COLUMN IF NOT EXISTS '
        '"${addColumn.group(3)}"${addColumn.group(4)}',
      );
      handled = true;
    }

    final dropColumn = RegExp(
      r'^ALTER TABLE (ONLY )?"([^"]+)" DROP COLUMN (IF EXISTS )?"([^"]+)"(.*)$',
    ).firstMatch(line);
    if (dropColumn != null) {
      final table = dropColumn.group(2)!;
      requireTable(table);
      final only = dropColumn.group(1) ?? '';
      output.add(
        'ALTER TABLE $only"$table" DROP COLUMN IF EXISTS '
        '"${dropColumn.group(4)}"${dropColumn.group(5)}',
      );
      handled = true;
    }

    final addConstraint = RegExp(
      r'^ALTER TABLE (ONLY )?"([^"]+)" ADD CONSTRAINT "([^"]+)"(.*)$',
    ).firstMatch(line);
    if (addConstraint != null) {
      final table = addConstraint.group(2)!;
      requireTable(table);
      final only = addConstraint.group(1) ?? '';
      output.add(
        'ALTER TABLE $only"$table" DROP CONSTRAINT IF EXISTS '
        '"${addConstraint.group(3)}";',
      );
      output.add(line);
      handled = true;
    }

    final dropConstraint = RegExp(
      r'^ALTER TABLE (ONLY )?"([^"]+)" DROP CONSTRAINT (IF EXISTS )?"([^"]+)"(.*)$',
    ).firstMatch(line);
    if (dropConstraint != null) {
      final table = dropConstraint.group(2)!;
      requireTable(table);
      final only = dropConstraint.group(1) ?? '';
      output.add(
        'ALTER TABLE $only"$table" DROP CONSTRAINT IF EXISTS '
        '"${dropConstraint.group(4)}"${dropConstraint.group(5)}',
      );
      handled = true;
    }

    // `ALTER TABLE ONLY "t"` on its own line, with `ADD CONSTRAINT` on the
    // next non-empty line — the shape Serverpod emits for foreign keys.
    final alterTableHeader = RegExp(
      r'^ALTER TABLE (ONLY )?"([^"]+)"\s*$',
    ).firstMatch(line);
    if (alterTableHeader != null) {
      final table = alterTableHeader.group(2)!;
      requireTable(table);
      final only = alterTableHeader.group(1) ?? '';
      var next = i + 1;
      while (next < lines.length &&
          (lines[next].trim().isEmpty || lines[next].trim().startsWith('--'))) {
        next++;
      }
      final constraint = next < lines.length
          ? RegExp(
              r'^\s+ADD CONSTRAINT "([^"]+)"',
            ).firstMatch(lines[next])
          : null;
      if (constraint == null) {
        throw OverlaySqlException(
          'Unsupported multi-line ALTER TABLE form; only ADD CONSTRAINT can be '
          'made idempotent automatically.',
          line: line,
        );
      }
      output.add(
        'ALTER TABLE $only"$table" DROP CONSTRAINT IF EXISTS '
        '"${constraint.group(1)}";',
      );
      output.add(line);
      handled = true;
    }

    final dropTable = RegExp(
      r'^DROP TABLE (IF EXISTS )?"([^"]+)"(.*)$',
    ).firstMatch(line);
    if (dropTable != null) {
      final table = dropTable.group(2)!;
      requireTable(table);
      output.add('DROP TABLE IF EXISTS "$table"${dropTable.group(3)}');
      handled = true;
    }

    final dropIndex = RegExp(
      r'^DROP INDEX (IF EXISTS )?"([^"]+)"(.*)$',
    ).firstMatch(line);
    if (dropIndex != null) {
      output.add(
        'DROP INDEX IF EXISTS "${dropIndex.group(2)}"${dropIndex.group(3)}',
      );
      handled = true;
    }

    final createExtension = RegExp(
      r'^CREATE EXTENSION (IF NOT EXISTS )?"([^"]+)"(.*)$',
    ).firstMatch(line);
    if (createExtension != null) {
      output.add(
        'CREATE EXTENSION IF NOT EXISTS "${createExtension.group(2)}"'
        '${createExtension.group(3)}',
      );
      handled = true;
    }

    final createSequence = RegExp(
      r'^CREATE SEQUENCE (IF NOT EXISTS )?"([^"]+)"(.*)$',
    ).firstMatch(line);
    if (createSequence != null) {
      output.add(
        'CREATE SEQUENCE IF NOT EXISTS "${createSequence.group(2)}"'
        '${createSequence.group(3)}',
      );
      handled = true;
    }

    if (!handled) {
      // Function bodies (`returns uuid`, `as $$`, `end`, `volatile;`), the
      // closing `);` of a CREATE TABLE and similar continuation lines are not
      // statements of their own and are safe to pass through. Only a line that
      // *starts* with a DDL/DML keyword is a statement this tool must
      // understand.
      final firstWord = RegExp(
        r'^[A-Za-z]+',
      ).firstMatch(line)?.group(0)?.toUpperCase();
      const unsupportedKeywords = {
        'ALTER',
        'COMMENT',
        'CREATE',
        'DELETE',
        'DROP',
        'GRANT',
        'INSERT',
        'RENAME',
        'REVOKE',
        'SET',
        'TRUNCATE',
        'UPDATE',
      };
      if (firstWord == null || !unsupportedKeywords.contains(firstWord)) {
        output.add(line);
        continue;
      }
      throw OverlaySqlException(
        'Unsupported SQL statement in the generated module migration. Extend '
        'tool/commercial_migration_overlay.dart with an idempotent rewrite, or '
        'ship the change as a hand-written module migration.',
        line: line,
      );
    }
  }

  return output.join('\n');
}

void main(List<String> args) {
  final options = _parseArgs(args);
  final migrationsDir = Directory(options.migrationsDir);

  final latest = latestMigrationVersion(migrationsDir);
  if (latest == null) {
    stderr.writeln('No migrations found in ${migrationsDir.path}.');
    exit(1);
  }
  if (latest == options.previousVersion) {
    stdout.writeln(
      'No new module migration was generated (resolved modules already match '
      'the committed chain).',
    );
    return;
  }
  if (options.previousVersion != null &&
      latest.compareTo(options.previousVersion!) < 0) {
    stderr.writeln(
      'Newest migration "$latest" sorts before the previous version '
      '"${options.previousVersion}". Check the system clock.',
    );
    exit(1);
  }

  final migrationFile = File('${migrationsDir.path}/$latest/migration.sql');
  if (!migrationFile.existsSync()) {
    stderr.writeln('Missing ${migrationFile.path}.');
    exit(1);
  }

  try {
    final original = migrationFile.readAsStringSync();
    final rewritten = makeIdempotent(
      original,
      requiredTablePrefix: options.requiredTablePrefix,
    );
    if (rewritten != original) {
      migrationFile.writeAsStringSync(rewritten);
    }
    stdout.writeln(
      'Module migration $latest is idempotent '
      '(${rewritten == original ? 'unchanged' : 'rewritten'}).',
    );
  } on OverlaySqlException catch (error) {
    stderr.writeln('ERROR: $error');
    exit(1);
  }
}

class _Options {
  _Options({
    required this.migrationsDir,
    required this.previousVersion,
    required this.requiredTablePrefix,
  });

  final String migrationsDir;
  final String? previousVersion;
  final String requiredTablePrefix;
}

_Options _parseArgs(List<String> args) {
  var migrationsDir = 'migrations';
  String? previousVersion;
  var prefix = '';

  for (var i = 0; i < args.length; i++) {
    switch (args[i]) {
      case '--migrations-dir':
        migrationsDir = _value(args, ++i, '--migrations-dir');
      case '--previous-version':
        previousVersion = _value(args, ++i, '--previous-version');
      case '--require-table-prefix':
        prefix = _value(args, ++i, '--require-table-prefix');
      default:
        stderr.writeln('Unknown argument: ${args[i]}');
        stderr.writeln(
          'Usage: dart tool/commercial_migration_overlay.dart '
          '--migrations-dir <dir> --previous-version <version> '
          '--require-table-prefix <prefix>',
        );
        exit(2);
    }
  }

  return _Options(
    migrationsDir: migrationsDir,
    previousVersion: previousVersion,
    requiredTablePrefix: prefix,
  );
}

String _value(List<String> args, int index, String option) {
  if (index >= args.length) {
    stderr.writeln('Missing value for $option.');
    exit(2);
  }
  return args[index];
}
