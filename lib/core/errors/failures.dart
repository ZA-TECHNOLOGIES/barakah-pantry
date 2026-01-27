import 'package:equatable/equatable.dart';

/// Base Failure class for the application
/// Failures are used in the domain layer to represent errors
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

//═══════════════════════════════════════════════════════════════
// SERVER FAILURES
//═══════════════════════════════════════════════════════════════

/// Server Failure
/// Represents server-side errors
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({
    required super.message,
    super.code,
    this.statusCode,
  });

  factory ServerFailure.general([String? message]) {
    return ServerFailure(
      message: message ?? 'Server error occurred. Please try again.',
      code: 'SERVER_ERROR',
    );
  }

  factory ServerFailure.serviceUnavailable() {
    return const ServerFailure(
      message: 'Service is temporarily unavailable. Please try again later.',
      code: 'SERVICE_UNAVAILABLE',
      statusCode: 503,
    );
  }
}

//═══════════════════════════════════════════════════════════════
// CACHE FAILURES
//═══════════════════════════════════════════════════════════════

/// Cache Failure
/// Represents local cache errors
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
  });

  factory CacheFailure.notFound() {
    return const CacheFailure(
      message: 'No cached data found',
      code: 'CACHE_NOT_FOUND',
    );
  }

  factory CacheFailure.expired() {
    return const CacheFailure(
      message: 'Cached data has expired',
      code: 'CACHE_EXPIRED',
    );
  }
}

//═══════════════════════════════════════════════════════════════
// NETWORK FAILURES
//═══════════════════════════════════════════════════════════════

/// Network Failure
/// Represents network connectivity errors
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection',
    super.code = 'NO_NETWORK',
  });

  factory NetworkFailure.noConnection() {
    return const NetworkFailure(
      message: 'No internet connection. Please check your network settings.',
      code: 'NO_CONNECTION',
    );
  }

  factory NetworkFailure.timeout() {
    return const NetworkFailure(
      message: 'Connection timed out. Please try again.',
      code: 'TIMEOUT',
    );
  }
}

//═══════════════════════════════════════════════════════════════
// AUTHENTICATION FAILURES
//═══════════════════════════════════════════════════════════════

/// Auth Failure
/// Represents authentication errors
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
  });

  factory AuthFailure.invalidCredentials() {
    return const AuthFailure(
      message: 'Invalid email or password',
      code: 'INVALID_CREDENTIALS',
    );
  }

  factory AuthFailure.sessionExpired() {
    return const AuthFailure(
      message: 'Session expired. Please login again.',
      code: 'SESSION_EXPIRED',
    );
  }

  factory AuthFailure.notAuthenticated() {
    return const AuthFailure(
      message: 'Please login to continue',
      code: 'NOT_AUTHENTICATED',
    );
  }

  factory AuthFailure.emailAlreadyInUse() {
    return const AuthFailure(
      message: 'This email is already registered',
      code: 'EMAIL_IN_USE',
    );
  }

  factory AuthFailure.weakPassword() {
    return const AuthFailure(
      message: 'Password is too weak. Please use a stronger password.',
      code: 'WEAK_PASSWORD',
    );
  }

  factory AuthFailure.userNotFound() {
    return const AuthFailure(
      message: 'No user found with this email',
      code: 'USER_NOT_FOUND',
    );
  }
}

//═══════════════════════════════════════════════════════════════
// VALIDATION FAILURES
//═══════════════════════════════════════════════════════════════

/// Validation Failure
/// Represents input validation errors
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({
    required super.message,
    super.code,
    this.fieldErrors,
  });

  factory ValidationFailure.invalidInput([String? message]) {
    return ValidationFailure(
      message: message ?? 'Invalid input provided',
      code: 'INVALID_INPUT',
    );
  }

  factory ValidationFailure.missingFields(List<String> fields) {
    return ValidationFailure(
      message: 'Missing required fields: ${fields.join(", ")}',
      code: 'MISSING_FIELDS',
      fieldErrors: {for (var field in fields) field: '$field is required'},
    );
  }
}

//═══════════════════════════════════════════════════════════════
// NOT FOUND FAILURES
//═══════════════════════════════════════════════════════════════

/// Not Found Failure
/// Represents resource not found errors
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'Resource not found',
    super.code = 'NOT_FOUND',
  });

  factory NotFoundFailure.ingredient([String? id]) {
    return NotFoundFailure(
      message: 'Ingredient not found',
      code: 'INGREDIENT_NOT_FOUND',
    );
  }

  factory NotFoundFailure.recipe([String? id]) {
    return NotFoundFailure(
      message: 'Recipe not found',
      code: 'RECIPE_NOT_FOUND',
    );
  }

  factory NotFoundFailure.user([String? id]) {
    return NotFoundFailure(
      message: 'User not found',
      code: 'USER_NOT_FOUND',
    );
  }
}

//═══════════════════════════════════════════════════════════════
// PERMISSION FAILURES
//═══════════════════════════════════════════════════════════════

/// Permission Failure
/// Represents permission denied errors
class PermissionFailure extends Failure {
  const PermissionFailure({
    super.message = 'Permission denied',
    super.code = 'PERMISSION_DENIED',
  });

  factory PermissionFailure.accessDenied() {
    return const PermissionFailure(
      message: 'You do not have permission to access this resource',
      code: 'ACCESS_DENIED',
    );
  }
}

//═══════════════════════════════════════════════════════════════
// RATE LIMIT FAILURES
//═══════════════════════════════════════════════════════════════

/// Rate Limit Failure
/// Represents rate limit exceeded errors
class RateLimitFailure extends Failure {
  final Duration? retryAfter;

  const RateLimitFailure({
    super.message = 'Rate limit exceeded',
    super.code = 'RATE_LIMITED',
    this.retryAfter,
  });

  factory RateLimitFailure.aiRecipes() {
    return const RateLimitFailure(
      message:
          'Daily AI recipe limit reached. Upgrade to premium for unlimited recipes.',
      code: 'AI_LIMIT_REACHED',
    );
  }
}

//═══════════════════════════════════════════════════════════════
// AI FAILURES
//═══════════════════════════════════════════════════════════════

/// AI Failure
/// Represents AI-related errors
class AIFailure extends Failure {
  const AIFailure({
    required super.message,
    super.code,
  });

  factory AIFailure.generationFailed([String? reason]) {
    return AIFailure(
      message: reason ?? 'Failed to generate recipe. Please try again.',
      code: 'GENERATION_FAILED',
    );
  }

  factory AIFailure.serviceUnavailable() {
    return const AIFailure(
      message: 'AI service is temporarily unavailable. Please try again later.',
      code: 'AI_SERVICE_UNAVAILABLE',
    );
  }
}

//═══════════════════════════════════════════════════════════════
// STORAGE FAILURES
//═══════════════════════════════════════════════════════════════

/// Storage Failure
/// Represents storage-related errors
class StorageFailure extends Failure {
  const StorageFailure({
    required super.message,
    super.code,
  });

  factory StorageFailure.uploadFailed() {
    return const StorageFailure(
      message: 'Failed to upload file. Please try again.',
      code: 'UPLOAD_FAILED',
    );
  }

  factory StorageFailure.downloadFailed() {
    return const StorageFailure(
      message: 'Failed to download file. Please try again.',
      code: 'DOWNLOAD_FAILED',
    );
  }
}

//═══════════════════════════════════════════════════════════════
// UNKNOWN FAILURES
//═══════════════════════════════════════════════════════════════

/// Unknown Failure
/// Represents unexpected/unknown errors
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'An unexpected error occurred',
    super.code = 'UNKNOWN_ERROR',
  });
}
