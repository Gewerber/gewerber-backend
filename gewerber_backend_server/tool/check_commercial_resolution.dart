// Fail-fast guard: an image build that is supposed to ship the REAL commercial
// module must never silently resolve the public stub packages.
//
// Why this exists
// ---------------
// `gewerber_backend_server/pubspec.yaml` and `gewerber_backend_client/pubspec.yaml`
// declare the closed-source module as a git dependency on the PUBLIC
// `Gewerber/gewerber-backend-stubs` repository, so this repository resolves,
// analyzes and tests without any private access. Release image builds swap in
// the real private module by rewriting that URL through a git `insteadOf` rule
// fed from a BuildKit secret (see gewerber_backend_server/Dockerfile).
//
// That rewrite used to be conditional on the secret being mounted:
//
//   if [ -f /run/secrets/git_token ]; then <install insteadOf rule>; fi
//
// so a build without the secret (a local build, a self-hosted source build, or
// a `secrets:` block accidentally dropped from deploy.yml) skipped the rewrite
// SILENTLY: `dart pub get` resolved the stubs and the image was published with
// the stub module compiled in. Release images must insteadOf-fail.
//
// Modes
// -----
//   dart run check_commercial_resolution.dart            report only, always
//                                                         exits 0 (OSS CI, which
//                                                         resolves the stubs by
//                                                         design)
//   dart run check_commercial_resolution.dart --require  exit non-zero unless
//                                                         every module package
//                                                         this workspace needs
//                                                         resolved to the real
//                                                         private repository
//                                                         (release image builds)
//
// Run from the directory that holds `.dart_tool/package_config.json` — the
// workspace root, i.e. the repository root, or `/app` inside the image build.
//
// Why the check reads the fetched package, not its path
// ----------------------------------------------------
// A git `insteadOf` rule is applied by git itself, below pub: pub records the
// URL it was *given* and names the cache checkout after it. A release build
// that fetched the real private module therefore resolves to a path that still
// reads `.../git/gewerber-backend-stubs-<sha>/...`, so the path alone cannot
// tell a rewritten fetch from a genuine stub resolution. The fetched package's
// own `pubspec.yaml` can: it names the repository the content came from. That
// is the ground truth; the path is only a fallback for a package whose manifest
// cannot be read (in which case the guard also says so, because it cannot then
// vouch for the build).
//
// Do not "simplify" this back into a substring test on `rootUri`. The image
// build is the only place the real module is ever fetched through `insteadOf`,
// which is why that mistake stayed invisible: CI resolves the stubs, where a
// path test and a content test agree, and the guard's report-only mode exits 0
// either way. It is covered by
// `test/unit/commercial_resolution_guard_test.dart`.
//
// Why the expected set is derived from the workspace
// --------------------------------------------------
// The image build compiles a workspace containing `gewerber_backend_server`
// only, so `gewerber_backend_commercial_client` — a dependency of
// `gewerber_backend_client`, not of the server — is legitimately absent there.
// Requiring both packages regardless of the workspace made every release build
// fail on a package that is not in it. The guard therefore checks the module
// packages the *current* workspace declares, and still treats a
// declared-but-unresolved one as an error in both modes.

import 'dart:convert';
import 'dart:io';

const _privateRepoMarker = 'gewerber-backend-commercial';
const _stubsRepoMarker = 'gewerber-backend-stubs';

/// The module packages this repository depends on: the server module compiles
/// into the image binary, the client module into the generated protocol.
const _modulePackages = [
  'gewerber_backend_commercial_server',
  'gewerber_backend_commercial_client',
];

/// Where a module package ended up, judged from the resolution itself.
enum ModuleVerdict {
  /// Resolved to the real private repository.
  real,

  /// Resolved to the public stub packages.
  stub,

  /// Declared by this workspace but absent from the resolved graph. Nothing in
  /// the build could have compiled, so this is an error in both modes.
  missing,

  /// Not a dependency of this workspace (e.g. the module client in the
  /// server-only image build) — out of scope, not a failure.
  notInWorkspace,
}

/// The outcome for a single module package.
class ModuleResolution {
  const ModuleResolution(this.package, this.verdict, {this.path, this.source});

  final String package;
  final ModuleVerdict verdict;

  /// Absolute path of the resolved package, when it is in the graph.
  final String? path;

  /// The `repository:` its own pubspec declares, when readable.
  final String? source;

  bool get isFailure =>
      verdict == ModuleVerdict.stub || verdict == ModuleVerdict.missing;

  /// Whether the offending resolution is the public stubs, as opposed to some
  /// third source the guard does not recognise.
  bool get isStubs => (source ?? path ?? '').contains(_stubsRepoMarker);

  @override
  String toString() => '$package: ${verdict.name}';
}

/// The outcome of a whole check run.
class CommercialResolutionCheck {
  CommercialResolutionCheck(this.resolutions);

  final List<ModuleResolution> resolutions;

  Iterable<ModuleResolution> get failures =>
      resolutions.where((r) => r.isFailure);

