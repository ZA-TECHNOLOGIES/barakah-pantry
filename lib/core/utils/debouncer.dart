import 'dart:async';

/// Debouncer
/// Utility class for debouncing function calls
class Debouncer {
  final Duration duration;
  Timer? _timer;

  Debouncer({this.duration = const Duration(milliseconds: 500)});

  /// Run the action after the duration
  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  /// Cancel any pending action
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Check if timer is active
  bool get isActive => _timer?.isActive ?? false;

  /// Dispose the debouncer
  void dispose() {
    cancel();
  }
}

/// Throttler
/// Utility class for throttling function calls
class Throttler {
  final Duration duration;
  DateTime? _lastRun;
  Timer? _timer;

  Throttler({this.duration = const Duration(milliseconds: 500)});

  /// Run the action if enough time has passed
  void run(void Function() action) {
    final now = DateTime.now();

    if (_lastRun == null || now.difference(_lastRun!) >= duration) {
      _lastRun = now;
      action();
    } else {
      // Schedule to run after remaining time
      _timer?.cancel();
      final remaining = duration - now.difference(_lastRun!);
      _timer = Timer(remaining, () {
        _lastRun = DateTime.now();
        action();
      });
    }
  }

  /// Cancel any pending action
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Reset the throttler
  void reset() {
    cancel();
    _lastRun = null;
  }

  /// Dispose the throttler
  void dispose() {
    cancel();
  }
}

/// Rate Limiter
/// Utility class for limiting function calls within a time window
class RateLimiter {
  final int maxCalls;
  final Duration window;
  final List<DateTime> _callTimes = [];

  RateLimiter({
    required this.maxCalls,
    this.window = const Duration(minutes: 1),
  });

  /// Check if call is allowed
  bool get canCall {
    _cleanup();
    return _callTimes.length < maxCalls;
  }

  /// Get remaining calls
  int get remainingCalls {
    _cleanup();
    return maxCalls - _callTimes.length;
  }

  /// Get time until next call is allowed
  Duration? get timeUntilNextCall {
    if (canCall) return null;
    _cleanup();
    if (_callTimes.isEmpty) return null;

    final oldestCall = _callTimes.first;
    final resetTime = oldestCall.add(window);
    return resetTime.difference(DateTime.now());
  }

  /// Record a call
  bool recordCall() {
    if (!canCall) return false;
    _callTimes.add(DateTime.now());
    return true;
  }

  /// Try to run an action (returns true if successful)
  bool tryRun(void Function() action) {
    if (recordCall()) {
      action();
      return true;
    }
    return false;
  }

  /// Reset the rate limiter
  void reset() {
    _callTimes.clear();
  }

  void _cleanup() {
    final cutoff = DateTime.now().subtract(window);
    _callTimes.removeWhere((time) => time.isBefore(cutoff));
  }
}
