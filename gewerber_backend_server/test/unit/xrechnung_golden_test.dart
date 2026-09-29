// Golden test: pins the XRechnung serializer output byte-for-byte.
//
// Purpose: this is the *regression net*, distinct from the KoSIT validation
// (`tool/validate_xrechnung.sh`), which is the *spec-conformance net*. The
// goldens deliberately capture the full serialization — whitespace, element
// order, formatting — so any behaviour change in the serializer forces a
// deliberate, reviewable refresh of the committed fixtures via
// `dart run tool/generate_xrechnung_fixtures.dart`. If a test here fails,
// either the serializer changed unintentionally (fix the code) or
// intentionally (regenerate the fixtures and review their diff).
//
// Inputs come from `test/fixtures/xrechnung/xrechnung_fixture_cases.dart`,
// shared with the generator, so the test cannot drift from the fixtures'
// inputs. Comparison is on the raw strings — no trailing-newline or other
// normalization.
import 'dart:io';

import 'package:test/test.dart';

import '../fixtures/xrechnung/xrechnung_fixture_cases.dart';

void main() {
  const fixtureNames = {
    'standard',
    'reduced',
    'zero',
    'reverse_charge',
    'kleinunternehmer',
    'credit_note',
  };

  group('XRechnung golden fixtures', () {
    test('shared cases cover exactly the six committed fixtures', () {
      expect(buildXrechnungFixtures().keys.toSet(), equals(fixtureNames));
    });

    for (final name in fixtureNames) {
      test('$name matches the committed fixture byte for byte', () {
        final actual = buildXrechnungFixtures()[name];
        final golden = File(
          'test/fixtures/xrechnung/$name.xml',
        ).readAsStringSync();

        expect(
          actual,
          equals(golden),
          reason:
              'test/fixtures/xrechnung/$name.xml is out of date or the '
              'serializer regressed; regenerate with '
              'dart run tool/generate_xrechnung_fixtures.dart and review the '
              'fixture diff',
        );
      });
    }
  });
}