  bool get ok => failures.isEmpty;

  /// The guard classified nothing at all — the workspace declares no module
  /// package. A release build must not pass on that.
  bool get nothingChecked =>
      resolutions.every((r) => r.verdict == ModuleVerdict.notInWorkspace);
}

void main(List<String> args) {
  final unknown = args
      .where((arg) => arg != '--require')
      .toList(growable: false);
  if (unknown.isNotEmpty) {
    stderr.writeln(
      'usage: dart run check_commercial_resolution.dart [--require]',
    );
    exit(64);
  }
  final requireReal = args.contains('--require');

  final CommercialResolutionCheck result;
  try {
    result = checkCommercialResolution(Directory.current);
  } on StateError catch (error) {
    stderr.writeln('ERROR: ${error.message}');
    exit(1);
  }

  for (final resolution in result.resolutions) {
    switch (resolution.verdict) {
      case ModuleVerdict.real:
        stdout.writeln('OK: ${resolution.package} -> real commercial module');
      case ModuleVerdict.stub:
        stdout.writeln('STUB: ${resolution.package}');
        stdout.writeln(
          resolution.isStubs
              ? '    This is the PUBLIC STUB package, which carries only the '
                    'minimal module contract.'
              : '    This resolved to neither the private repository nor the '
                    'public stubs, so the guard cannot vouch for it.',
        );
      case ModuleVerdict.missing:
        stderr.writeln(
          'ERROR: ${resolution.package} is declared by this workspace but is '
          'not part of the resolved dependency graph.',
        );
      case ModuleVerdict.notInWorkspace:
        stdout.writeln(
          'SKIP: ${resolution.package} is not a dependency of this workspace.',
        );
    }
    if (resolution.path != null) {
      stdout.writeln('    path: ${resolution.path}');
    }
    if (resolution.source != null) {
      stdout.writeln('    source: ${resolution.source}');
    }
  }

  final checked = result.resolutions
      .where((r) => r.verdict != ModuleVerdict.notInWorkspace)
      .toList(growable: false);

  if (result.nothingChecked) {
    stderr.writeln(
      'ERROR: this workspace declares none of the commercial module packages '
      '(${_modulePackages.join(', ')}), so the guard verified nothing. A '
      'release image must not pass on an empty check.',
    );
    exit(1);
  }

  if (result.ok) {
    stdout.writeln(
      'Commercial module resolution OK: ${checked.length} module package(s) '
      'resolved to $_privateRepoMarker.',
    );
    return;
  }

  final offenders = result.failures.map(
    (r) => '${r.package} (${r.verdict.name})',
  );

  if (!requireReal) {
    // Report-only mode: OSS CI and OSS self-hosted builds resolve the stubs on
    // purpose. Say so plainly so the choice stays visible in the build log
    // instead of being an assumption.
    stdout.writeln(
      '\nResolved the PUBLIC STUB module for: ${offenders.join(', ')}\n'
      'This is expected for open-source builds (CI, self-hosting) and is NOT '
      'acceptable in a release image.',
    );
    return;
  }

  stderr
    ..writeln(
      '\nERROR: this build requires the real commercial module, but it '
      'resolved:\n    ${offenders.join('\n    ')}',
    )
    ..writeln()
    ..writeln(
      'The git `insteadOf` rewrite in gewerber_backend_server/Dockerfile did '
      'not take effect, so `dart pub get` fell back to the public stubs. '
      'Shipping this image would publish a build with the stub module compiled '
      'in.',
    )
    ..writeln()
    ..writeln('Fix:')
    ..writeln(
      '  * CI / release build: pass the BuildKit secret to the docker build '
      '(`secrets: git_token=...` / --secret id=git_token) and make sure '
      'COMMERCIAL_REPO_TOKEN is set; the token needs read access to the private '
      '$_privateRepoMarker repository.',
    )
    ..writeln(
      '  * Intentional open-source build: pass --build-arg '
      'REQUIRE_COMMERCIAL=false, which downgrades this to a warning (see the '
      'self-hosted example).',
    );
  exit(1);
}

/// Classifies every module package in the workspace rooted at [workspaceRoot],
/// which must hold `pubspec.yaml` and `.dart_tool/package_config.json`.
CommercialResolutionCheck checkCommercialResolution(Directory workspaceRoot) {
  final configFile = File(
    _join(workspaceRoot.path, '.dart_tool', 'package_config.json'),
  );
  if (!configFile.existsSync()) {
    throw StateError(
      '${configFile.path} not found - run `dart pub get` first.',
    );
  }

  final resolvedPaths = _resolvedPackagePaths(configFile);
  final declared = _workspaceDeclaredModulePackages(workspaceRoot);

  final resolutions = <ModuleResolution>[];
  for (final package in _modulePackages) {
    if (!declared.contains(package)) {
      resolutions.add(ModuleResolution(package, ModuleVerdict.notInWorkspace));
      continue;
    }

    final path = resolvedPaths[package];
    if (path == null) {
      resolutions.add(ModuleResolution(package, ModuleVerdict.missing));
      continue;
    }

    final source = _declaredRepository(path);
    // The fetched manifest is the ground truth; the path is the fallback for a
    // package whose manifest cannot be read.
    final verdict = (source ?? path).contains(_privateRepoMarker)
        ? ModuleVerdict.real
        : ModuleVerdict.stub;
    resolutions.add(
      ModuleResolution(package, verdict, path: path, source: source),
    );
  }

  return CommercialResolutionCheck(resolutions);
}

