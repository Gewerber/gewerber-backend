// Regenerates the committed XRechnung golden fixtures.
//
// Usage (from `gewerber_backend_server/`):
//
//     dart run tool/generate_xrechnung_fixtures.dart
//
// The six input cases live in `test/fixtures/xrechnung/xrechnung_fixture_cases.dart`
// and are shared with `test/unit/xrechnung_golden_test.dart`, which pins the
// serializer output against the files written here, byte for byte.
//
// Overwriting these fixtures is a deliberate, reviewable change: it is the
// only sanctioned way to accept a serializer behaviour change. Run this
// script only when the change is intended, and review the fixture diff as
// part of the PR — do not add it to any automatic build step.
//
// The script resolves the output directory relative to its own location
// (`Platform.script`), so it works from any working directory; the usage line
// above just mirrors the package convention.
import 'dart:io';

// Shared with the golden test: the single source of truth for the fixture
// inputs. Relative import on purpose — files outside `lib/` cannot be reached
// via a `package:` URI.
import '../test/fixtures/xrechnung/xrechnung_fixture_cases.dart';

void main() {
  // <pkg>/tool/this.dart -> <pkg> ; fixtures live in <pkg>/test/fixtures/xrechnung.
  final packageRoot = File.fromUri(Platform.script).parent.parent;
  final fixtureDir = Directory(
    '${packageRoot.path}/test/fixtures/xrechnung',
  )..createSync(recursive: true);

  final fixtures = buildXrechnungFixtures();
  for (final entry in fixtures.entries) {
    final file = File('${fixtureDir.path}/${entry.key}.xml')
      ..writeAsStringSync(entry.value);
    stdout.writeln('wrote ${file.path}');
  }
}
