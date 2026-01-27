import 'dart:math';

/// List Extensions
/// Utility extension methods for List class
extension ListExtensions<T> on List<T> {
  //═══════════════════════════════════════════════════════════════
  // SAFE ACCESS
  //═══════════════════════════════════════════════════════════════

  /// Get element at index or null if out of bounds
  T? getOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Get first element or null if empty
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null if empty
  T? get lastOrNull => isEmpty ? null : last;

  //═══════════════════════════════════════════════════════════════
  // MANIPULATION
  //═══════════════════════════════════════════════════════════════

  /// Get random element
  T? get random {
    if (isEmpty) return null;
    return this[Random().nextInt(length)];
  }

  /// Get n random elements
  List<T> randomElements(int n) {
    if (isEmpty || n <= 0) return [];
    final shuffled = List<T>.from(this)..shuffle();
    return shuffled.take(n).toList();
  }

  /// Shuffle and return new list
  List<T> get shuffled {
    final list = List<T>.from(this);
    list.shuffle();
    return list;
  }

  /// Get unique elements
  List<T> get unique => toSet().toList();

  /// Get unique elements by key
  List<T> uniqueBy<K>(K Function(T) keyExtractor) {
    final seen = <K>{};
    return where((element) => seen.add(keyExtractor(element))).toList();
  }

  /// Split list into chunks
  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, min(i + size, length)));
    }
    return chunks;
  }

  /// Separate list into two based on condition
  (List<T>, List<T>) partition(bool Function(T) test) {
    final matching = <T>[];
    final nonMatching = <T>[];
    for (final element in this) {
      if (test(element)) {
        matching.add(element);
      } else {
        nonMatching.add(element);
      }
    }
    return (matching, nonMatching);
  }

  //═══════════════════════════════════════════════════════════════
  // SEARCH & FILTER
  //═══════════════════════════════════════════════════════════════

  /// Find first element matching condition or null
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  /// Find last element matching condition or null
  T? lastWhereOrNull(bool Function(T) test) {
    for (var i = length - 1; i >= 0; i--) {
      if (test(this[i])) return this[i];
    }
    return null;
  }

  /// Find index of element matching condition or -1
  int indexWhereOrMinus1(bool Function(T) test) {
    for (var i = 0; i < length; i++) {
      if (test(this[i])) return i;
    }
    return -1;
  }

  /// Check if any element matches condition
  bool containsWhere(bool Function(T) test) {
    return any(test);
  }

  /// Count elements matching condition
  int countWhere(bool Function(T) test) {
    var count = 0;
    for (final element in this) {
      if (test(element)) count++;
    }
    return count;
  }

  //═══════════════════════════════════════════════════════════════
  // TRANSFORMATION
  //═══════════════════════════════════════════════════════════════

  /// Map with index
  List<R> mapIndexed<R>(R Function(int index, T element) convert) {
    final result = <R>[];
    for (var i = 0; i < length; i++) {
      result.add(convert(i, this[i]));
    }
    return result;
  }

  /// ForEach with index
  void forEachIndexed(void Function(int index, T element) action) {
    for (var i = 0; i < length; i++) {
      action(i, this[i]);
    }
  }

  /// Where with index
  List<T> whereIndexed(bool Function(int index, T element) test) {
    final result = <T>[];
    for (var i = 0; i < length; i++) {
      if (test(i, this[i])) {
        result.add(this[i]);
      }
    }
    return result;
  }

  //═══════════════════════════════════════════════════════════════
  // SORTING
  //═══════════════════════════════════════════════════════════════

  /// Sort by key and return new list
  List<T> sortedBy<K extends Comparable>(K Function(T) keyExtractor) {
    final list = List<T>.from(this);
    list.sort((a, b) => keyExtractor(a).compareTo(keyExtractor(b)));
    return list;
  }

  /// Sort descending by key and return new list
  List<T> sortedByDescending<K extends Comparable>(K Function(T) keyExtractor) {
    final list = List<T>.from(this);
    list.sort((a, b) => keyExtractor(b).compareTo(keyExtractor(a)));
    return list;
  }

  //═══════════════════════════════════════════════════════════════
  // AGGREGATION
  //═══════════════════════════════════════════════════════════════

  /// Group elements by key
  Map<K, List<T>> groupBy<K>(K Function(T) keyExtractor) {
    final map = <K, List<T>>{};
    for (final element in this) {
      final key = keyExtractor(element);
      map.putIfAbsent(key, () => []).add(element);
    }
    return map;
  }

  /// Associate elements with keys
  Map<K, T> associateBy<K>(K Function(T) keyExtractor) {
    final map = <K, T>{};
    for (final element in this) {
      map[keyExtractor(element)] = element;
    }
    return map;
  }

  //═══════════════════════════════════════════════════════════════
  // JOINING
  //═══════════════════════════════════════════════════════════════

  /// Join with separator (for non-String lists)
  String joinWith(String separator, [String Function(T)? transform]) {
    if (transform != null) {
      return map(transform).join(separator);
    }
    return map((e) => e.toString()).join(separator);
  }

  /// Add separator between elements
  List<T> intersperse(T separator) {
    if (length <= 1) return List.from(this);
    final result = <T>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) {
        result.add(separator);
      }
    }
    return result;
  }
}

/// Nullable List Extensions
extension NullableListExtensions<T> on List<T>? {
  /// Check if null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Check if not null and not empty
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  /// Return empty list if null
  List<T> get orEmpty => this ?? [];

  /// Return list length or 0 if null
  int get lengthOrZero => this?.length ?? 0;
}
