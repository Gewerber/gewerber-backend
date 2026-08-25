import 'package:gewerber_backend_server/src/modules/dashboard/domain/month_bucketing.dart';
import 'package:test/test.dart';

void main() {
  group('utcMonthStart', () {
    test('truncates to UTC midnight of the first day', () {
      expect(
        utcMonthStart(DateTime.utc(2026, 8, 24, 13, 37, 123)),
        DateTime.utc(2026, 8, 1),
      );
      // A local (non-UTC) instant still maps onto its own calendar month.
      expect(
        utcMonthStart(DateTime(2026, 2, 14, 23, 59)),
        DateTime.utc(2026, 2),
      );
    });

    test('maps January 1st and December 31st correctly', () {
      expect(utcMonthStart(DateTime.utc(2026, 1, 1)), DateTime.utc(2026, 1));
      expect(
        utcMonthStart(DateTime.utc(2026, 12, 31, 23, 59, 59, 999)),
        DateTime.utc(2026, 12),
      );
    });
  });

  group('shiftUtcMonths', () {
    test('rolls over December -> January of the next year', () {
      expect(shiftUtcMonths(DateTime.utc(2026, 12), 1), DateTime.utc(2027, 1));
      expect(shiftUtcMonths(DateTime.utc(2027, 1), -1), DateTime.utc(2026, 12));
    });

    test('survives multi-year shifts', () {
      expect(shiftUtcMonths(DateTime.utc(2026, 3), -36), DateTime.utc(2023, 3));
      expect(shiftUtcMonths(DateTime.utc(2024, 2), 25), DateTime.utc(2026, 3));
    });
  });

  group('utcMonthEnd', () {
    test('is exclusive: last day 23:59 belongs to the bucket', () {
      final start = DateTime.utc(2026, 8);
      final end = utcMonthEnd(start);
      expect(end, DateTime.utc(2026, 9));
      expect(start.isBefore(end), isTrue);
      expect(
        DateTime.utc(2026, 8, 31, 23, 59, 59, 999).isBefore(end),
        isTrue,
      );
      expect(end.isBefore(DateTime.utc(2026, 9, 1, 0, 0, 0, 1)), isTrue);
    });

    test('handles leap-year February', () {
      expect(utcMonthEnd(DateTime.utc(2024, 2)), DateTime.utc(2024, 3));
    });

    test('handles non-leap February', () {
      expect(utcMonthEnd(DateTime.utc(2025, 2)), DateTime.utc(2025, 3));
    });

    test('handles year end', () {
      expect(utcMonthEnd(DateTime.utc(2026, 12)), DateTime.utc(2027, 1));
    });
  });

  group('lastUtcMonthStarts', () {
    test('N=1 yields only the anchor month', () {
      expect(lastUtcMonthStarts(DateTime.utc(2026, 8, 24), 1), [
        DateTime.utc(2026, 8),
      ]);
    });

    test('N=12 spans a full year oldest-first including the current month', () {
      final starts = lastUtcMonthStarts(DateTime.utc(2026, 8, 24), 12);
      expect(starts, hasLength(12));
      expect(starts.first, DateTime.utc(2025, 9));
      expect(starts.last, DateTime.utc(2026, 8));
      expect(
        starts,
        orderedEquals([
          for (var m = 9; m <= 20; m++)
            DateTime.utc(2025 + (m - 1) ~/ 12, (m - 1) % 12 + 1),
        ]),
      );
    });

    test('crossing a year boundary stays chronological', () {
      final starts = lastUtcMonthStarts(DateTime.utc(2026, 2, 1), 4);
      expect(starts, [
        DateTime.utc(2025, 11),
        DateTime.utc(2025, 12),
        DateTime.utc(2026, 1),
        DateTime.utc(2026, 2),
      ]);
    });

    test('every consecutive pair is exactly one month apart', () {
      for (var n = 1; n <= 12; n++) {
        final starts = lastUtcMonthStarts(DateTime.utc(2026, 8, 24), n);
        expect(starts, hasLength(n), reason: 'count=$n');
        for (var i = 1; i < starts.length; i++) {
          expect(
            starts[i],
            utcMonthEnd(starts[i - 1]),
            reason: 'count=$n i=$i',
          );
        }
      }
    });
  });
}
