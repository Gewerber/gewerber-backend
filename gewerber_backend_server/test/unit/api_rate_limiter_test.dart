import 'package:gewerber_backend_server/src/core/rate_limit/api_rate_limiter.dart';
import 'package:test/test.dart';

void main() {
  group('buildRateLimitKey', () {
    test('keys authenticated callers by user', () {
      expect(
        buildRateLimitKey(userIdentifier: 'user-123', ipAddress: '1.2.3.4'),
        'user:user-123',
      );
    });

    test('keys anonymous callers by IP', () {
      expect(buildRateLimitKey(ipAddress: '1.2.3.4'), 'ip:1.2.3.4');
    });

    test('falls back to unknown IP when nothing is known', () {
      expect(buildRateLimitKey(), 'ip:unknown');
      expect(buildRateLimitKey(ipAddress: '  '), 'ip:unknown');
    });

    test('blank user identifiers fall back to IP', () {
      expect(
        buildRateLimitKey(userIdentifier: '  ', ipAddress: '1.2.3.4'),
        'ip:1.2.3.4',
      );
    });
  });

  group('RateLimitedOperation', () {
    test('every operation has a positive budget and window', () {
      for (final operation in RateLimitedOperation.values) {
        expect(operation.maxAttempts, greaterThan(0));
        expect(operation.timeframe, greaterThan(Duration.zero));
        expect(operation.source, isNotEmpty);
      }
    });

    test('sources are unique (no shared limiter buckets)', () {
      final sources = RateLimitedOperation.values.map((o) => o.source);
      expect(sources.toSet(), hasLength(RateLimitedOperation.values.length));
    });

    test('reminder sends are throttled tighter than PDF renders', () {
      expect(
        RateLimitedOperation.reminderSend.maxAttempts,
        lessThan(RateLimitedOperation.invoicePdf.maxAttempts),
      );
    });
  });

  test('ApiRateLimiter uses its own domain', () {
    expect(ApiRateLimiter.domain, 'gewerber');
  });
}
