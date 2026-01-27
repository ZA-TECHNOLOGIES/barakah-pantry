import 'package:intl/intl.dart';

/// DateTime Extensions
/// Utility extension methods for DateTime class
extension DateTimeExtensions on DateTime {
  //═══════════════════════════════════════════════════════════════
  // FORMATTING
  //═══════════════════════════════════════════════════════════════

  /// Format: "Jan 1, 2024"
  String get formatted => DateFormat('MMM d, yyyy').format(this);

  /// Format: "January 1, 2024"
  String get formattedFull => DateFormat('MMMM d, yyyy').format(this);

  /// Format: "01/01/2024"
  String get formattedShort => DateFormat('MM/dd/yyyy').format(this);

  /// Format: "2024-01-01"
  String get formattedISO => DateFormat('yyyy-MM-dd').format(this);

  /// Format: "Mon, Jan 1"
  String get formattedDayMonth => DateFormat('E, MMM d').format(this);

  /// Format: "Monday, January 1, 2024"
  String get formattedFullWithDay =>
      DateFormat('EEEE, MMMM d, yyyy').format(this);

  /// Format: "12:30 PM"
  String get formattedTime => DateFormat('h:mm a').format(this);

  /// Format: "12:30"
  String get formattedTime24 => DateFormat('HH:mm').format(this);

  /// Format: "Jan 1, 2024 at 12:30 PM"
  String get formattedDateTime =>
      DateFormat('MMM d, yyyy \'at\' h:mm a').format(this);

  /// Format with custom pattern
  String format(String pattern) => DateFormat(pattern).format(this);

  //═══════════════════════════════════════════════════════════════
  // RELATIVE TIME
  //═══════════════════════════════════════════════════════════════

  /// Get relative time (e.g., "2 hours ago", "Yesterday")
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }

    if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    }

    if (difference.inDays > 7) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    }

    if (difference.inDays > 1) {
      return '${difference.inDays} days ago';
    }

    if (difference.inDays == 1) {
      return 'Yesterday';
    }

    if (difference.inHours > 1) {
      return '${difference.inHours} hours ago';
    }

    if (difference.inHours == 1) {
      return '1 hour ago';
    }

    if (difference.inMinutes > 1) {
      return '${difference.inMinutes} minutes ago';
    }

    if (difference.inMinutes == 1) {
      return '1 minute ago';
    }

    return 'Just now';
  }

  /// Get time until (e.g., "in 2 hours")
  String get timeUntil {
    final now = DateTime.now();
    final difference = this.difference(now);

    if (difference.isNegative) {
      return timeAgo;
    }

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return 'in $years ${years == 1 ? 'year' : 'years'}';
    }

    if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return 'in $months ${months == 1 ? 'month' : 'months'}';
    }

    if (difference.inDays > 7) {
      final weeks = (difference.inDays / 7).floor();
      return 'in $weeks ${weeks == 1 ? 'week' : 'weeks'}';
    }

    if (difference.inDays > 1) {
      return 'in ${difference.inDays} days';
    }

    if (difference.inDays == 1) {
      return 'Tomorrow';
    }

    if (difference.inHours > 1) {
      return 'in ${difference.inHours} hours';
    }

    if (difference.inHours == 1) {
      return 'in 1 hour';
    }

    if (difference.inMinutes > 1) {
      return 'in ${difference.inMinutes} minutes';
    }

    return 'Now';
  }

  //═══════════════════════════════════════════════════════════════
  // COMPARISON
  //═══════════════════════════════════════════════════════════════

  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Check if date is in the past
  bool get isPast => isBefore(DateTime.now());

  /// Check if date is in the future
  bool get isFuture => isAfter(DateTime.now());

  /// Check if date is same day as another date
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Check if date is same month as another date
  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  /// Check if date is same year as another date
  bool isSameYear(DateTime other) {
    return year == other.year;
  }

  /// Check if date is weekend
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;

  /// Check if date is weekday
  bool get isWeekday => !isWeekend;

  //═══════════════════════════════════════════════════════════════
  // MANIPULATION
  //═══════════════════════════════════════════════════════════════

  /// Get start of day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  /// Get end of day (23:59:59)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  /// Get start of month
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Get end of month
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59, 999);

  /// Get start of year
  DateTime get startOfYear => DateTime(year, 1, 1);

  /// Get end of year
  DateTime get endOfYear => DateTime(year, 12, 31, 23, 59, 59, 999);

  /// Get start of week (Monday)
  DateTime get startOfWeek {
    final daysFromMonday = weekday - 1;
    return subtract(Duration(days: daysFromMonday)).startOfDay;
  }

  /// Get end of week (Sunday)
  DateTime get endOfWeek {
    final daysUntilSunday = 7 - weekday;
    return add(Duration(days: daysUntilSunday)).endOfDay;
  }

  /// Add days
  DateTime addDays(int days) => add(Duration(days: days));

  /// Subtract days
  DateTime subtractDays(int days) => subtract(Duration(days: days));

  /// Add months
  DateTime addMonths(int months) {
    var newMonth = month + months;
    var newYear = year;
    while (newMonth > 12) {
      newMonth -= 12;
      newYear++;
    }
    while (newMonth < 1) {
      newMonth += 12;
      newYear--;
    }
    final newDay = day.clamp(1, DateTime(newYear, newMonth + 1, 0).day);
    return DateTime(newYear, newMonth, newDay, hour, minute, second);
  }

  /// Subtract months
  DateTime subtractMonths(int months) => addMonths(-months);

  //═══════════════════════════════════════════════════════════════
  // UTILITY
  //═══════════════════════════════════════════════════════════════

  /// Get number of days in month
  int get daysInMonth => DateTime(year, month + 1, 0).day;

  /// Get day name (Monday, Tuesday, etc.)
  String get dayName => DateFormat('EEEE').format(this);

  /// Get short day name (Mon, Tue, etc.)
  String get shortDayName => DateFormat('E').format(this);

  /// Get month name (January, February, etc.)
  String get monthName => DateFormat('MMMM').format(this);

  /// Get short month name (Jan, Feb, etc.)
  String get shortMonthName => DateFormat('MMM').format(this);

  /// Get age from birthdate
  int get age {
    final now = DateTime.now();
    var age = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }
    return age;
  }
}
