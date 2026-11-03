#!/usr/bin/env dart

/// Assert that committed migrations are in sync with the resolved modules.
///
/// Serverpod does not apply a module's own migrations at runtime. Instead,
/// `serverpod create-migration` merges the schema of every dependent module
/// (taken from that module's latest committed migration) into the *project's*
/// migration, and records the module's version in `serverpod_migrations` when
/// the project migration is applied.
///
/// That makes the project's migration chain a snapshot of the module schema as
/// it was at generation time. When a module ships a newer migration, the
/// generated Dart model declares tables or columns the committed SQL never
/// creates, and the server fails at runtime (the startup integrity check only
/// turns that into a hard failure in `development` run mode).
///
/// This script reads the module versions recorded by the latest project
/// migration and compares each one with the latest migration the resolved
/// module package actually ships. A mismatch means the chain is stale and
/// `serverpod create-migration` must be run again and the result committed.
///
/// Usage:
///   dart tool/check_module_schema_versions.dart <migrations-dir> <package-config> [module-server-pkg ...]
///
///   migrations-dir     e.g. gewerber_backend_server/migrations
///   package-config     e.g. .dart_tool/package_config.json
///   module-server-pkg  optional; when omitted, every module recorded by the
///                      latest migration is checked. Pass one or more package
///                      names (e.g. gewerber_backend_commercial_server) to
///                      restrict the check.
///
/// Package lookup: a module named `foo` resolves to the `foo_server` package
/// when that exists (Serverpod's convention for module server packages),
/// otherwise to `foo`. The project's own module is always skipped: its
/// migrations are the chain being inspected.
library;

import 'dart:convert';
import 'dart:io';

final _migrationVersion = RegExp(r'^\d{17}');

void _die(String message) {
  stderr.writeln(message);
  exit(1);
}

String _basename(Directory directory) {
  final segments = directory.uri.pathSegments.where((s) => s.isNotEmpty);
  return segments.isEmpty ? '' : segments.last;
}

/// Resolves every package name to its on-disk root via the package config.
Map<String, Directory> _packageRoots(File packageConfig) {
  final decoded = jsonDecode(packageConfig.readAsStringSync());
  final packages = (decoded as Map<String, dynamic>)['packages'] as List;
  final baseUri = packageConfig.absolute.uri;
  final roots = <String, Directory>{};
  for (final entry in packages) {
    final package = entry as Map<String, dynamic>;
    final rootUri = Uri.parse(package['rootUri'] as String);
    final resolved = rootUri.hasScheme ? rootUri : baseUri.resolveUri(rootUri);
    final directory = Directory.fromUri(resolved);
    if (!directory.existsSync()) {
      _die('::error::resolved package root does not exist: ${directory.path}');
    }
    roots[package['name'] as String] = directory;
  }
  return roots;
}

/// The migration versions a module package ships.
Set<String> _migrationVersions(Directory packageDirectory) {
  final migrations = Directory('${packageDirectory.path}/migrations');
  if (!migrations.existsSync()) return {};
  return migrations
      .listSync()
      .whereType<Directory>()
      .map(_basename)
      .where(_migrationVersion.hasMatch)
      .toSet();
}

/// Sorted project migration directories under [migrationsDir].
List<Directory> _projectMigrations(Directory migrationsDir) {
  final versions =
      migrationsDir
          .listSync()
          .whereType<Directory>()
          .where(
            (directory) => _migrationVersion.hasMatch(_basename(directory)),
          )
          .toList()
        ..sort((a, b) => _basename(a).compareTo(_basename(b)));
  return versions;
}

String? _resolveModulePackage(String module, Map<String, Directory> roots) {
  for (final candidate in ['${module}_server', module]) {
    if (roots.containsKey(candidate)) return candidate;
  }
  return null;
}

void main(List<String> args) {
  if (args.length < 2) {
    stderr.writeln(
      'Usage: dart tool/check_module_schema_versions.dart '
      '<migrations-dir> <package-config> [module-server-pkg ...]',
    );
    exit(2);
  }

  final migrationsDir = Directory(args[0]);
  final packageConfig = File(args[1]);
  final requested = args.sublist(2);

  final versions = _projectMigrations(migrationsDir);
  if (versions.isEmpty) {
    _die('::error::no project migrations found in ${migrationsDir.path}');
  }
  final latest = versions.last;
  final latestName = _basename(latest);

  final definitionFile = File('${latest.path}/definition.json');
  if (!definitionFile.existsSync()) {
    _die('::error::missing ${definitionFile.path}');
  }
  final definition =
      jsonDecode(definitionFile.readAsStringSync()) as Map<String, dynamic>;

  final projectModule = definition['moduleName'] as String?;
  final installed = <String, String>{
    for (final entry in (definition['installedModules'] as List? ?? const []))
      if ((entry as Map<String, dynamic>)['module'] != projectModule)
        entry['module'] as String: entry['version'] as String,
  };
  if (installed.isEmpty) {
    stdout.writeln('$latestName records no module versions; nothing to check.');
    return;
  }

  final roots = _packageRoots(packageConfig);

  late final Map<String, String> modules;
  if (requested.isNotEmpty) {
    final wanted = requested.toSet();
    final known = {
      ...installed.keys,
      for (final module in installed.keys) '${module}_server',
    };
    final unknown = wanted.difference(known);
    if (unknown.isNotEmpty) {
      _die(
        '::error::module packages not recorded by $latestName: '
        '${(unknown.toList()..sort()).join(', ')}',
      );
    }
    modules = {
      for (final entry in installed.entries)
        if (wanted.contains('${entry.key}_server') ||
            wanted.contains(entry.key))
          entry.key: entry.value,
    };
  } else {
    modules = installed;
  }

  final stale = <String>[];
  for (final module in (modules.keys.toList()..sort())) {
    final recorded = modules[module]!;
    final package = _resolveModulePackage(module, roots);
    if (package == null) {
      stale.add(
        '$module=$recorded (no resolved package; expected ${module}_server '
        'or $module)',
      );
      continue;
    }
    final shipped = _migrationVersions(roots[package]!);
    if (shipped.isEmpty) {
      stale.add(
        '$module=$recorded (resolved package $package ships no migrations, so '
        'the recorded version cannot be verified)',
      );
    } else {
      final latestShipped = (shipped.toList()..sort()).last;
      if (recorded != latestShipped) {
        stale.add('$module=$recorded (module latest: $latestShipped)');
      }
    }
  }

  if (stale.isNotEmpty) {
    stdout.writeln(stale.join('\n'));
    _die(
      '::error::the latest project migration does not record the latest '
      'migration of every resolved module, so the committed SQL is a stale '
      'copy of the module schema. Run `serverpod generate` and '
      '`serverpod create-migration` against the current modules, then commit '
      'the result.',
    );
  }

  final checked = (modules.keys.toList()..sort())
      .map((module) => '$module=${modules[module]}')
      .join(', ');
  stdout.writeln('$latestName records the latest migration of: $checked.');
}
