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
//                                                         resolved to the real
//                                                         private repository
//                                                         (release image builds)
//
// Run from the directory that holds `.dart_tool/package_config.json` — the
// workspace root, i.e. the repository root, or `/app` inside the image build.
//
// Sources that count as the real module:
//   * the private `Gewerber/gewerber-backend-commercial` repository, fetched
//     via git (CI and the release image build), or
//   * a local sibling checkout wired up through the gitignored
//     `pubspec_overrides.yaml` (developers with access to the private repo).
//
// Mirrors `apps/product/tool/check_commercial_resolution.dart` in the private
// gewerber-app-commercial repository, which guards the same rewrite on the app
// side. Keep both in step when the mechanism changes.

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

  final configFile = File('.dart_tool/package_config.json');
  if (!configFile.existsSync()) {
    stderr.writeln(
      'ERROR: ${configFile.path} not found - run `dart pub get` first.',
    );
    exit(1);
  }

  final config =
      jsonDecode(configFile.readAsStringSync()) as Map<String, Object?>;
  final packages = (config['packages'] as List<Object?>? ?? const <Object?>[])
      .cast<Map<String, Object?>>();

  final offenders = <String>[];
  var found = 0;

  for (final name in _modulePackages) {
    Map<String, Object?>? entry;
    for (final package in packages) {
      if (package['name'] == name) {
        entry = package;
        break;
      }
    }
    if (entry == null) {
      // The module is a hard dependency of the workspace; a resolution without
      // it could not have compiled the server at all, so treat it as an error
      // in both modes rather than a silent pass.
      stderr.writeln(
        'ERROR: $name is not part of the resolved dependency graph.',
      );
      offenders.add('$name (missing)');
      continue;
    }
    found++;

    final resolved = Uri.parse(entry['rootUri'] as String)
        .normalizePath()
        .toString();
    final isStubs = resolved.contains(_stubsRepoMarker);

    if (resolved.contains(_privateRepoMarker)) {
      stdout.writeln('OK: $name -> real commercial module\n    $resolved');
      continue;
    }

    stdout.writeln('STUB: $name -> $resolved');
    offenders.add(name);
    if (isStubs) {
      stdout.writeln(
        '    This is the PUBLIC STUB package, which carries only the minimal '
        'module contract.',
      );
    }
  }

  if (offenders.isEmpty) {
    stdout.writeln(
      'Commercial module resolution OK: $found/${_modulePackages.length} '
      'module package(s) resolved to $_privateRepoMarker.',
    );
    return;
  }

  if (!requireReal) {
    // Report-only mode: OSS CI and OSS self-hosted builds resolve the stubs on
    // purpose. Say so plainly so the choice is visible in the build log instead
    // of being an assumption.
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
