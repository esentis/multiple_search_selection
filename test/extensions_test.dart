import 'package:flutter_test/flutter_test.dart';
import 'package:multiple_search_selection/src/helpers/extensions.dart';

void main() {
  group('charAt', () {
    test('returns correct character at valid index', () {
      expect('esentis'.charAt(0), 'e');
      expect('esentis'.charAt(4), 't'); // e(0) s(1) e(2) n(3) t(4) i(5) s(6)
      expect('esentis'.charAt(6), 's');
    });

    test('returns null for negative index', () {
      expect('esentis'.charAt(-1), isNull);
      expect('esentis'.charAt(-20), isNull);
    });

    test('returns null for index equal to length (off-by-one boundary)', () {
      const s = 'abc'; // length 3, valid indices: 0, 1, 2
      expect(s.charAt(3), isNull); // was throwing RangeError before fix
    });

    test('returns null for index greater than length', () {
      expect('abc'.charAt(10), isNull);
      expect('abc'.charAt(20), isNull);
    });

    test('returns null for null string', () {
      const String? s = null;
      expect(s.charAt(0), isNull);
    });

    test('returns empty string for empty string (no valid index exists)', () {
      // isEmpty guard returns '' for any index on an empty string
      expect(''.charAt(0), '');
      expect(''.charAt(5), '');
    });

    test('handles single-character string', () {
      expect('x'.charAt(0), 'x');
      expect('x'.charAt(1), isNull);
    });

    test('handles last valid index correctly', () {
      const s = 'hello';
      expect(s.charAt(4), 'o'); // last character
      expect(s.charAt(5), isNull); // one past the end
    });
  });
}
