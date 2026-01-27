/// String Extensions
/// Utility extension methods for String class
extension StringExtensions on String {
  //═══════════════════════════════════════════════════════════════
  // VALIDATION
  //═══════════════════════════════════════════════════════════════

  /// Check if string is a valid email
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Check if string is a valid phone number
  bool get isValidPhone {
    final phoneRegex = RegExp(r'^\+?[\d\s-]{10,}$');
    return phoneRegex.hasMatch(this);
  }

  /// Check if string is a valid URL
  bool get isValidUrl {
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    return urlRegex.hasMatch(this);
  }

  /// Check if string contains only numbers
  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  /// Check if string is empty or whitespace
  bool get isBlank {
    return trim().isEmpty;
  }

  /// Check if string is not empty and not whitespace
  bool get isNotBlank {
    return trim().isNotEmpty;
  }

  //═══════════════════════════════════════════════════════════════
  // TRANSFORMATION
  //═══════════════════════════════════════════════════════════════

  /// Capitalize first letter
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  /// Capitalize first letter of each word
  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Convert to title case
  String get toTitleCase {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.isEmpty
            ? ''
            : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}')
        .join(' ');
  }

  /// Convert to slug format
  String get toSlug {
    return toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .trim();
  }

  /// Remove all whitespace
  String get removeWhitespace {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Remove extra whitespace (multiple spaces to single)
  String get normalizeWhitespace {
    return replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Reverse the string
  String get reverse {
    return split('').reversed.join('');
  }

  //═══════════════════════════════════════════════════════════════
  // TRUNCATION
  //═══════════════════════════════════════════════════════════════

  /// Truncate string with ellipsis
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }

  /// Truncate at word boundary
  String truncateWords(int maxWords, {String suffix = '...'}) {
    final words = split(' ');
    if (words.length <= maxWords) return this;
    return '${words.take(maxWords).join(' ')}$suffix';
  }

  //═══════════════════════════════════════════════════════════════
  // PARSING
  //═══════════════════════════════════════════════════════════════

  /// Parse to int or return null
  int? toIntOrNull() => int.tryParse(this);

  /// Parse to double or return null
  double? toDoubleOrNull() => double.tryParse(this);

  /// Parse to DateTime or return null
  DateTime? toDateTimeOrNull() => DateTime.tryParse(this);

  //═══════════════════════════════════════════════════════════════
  // MASKING
  //═══════════════════════════════════════════════════════════════

  /// Mask email (show first 2 and last 2 characters before @)
  String get maskEmail {
    final parts = split('@');
    if (parts.length != 2) return this;

    final name = parts[0];
    final domain = parts[1];

    if (name.length <= 4) {
      return '${name[0]}***@$domain';
    }

    return '${name.substring(0, 2)}${'*' * (name.length - 4)}${name.substring(name.length - 2)}@$domain';
  }

  /// Mask phone number (show last 4 digits)
  String get maskPhone {
    if (length <= 4) return this;
    return '${'*' * (length - 4)}${substring(length - 4)}';
  }

  //═══════════════════════════════════════════════════════════════
  // UTILITY
  //═══════════════════════════════════════════════════════════════

  /// Get initials from name
  String get initials {
    final words = trim().split(' ');
    if (words.isEmpty) return '';
    if (words.length == 1) {
      return words[0].isNotEmpty ? words[0][0].toUpperCase() : '';
    }
    return '${words.first[0]}${words.last[0]}'.toUpperCase();
  }

  /// Count occurrences of substring
  int countOccurrences(String substring) {
    if (substring.isEmpty) return 0;
    int count = 0;
    int index = 0;
    while ((index = indexOf(substring, index)) != -1) {
      count++;
      index += substring.length;
    }
    return count;
  }

  /// Check if string contains any of the given substrings
  bool containsAny(List<String> substrings) {
    return substrings.any((s) => contains(s));
  }

  /// Check if string contains all of the given substrings
  bool containsAll(List<String> substrings) {
    return substrings.every((s) => contains(s));
  }

  /// Remove prefix if present
  String removePrefix(String prefix) {
    if (startsWith(prefix)) {
      return substring(prefix.length);
    }
    return this;
  }

  /// Remove suffix if present
  String removeSuffix(String suffix) {
    if (endsWith(suffix)) {
      return substring(0, length - suffix.length);
    }
    return this;
  }
}

/// Nullable String Extensions
extension NullableStringExtensions on String? {
  /// Check if null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Check if null, empty, or whitespace
  bool get isNullOrBlank => this == null || this!.trim().isEmpty;

  /// Return empty string if null
  String get orEmpty => this ?? '';

  /// Return default value if null or empty
  String orDefault(String defaultValue) {
    if (isNullOrEmpty) return defaultValue;
    return this!;
  }
}
