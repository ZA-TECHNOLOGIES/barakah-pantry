import 'package:intl/intl.dart';

/// Number Extensions
/// Utility extension methods for num, int, and double
extension NumExtensions on num {
  //═══════════════════════════════════════════════════════════════
  // FORMATTING
  //═══════════════════════════════════════════════════════════════

  /// Format with commas (1,234,567)
  String get formatted => NumberFormat('#,###').format(this);

  /// Format with decimal places
  String formatDecimals(int decimals) {
    return toStringAsFixed(decimals);
  }

  /// Format as currency
  String formatCurrency({String symbol = '\$', int decimals = 2}) {
    return '$symbol${NumberFormat('#,##0.${'0' * decimals}').format(this)}';
  }

  /// Format as percentage
  String formatPercentage({int decimals = 0}) {
    return '${(this * 100).toStringAsFixed(decimals)}%';
  }

  /// Format as compact (1K, 1M, etc.)
  String get compact {
    if (this >= 1000000000) {
      return '${(this / 1000000000).toStringAsFixed(1)}B';
    }
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    }
    if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    }
    return toString();
  }

  /// Format file size (bytes to KB, MB, GB)
  String get fileSize {
    if (this < 1024) return '${toStringAsFixed(0)} B';
    if (this < 1024 * 1024) return '${(this / 1024).toStringAsFixed(1)} KB';
    if (this < 1024 * 1024 * 1024) {
      return '${(this / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(this / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  //═══════════════════════════════════════════════════════════════
  // DURATION
  //═══════════════════════════════════════════════════════════════

  /// Convert to Duration (as milliseconds)
  Duration get milliseconds => Duration(milliseconds: toInt());

  /// Convert to Duration (as seconds)
  Duration get seconds => Duration(seconds: toInt());

  /// Convert to Duration (as minutes)
  Duration get minutes => Duration(minutes: toInt());

  /// Convert to Duration (as hours)
  Duration get hours => Duration(hours: toInt());

  /// Convert to Duration (as days)
  Duration get days => Duration(days: toInt());

  //═══════════════════════════════════════════════════════════════
  // TIME FORMATTING
  //═══════════════════════════════════════════════════════════════

  /// Format minutes as "1h 30m"
  String get formatMinutes {
    final mins = toInt();
    if (mins < 60) return '$mins min';
    final hours = mins ~/ 60;
    final remainingMins = mins % 60;
    if (remainingMins == 0) return '${hours}h';
    return '${hours}h ${remainingMins}m';
  }

  /// Format seconds as "mm:ss"
  String get formatSeconds {
    final secs = toInt();
    final minutes = (secs ~/ 60).toString().padLeft(2, '0');
    final seconds = (secs % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  //═══════════════════════════════════════════════════════════════
  // CALCULATIONS
  //═══════════════════════════════════════════════════════════════

  /// Check if number is between min and max (inclusive)
  bool isBetween(num min, num max) => this >= min && this <= max;

  /// Clamp value between min and max
  num clampValue(num min, num max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  /// Get percentage of total
  double percentageOf(num total) {
    if (total == 0) return 0;
    return (this / total) * 100;
  }

  /// Check if positive
  bool get isPositive => this > 0;

  /// Check if negative
  bool get isNegative => this < 0;

  /// Check if zero
  bool get isZero => this == 0;

  //═══════════════════════════════════════════════════════════════
  // PADDING
  //═══════════════════════════════════════════════════════════════

  /// Pad with leading zeros
  String padLeft(int width) => toString().padLeft(width, '0');
}

/// Integer Extensions
extension IntExtensions on int {
  /// Get ordinal suffix (1st, 2nd, 3rd, 4th, etc.)
  String get ordinal {
    if (this >= 11 && this <= 13) {
      return '${this}th';
    }
    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }

  /// Check if even
  bool get isEven => this % 2 == 0;

  /// Check if odd
  bool get isOdd => this % 2 != 0;

  /// Generate list from 0 to this value
  List<int> get range => List.generate(this, (index) => index);

  /// Repeat action n times
  void times(void Function(int index) action) {
    for (var i = 0; i < this; i++) {
      action(i);
    }
  }
}

/// Double Extensions
extension DoubleExtensions on double {
  /// Round to specific decimal places
  double roundTo(int places) {
    final factor = 10 * places;
    return (this * factor).round() / factor;
  }

  /// Check if approximately equal to another value
  bool approximatelyEquals(double other, {double epsilon = 0.0001}) {
    return (this - other).abs() < epsilon;
  }
}
