import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// Log Level Enum
enum LogLevel {
  debug,
  info,
  warning,
  error,
}

/// Logger
/// Utility class for logging throughout the application
class Logger {
  Logger._();

  static bool _isEnabled = kDebugMode;
  static LogLevel _minLevel = LogLevel.debug;

  //═══════════════════════════════════════════════════════════════
  // CONFIGURATION
  //═══════════════════════════════════════════════════════════════

  /// Enable or disable logging
  static void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  /// Set minimum log level
  static void setMinLevel(LogLevel level) {
    _minLevel = level;
  }

  //═══════════════════════════════════════════════════════════════
  // LOG METHODS
  //═══════════════════════════════════════════════════════════════

  /// Log debug message
  static void d(String message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.debug, message,
        tag: tag, error: error, stackTrace: stackTrace);
  }

  /// Log info message
  static void i(String message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.info, message,
        tag: tag, error: error, stackTrace: stackTrace);
  }

  /// Log warning message
  static void w(String message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.warning, message,
        tag: tag, error: error, stackTrace: stackTrace);
  }

  /// Log error message
  static void e(String message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.error, message,
        tag: tag, error: error, stackTrace: stackTrace);
  }

  //═══════════════════════════════════════════════════════════════
  // SPECIALIZED LOG METHODS
  //═══════════════════════════════════════════════════════════════

  /// Log API request
  static void apiRequest(String method, String url,
      {Map<String, dynamic>? headers, dynamic body}) {
    if (!_shouldLog(LogLevel.debug)) return;

    final buffer = StringBuffer();
    buffer.writeln('═══════════════════════════════════════════════════════');
    buffer.writeln('📤 API REQUEST');
    buffer.writeln('───────────────────────────────────────────────────────');
    buffer.writeln('Method: $method');
    buffer.writeln('URL: $url');
    if (headers != null && headers.isNotEmpty) {
      buffer.writeln('Headers: $headers');
    }
    if (body != null) {
      buffer.writeln('Body: $body');
    }
    buffer.writeln('═══════════════════════════════════════════════════════');

    _print(buffer.toString());
  }

  /// Log API response
  static void apiResponse(int statusCode, String url,
      {dynamic body, int? durationMs}) {
    if (!_shouldLog(LogLevel.debug)) return;

    final isSuccess = statusCode >= 200 && statusCode < 300;
    final emoji = isSuccess ? '📥' : '❌';

    final buffer = StringBuffer();
    buffer.writeln('═══════════════════════════════════════════════════════');
    buffer.writeln('$emoji API RESPONSE');
    buffer.writeln('───────────────────────────────────────────────────────');
    buffer.writeln('Status: $statusCode');
    buffer.writeln('URL: $url');
    if (durationMs != null) {
      buffer.writeln('Duration: ${durationMs}ms');
    }
    if (body != null) {
      final bodyStr = body.toString();
      if (bodyStr.length > 500) {
        buffer.writeln('Body: ${bodyStr.substring(0, 500)}...');
      } else {
        buffer.writeln('Body: $bodyStr');
      }
    }
    buffer.writeln('═══════════════════════════════════════════════════════');

    _print(buffer.toString());
  }

  /// Log navigation
  static void navigation(String from, String to) {
    d('🧭 Navigation: $from → $to', tag: 'NAV');
  }

  /// Log state change
  static void state(String stateName, dynamic oldValue, dynamic newValue) {
    d('📊 State [$stateName]: $oldValue → $newValue', tag: 'STATE');
  }

  /// Log performance
  static void performance(String operation, int durationMs) {
    i('⏱️ Performance [$operation]: ${durationMs}ms', tag: 'PERF');
  }

  /// Log user action
  static void userAction(String action, {Map<String, dynamic>? params}) {
    final paramsStr = params != null ? ' | Params: $params' : '';
    i('👆 User Action: $action$paramsStr', tag: 'ACTION');
  }

  //═══════════════════════════════════════════════════════════════
  // PRIVATE METHODS
  //═══════════════════════════════════════════════════════════════

  static void _log(LogLevel level, String message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    if (!_shouldLog(level)) return;

    final timestamp = DateTime.now().toIso8601String();
    final levelStr = _getLevelString(level);
    final tagStr = tag != null ? '[$tag] ' : '';

    final buffer = StringBuffer();
    buffer.write('$timestamp $levelStr $tagStr$message');

    if (error != null) {
      buffer.write('\nError: $error');
    }

    if (stackTrace != null) {
      buffer.write('\nStackTrace:\n$stackTrace');
    }

    _print(buffer.toString());

    // Also log to developer console in debug mode
    if (kDebugMode) {
      developer.log(
        message,
        name: tag ?? 'APP',
        error: error,
        stackTrace: stackTrace,
        level: _getLevelValue(level),
      );
    }
  }

  static bool _shouldLog(LogLevel level) {
    if (!_isEnabled) return false;
    return level.index >= _minLevel.index;
  }

  static String _getLevelString(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '🔍 DEBUG';
      case LogLevel.info:
        return 'ℹ️ INFO';
      case LogLevel.warning:
        return '⚠️ WARN';
      case LogLevel.error:
        return '❌ ERROR';
    }
  }

  static int _getLevelValue(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
    }
  }

  static void _print(String message) {
    if (kDebugMode) {
      // ignore: avoid_print
      print(message);
    }
  }
}
