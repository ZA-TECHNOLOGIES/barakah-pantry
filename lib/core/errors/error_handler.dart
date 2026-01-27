import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'exceptions.dart' hide StorageException, AuthException;
import 'failures.dart';

/// Error Handler
/// Utility class for handling and converting errors
class ErrorHandler {
  ErrorHandler._();

  //═══════════════════════════════════════════════════════════════
  // EXCEPTION TO FAILURE CONVERSION
  //═══════════════════════════════════════════════════════════════

  /// Convert exception to failure
  static Failure handleException(dynamic exception) {
    if (exception is Failure) {
      return exception;
    }

    if (exception is AppException) {
      return _mapAppExceptionToFailure(exception);
    }

    if (exception is AuthException) {
      return _mapAuthExceptionToFailure(exception);
    }

    if (exception is PostgrestException) {
      return _mapPostgrestExceptionToFailure(exception);
    }

    if (exception is SocketException) {
      return NetworkFailure.noConnection();
    }

    if (exception is HttpException) {
      return const ServerFailure(
        message: 'HTTP error occurred',
        code: 'HTTP_ERROR',
      );
    }

    if (exception is FormatException) {
      return const ValidationFailure(
        message: 'Invalid data format',
        code: 'FORMAT_ERROR',
      );
    }

    // Default unknown failure
    return UnknownFailure(
      message: exception.toString(),
    );
  }

  //═══════════════════════════════════════════════════════════════
  // APP EXCEPTION MAPPING
  //═══════════════════════════════════════════════════════════════

  static Failure _mapAppExceptionToFailure(AppException exception) {
    if (exception is ServerException) {
      return ServerFailure(
        message: exception.message,
        code: exception.code,
        statusCode: exception.statusCode,
      );
    }

    if (exception is CacheException) {
      return CacheFailure(
        message: exception.message,
        code: exception.code,
      );
    }

    if (exception is NetworkException) {
      return NetworkFailure(
        message: exception.message,
        code: exception.code,
      );
    }

    if (exception is AuthException) {
      return AuthFailure(
        message: exception.message,
        code: exception.code,
      );
    }

    if (exception is ValidationException) {
      return ValidationFailure(
        message: exception.message,
        code: exception.code,
        fieldErrors: exception.fieldErrors,
      );
    }

    if (exception is NotFoundException) {
      return NotFoundFailure(
        message: exception.message,
        code: exception.code,
      );
    }

    if (exception is PermissionException) {
      return PermissionFailure(
        message: exception.message,
        code: exception.code,
      );
    }

    if (exception is RateLimitException) {
      return RateLimitFailure(
        message: exception.message,
        code: exception.code,
        retryAfter: exception.retryAfter,
      );
    }

    if (exception is AIException) {
      return AIFailure(
        message: exception.message,
        code: exception.code,
      );
    }

    if (exception is StorageException) {
      return StorageFailure(
        message: exception.message,
        code: exception.code,
      );
    }

    return UnknownFailure(message: exception.message);
  }

  //═══════════════════════════════════════════════════════════════
  // SUPABASE AUTH EXCEPTION MAPPING
  //═══════════════════════════════════════════════════════════════

  static Failure _mapAuthExceptionToFailure(AuthException exception) {
    final message = exception.message.toLowerCase();

    if (message.contains('invalid login credentials')) {
      return AuthFailure.invalidCredentials();
    }

    if (message.contains('email already registered') ||
        message.contains('user already registered')) {
      return AuthFailure.emailAlreadyInUse();
    }

    if (message.contains('password')) {
      return AuthFailure.weakPassword();
    }

    if (message.contains('user not found')) {
      return AuthFailure.userNotFound();
    }

    if (message.contains('session expired') ||
        message.contains('jwt expired')) {
      return AuthFailure.sessionExpired();
    }

    return AuthFailure(
      message: exception.message,
      code: 'AUTH_ERROR',
    );
  }

  //═══════════════════════════════════════════════════════════════
  // POSTGREST EXCEPTION MAPPING
  //═══════════════════════════════════════════════════════════════

  static Failure _mapPostgrestExceptionToFailure(PostgrestException exception) {
    final code = exception.code;
    final message = exception.message;

    // Handle specific PostgreSQL error codes
    switch (code) {
      case '23505': // Unique violation
        return const ValidationFailure(
          message: 'This record already exists',
          code: 'DUPLICATE_ENTRY',
        );

      case '23503': // Foreign key violation
        return const ValidationFailure(
          message: 'Referenced record not found',
          code: 'REFERENCE_NOT_FOUND',
        );

      case '23502': // Not null violation
        return const ValidationFailure(
          message: 'Required field is missing',
          code: 'REQUIRED_FIELD_MISSING',
        );

      case '42P01': // Undefined table
        return const ServerFailure(
          message: 'Database configuration error',
          code: 'TABLE_NOT_FOUND',
        );

      case 'PGRST116': // No rows returned
        return const NotFoundFailure(
          message: 'Record not found',
          code: 'RECORD_NOT_FOUND',
        );

      default:
        return ServerFailure(
          message: message,
          code: code,
        );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // USER-FRIENDLY ERROR MESSAGES
  //═══════════════════════════════════════════════════════════════

  /// Get user-friendly error message
  static String getUserMessage(Failure failure) {
    // Return the failure message directly as it should already be user-friendly
    return failure.message;
  }

  /// Get error title for dialogs
  static String getErrorTitle(Failure failure) {
    if (failure is NetworkFailure) {
      return 'Connection Error';
    }
    if (failure is AuthFailure) {
      return 'Authentication Error';
    }
    if (failure is ValidationFailure) {
      return 'Validation Error';
    }
    if (failure is NotFoundFailure) {
      return 'Not Found';
    }
    if (failure is PermissionFailure) {
      return 'Permission Denied';
    }
    if (failure is RateLimitFailure) {
      return 'Limit Reached';
    }
    if (failure is AIFailure) {
      return 'AI Error';
    }
    if (failure is ServerFailure) {
      return 'Server Error';
    }
    return 'Error';
  }

  //═══════════════════════════════════════════════════════════════
  // ERROR LOGGING
  //═══════════════════════════════════════════════════════════════

  /// Log error for debugging
  static void logError(dynamic error, [StackTrace? stackTrace]) {
    print('═══════════════════════════════════════════════════════════════');
    print('ERROR: ${error.runtimeType}');
    print('MESSAGE: $error');
    if (stackTrace != null) {
      print('STACK TRACE:');
      print(stackTrace);
    }
    print('═══════════════════════════════════════════════════════════════');
  }
}
