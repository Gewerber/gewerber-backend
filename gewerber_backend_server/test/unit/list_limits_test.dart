import 'package:gewerber_backend_server/src/core/pagination/list_limits.dart';
import 'package:test/test.dart';

void main() {
  group('clampListLimit', () {
    test('defaults to $defaultListLimit when no limit is given', () {
      expect(clampListLimit(null), 100);
    });

    test('keeps limits within the allowed page size', () {
      expect(clampListLimit(1), 1);
      expect(clampListLimit(50), 50);
      expect(clampListLimit(maxListLimit), 200);
    });

    test('caps requests above the maximum at $maxListLimit', () {
      expect(clampListLimit(201), 200);
      expect(clampListLimit(500), 200);
      expect(clampListLimit(1 << 31), 200);
    });

    test('honors an explicit zero but treats negative values as absent', () {
      expect(clampListLimit(0), 0);
      expect(clampListLimit(-1), 100);
      expect(clampListLimit(-500), 100);
    });
  });
}
