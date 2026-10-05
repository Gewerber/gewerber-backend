import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

import '../../tool/check_commercial_resolution.dart';

void main() {
  group('checkCommercialResolution', () {
    test(
      'a real module fetched through insteadOf is judged real, not a stub',
      () {
        // The regression this guard shipped with: a release build rewrites the
        // stubs URL with a git `insteadOf` rule, so pub caches the private
        // checkout under the *stubs* slug. Judging the resolution by path made
        // every release build fail.
        final workspace = _Workspace(members: ['gewerber_backend_server']);
        workspace.addMemberDependency(
          'gewerber_backend_server',
          'gewerber_backend_commercial_server',
        );
        workspace.resolveModule(
          'gewerber_backend_commercial_server',
          cacheSlug: 'gewerber-backend-stubs-1b9e83c848619a35ac056c2ae54d254e',
          repository: 'https://github.com/Gewerber/gewerber-backend-commercial',
        );

        final result = checkCommercialResolution(workspace.root);

        expect(
          result.resolutions
              .singleWhere(
                (r) => r.package == 'gewerber_backend_commercial_server',
              )
              .verdict,
          ModuleVerdict.real,
          reason: 'the fetched manifest, not the cache slug, is the truth',
        );
        expect(result.ok, isTrue);
      },
    );

    test('a genuine stub resolution is reported as a stub', () {
      final workspace = _Workspace(members: ['gewerber_backend_client']);
      workspace.addMemberDependency(
        'gewerber_backend_client',
        'gewerber_backend_commercial_client',
      );
      workspace.resolveModule(
        'gewerber_backend_commercial_client',
        cacheSlug: 'gewerber-backend-stubs-c8ad242e8cf5da1a77142e8737413b0e',
        repository: 'https://github.com/Gewerber/gewerber-backend-stubs',
      );

      final result = checkCommercialResolution(workspace.root);

      final client = result.resolutions.singleWhere(
        (r) => r.package == 'gewerber_backend_commercial_client',
      );
      expect(client.verdict, ModuleVerdict.stub);
      expect(result.ok, isFalse, reason: 'a release build must fail on stubs');
    });

    test('a package outside the workspace is out of scope, not a failure', () {
      // The image build compiles a server-only workspace: the module *client*
      // is a dependency of gewerber_backend_client, which the image does not
      // build. Requiring it anyway failed every release build.
      final workspace = _Workspace(members: ['gewerber_backend_server']);
      workspace.addMemberDependency(
        'gewerber_backend_server',
        'gewerber_backend_commercial_server',
      );
      workspace.resolveModule(
        'gewerber_backend_commercial_server',
        cacheSlug: 'gewerber-backend-stubs-1b9e83c848619a35ac056c2ae54d254e',
        repository: 'https://github.com/Gewerber/gewerber-backend-commercial',
      );

      final result = checkCommercialResolution(workspace.root);

      expect(
        result.resolutions
            .singleWhere(
              (r) => r.package == 'gewerber_backend_commercial_client',
            )
            .verdict,
        ModuleVerdict.notInWorkspace,
      );
      expect(result.ok, isTrue);
    });

    test('the repository root checks both module packages', () {
      final workspace = _Workspace(
        members: [
          'gewerber_backend_client',
          'gewerber_backend_server',
        ],
      );
      workspace
        ..addMemberDependency(
          'gewerber_backend_client',
          'gewerber_backend_commercial_client',
        )
        ..addMemberDependency(
          'gewerber_backend_server',
          'gewerber_backend_commercial_server',
        )
        ..resolveModule(
          'gewerber_backend_commercial_server',
          cacheSlug: 'gewerber-backend-stubs-c8ad242e8cf5da1a77142e8737413b0e',
          repository: 'https://github.com/Gewerber/gewerber-backend-stubs',
        )
        ..resolveModule(
          'gewerber_backend_commercial_client',
          cacheSlug: 'gewerber-backend-stubs-c8ad242e8cf5da1a77142e8737413b0e',
          repository: 'https://github.com/Gewerber/gewerber-backend-stubs',
        );

      final result = checkCommercialResolution(workspace.root);

      expect(result.resolutions, hasLength(2));
      expect(
        result.resolutions.map((r) => r.verdict),
        everyElement(ModuleVerdict.stub),
      );
    });

    test('a declared module package missing from the graph is a failure', () {
      final workspace = _Workspace(members: ['gewerber_backend_server']);
      workspace.addMemberDependency(
        'gewerber_backend_server',
        'gewerber_backend_commercial_server',
      );

      final result = checkCommercialResolution(workspace.root);

      expect(
        result.resolutions
            .singleWhere(
              (r) => r.package == 'gewerber_backend_commercial_server',
            )
            .verdict,
        ModuleVerdict.missing,
        reason: 'nothing in the build could have compiled without it',
      );
      expect(result.ok, isFalse);
    });

    test('a sibling checkout override resolves to the real module', () {
      final workspace = _Workspace(members: ['gewerber_backend_server']);
      workspace
        ..addMemberDependency(
          'gewerber_backend_server',
          'gewerber_backend_commercial_server',
        )
        ..resolveModuleAt(
          'gewerber_backend_commercial_server',
          repository: 'https://github.com/Gewerber/gewerber-backend-commercial',
        );

      final result = checkCommercialResolution(workspace.root);

      expect(
        result.resolutions
            .singleWhere(
              (r) => r.package == 'gewerber_backend_commercial_server',
            )
            .verdict,
        ModuleVerdict.real,
        reason: 'rootUri must be resolved against the package config',
      );
    });

    test('an unreadable module manifest falls back to the resolved path', () {
      final workspace = _Workspace(members: ['gewerber_backend_server']);
      workspace
        ..addMemberDependency(
          'gewerber_backend_server',
          'gewerber_backend_commercial_server',
        )
        // No pubspec.yaml written, so provenance must come from the path.
        ..resolveModule(
          'gewerber_backend_commercial_server',
          cacheSlug: 'gewerber-backend-stubs-c8ad242e8cf5da1a77142e8737413b0e',
          repository: null,
        );

      final result = checkCommercialResolution(workspace.root);

      final server = result.resolutions.singleWhere(
        (r) => r.package == 'gewerber_backend_commercial_server',
      );
      expect(server.source, isNull);
      expect(server.verdict, ModuleVerdict.stub);
    });

    test('a workspace that declares no module package checks nothing', () {
      final workspace = _Workspace(members: ['gewerber_backend_server']);

      final result = checkCommercialResolution(workspace.root);

      expect(result.nothingChecked, isTrue);
      expect(result.ok, isTrue, reason: 'no verdict failed — but nothing ran');
    });

    test('a missing package_config.json is reported, not thrown', () {
      final root = Directory.systemTemp.createTempSync('commercial_guard');
      addTearDown(() => root.deleteSync(recursive: true));

      expect(
        () => checkCommercialResolution(root),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('package_config.json'),
          ),
        ),
      );
    });
  });
}