/// `package name -> absolute directory`, with `rootUri` resolved against the
/// package config that declares it (path dependencies are relative to it).
Map<String, String> _resolvedPackagePaths(File configFile) {
  final config =
      jsonDecode(configFile.readAsStringSync()) as Map<String, Object?>;
  final packages = (config['packages'] as List<Object?>? ?? const <Object?>[])
      .cast<Map<String, Object?>>();

  final paths = <String, String>{};
  for (final package in packages) {
    final name = package['name'];
    final rootUri = package['rootUri'];
    if (name is! String || rootUri is! String) continue;
    paths[name] = configFile.uri.resolve(rootUri).toFilePath();
  }
  return paths;
}

/// The module packages the workspace rooted at [workspaceRoot] declares, read
/// from its members' manifests.
///
/// The image build writes a workspace manifest listing `gewerber_backend_server`
/// only; the repository root lists both packages. A manifest without a
/// `workspace:` key is a single-package workspace, so it is read as one.
Set<String> _workspaceDeclaredModulePackages(Directory workspaceRoot) {
  final rootPubspec = File(_join(workspaceRoot.path, 'pubspec.yaml'));
  if (!rootPubspec.existsSync()) {
    throw StateError(
      '${rootPubspec.path} not found - run the guard from the workspace root.',
    );
  }

  final members = _workspaceMembers(rootPubspec.readAsLinesSync());
  final manifests = <List<String>>[
    if (members.isEmpty)
      rootPubspec.readAsLinesSync()
    else
      for (final member in members) _readMemberManifest(workspaceRoot, member),
  ];

  return {
    for (final manifest in manifests) ..._dependencyKeys(manifest),
  };
}

List<String> _readMemberManifest(Directory workspaceRoot, String member) {
  final pubspec = File(_join(workspaceRoot.path, member, 'pubspec.yaml'));
  if (!pubspec.existsSync()) {
    throw StateError(
      'workspace member "$member" has no pubspec.yaml at ${pubspec.path}.',
    );
  }
  return pubspec.readAsLinesSync();
}

/// The `workspace:` member list of a pubspec, if it declares one.
List<String> _workspaceMembers(List<String> manifest) {
  final members = <String>[];
  var inWorkspace = false;
  for (final raw in manifest) {
    final line = _withoutComment(raw);
    if (!inWorkspace) {
      inWorkspace = line == 'workspace:';
      continue;
    }
    final match = RegExp(r'^\s+-\s*(\S+)\s*$').firstMatch(line);
    if (match != null) {
      members.add(match.group(1)!);
    } else if (line.trim().isNotEmpty) {
      inWorkspace = false;
    }
  }
  return members;
}

/// Top-level `name:` keys under the `dependencies:` / `dev_dependencies:`
/// sections of a pubspec. A module package listed in either section is a real
/// dependency of the workspace and must be in the resolved graph.
Set<String> _dependencyKeys(List<String> manifest) {
  final keys = <String>{};
  var inDependencies = false;
  for (final raw in manifest) {
    final line = _withoutComment(raw);
    if (RegExp(r'^[A-Za-z_]').hasMatch(line)) {
      inDependencies = line == 'dependencies:' || line == 'dev_dependencies:';
      continue;
    }
    if (!inDependencies) continue;
    final match = RegExp(r'^ {2}([A-Za-z_][A-Za-z0-9_]*):').firstMatch(line);
    if (match != null) keys.add(match.group(1)!);
  }
  return keys;
}

/// The `repository:` field of the resolved package's own pubspec — the
/// repository the fetched content actually came from.
String? _declaredRepository(String packageDir) {
  final pubspec = File(_join(packageDir, 'pubspec.yaml'));
  if (!pubspec.existsSync()) return null;
  final match = RegExp(
    r'^repository:[ \t]+(\S+)[ \t]*$',
    multiLine: true,
  ).firstMatch(pubspec.readAsStringSync());
  return match?.group(1);
}

String _withoutComment(String line) =>
    line.replaceFirst(RegExp(r'\s*#.*$'), '').trimRight();

/// `package:path`-free join, so the guard stays dependency-free and runs in the
/// image build without needing a package resolution of its own.
String _join(String first, String second, [String? third]) {
  var joined = first.replaceAll('\\', '/');
  for (final part in [second, ?third]) {
    if (part.isEmpty) continue;
    joined =
        '${joined.replaceAll(RegExp(r'/+$'), '')}'
        '/${part.replaceAll(RegExp(r'^/+'), '')}';
  }
  return joined;
}
