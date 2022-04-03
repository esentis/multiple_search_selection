extension HelperExtensions on String? {
  /// Returns the character at [index] of the `String`.
  ///
  /// ### Example
  ///
  /// ```dart
  /// String foo1 = 'esentis';
  /// String char1 = foo1.charAt(0); // returns 'e'
  /// String char2 = foo1.charAt(4); // returns 'n'
  /// String? char3 = foo1.charAt(-20); // returns null
  /// String? char4 = foo1.charAt(20); // returns null
  /// ```
  String? charAt(int index) {
    if (this == null) {
      return null;
    }
    if (this!.isEmpty) {
      return this;
    }
    if (index > this!.length) {
      return null;
    }
    if (index < 0) {
      return null;
    }
    return this!.split('')[index];
  }
}