/// A throwaway Dart workspace on disk: a root manifest, member manifests and a
/// `package_config.json`, laid out the way `dart pub get` would.
///
/// The workspace root is `<temp>/workspace`, so a `pubspec_overrides.yaml` path
/// dependency can be modelled as a sibling checkout under `<temp>`.
class _Workspace {
  _Workspace({required List<String> members})
    : base = Directory.systemTemp.createTempSync('commercial_guard') {
    root = Directory('${base.path}/workspace')..createSync(recursive: true);
    addTearDown(() => base.deleteSync(recursive: true));
    _write(root, 'pubspec.yaml', [
      'name: _',
      'environment:',
      "  sdk: ^3.13.3",
      'workspace:',
      for (final member in members) '  - $member',
      '',
    ]);
    for (final member in members) {
      _write(Directory('${root.path}/$member'), 'pubspec.yaml', [
        'name: $member',
        'resolution: workspace',
        '',
      ]);
    }
    _updatePackageConfig();
  }

  final Directory base;
  late final Directory root;
  final Map<String, _ResolvedPackage> _resolved = {};

  void addMemberDependency(String member, String dependency) {
    _write(Directory('${root.path}/$member'), 'pubspec.yaml', [
      'name: $member',
      'resolution: workspace',
      'dependencies:',
      '  $dependency:',
      '    git:',
      '      url: https://github.com/Gewerber/gewerber-backend-stubs.git',
      '      ref: develop',
      '',
    ]);
  }

  /// Resolves a module package from the pub git cache. Pub names that checkout
  /// after the URL it was *given* — the stubs slug — even when a git `insteadOf`
  /// rule served the private repository. Pass `repository: null` to leave the
  /// fetched package without a readable manifest.
  void resolveModule(
    String package, {
    required String cacheSlug,
    required String? repository,
  }) {
    final dir = Directory('${root.path}/.pub-cache/git/$cacheSlug/$package');
    if (repository != null) {
      _write(dir, 'pubspec.yaml', [
        'name: $package',
        'repository: $repository',
        '',
      ]);
    }
    _resolved[package] = _ResolvedPackage(
      dir,
      // Written relative to .dart_tool/, exactly as pub does.
      rootUri: '../.pub-cache/git/$cacheSlug/$package',
    );
    _updatePackageConfig();
  }

  /// Resolves a module package through a `pubspec_overrides.yaml` path
  /// dependency onto a sibling checkout of the private repository.
  void resolveModuleAt(
    String package, {
    required String repository,
  }) {
    const repositoryName = 'gewerber-backend-commercial';
    final dir = Directory('${base.path}/$repositoryName/$package');
    _write(dir, 'pubspec.yaml', [
      'name: $package',
      'repository: $repository',
      '',
    ]);
    _resolved[package] = _ResolvedPackage(
      dir,
      rootUri: '../../$repositoryName/$package',
    );
    _updatePackageConfig();
  }

  void _updatePackageConfig() {
    _write(Directory('${root.path}/.dart_tool'), 'package_config.json', [
      const JsonEncoder.withIndent('  ').convert({
        'configVersion': 2,
        'packages': [
          for (final entry in _resolved.entries)
            {
              'name': entry.key,
              'rootUri': entry.value.rootUri,
              'packageUri': 'lib/',
              'languageVersion': '3.13',
            },
        ],
      }),
    ]);
  }

  static void _write(Directory dir, String name, List<String> lines) {
    dir.createSync(recursive: true);
    File('${dir.path}/$name').writeAsStringSync('${lines.join('\n')}\n');
  }
}

class _ResolvedPackage {
  const _ResolvedPackage(this.directory, {required this.rootUri});

  final Directory directory;
  final String rootUri;
}
