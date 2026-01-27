/// Base Exception for the application
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() => 'AppException: $message (Code: $code)';
}

//═══════════════════════════════════════════════════════════════
// SERVER EXCEPTIONS
//═══════════════════════════════════════════════════════════════

/// Server Exception
/// Thrown when server returns an error response
class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
    required super.message,
    super.code,
    super.originalError,
    this.statusCode,
  });

  factory ServerException.fromStatusCode(int statusCode, [String? message]) {
    switch (statusCode) {
      case 400:
        return ServerException(
          message: message ?? 'Bad request',
          code: 'BAD_REQUEST',
          statusCode: statusCode,
        );
      case 401:
        return ServerException(
          message: message ?? 'Unauthorized',
          code: 'UNAUTHORIZED',
          statusCode: statusCode,
        );
      case 403:
        return ServerException(
          message: message ?? 'Forbidden',
          code: 'FORBIDDEN',
          statusCode: statusCode,
        );
      case 404:
        return ServerException(
          message: message ?? 'Not found',
          code: 'NOT_FOUND',
          statusCode: statusCode,
        );
      case 409:
        return ServerException(
          message: message ?? 'Conflict',
          code: 'CONFLICT',
          statusCode: statusCode,
        );
      case 422:
        return ServerException(
          message: message ?? 'Unprocessable entity',
          code: 'UNPROCESSABLE_ENTITY',
          statusCode: statusCode,
        );
      case 429:
        return ServerException(
          message: message ?? 'Too many requests',
          code: 'RATE_LIMITED',
          statusCode: statusCode,
        );
      case 500:
        return ServerException(
          message: message ?? 'Internal server error',
          code: 'SERVER_ERROR',
          statusCode: statusCode,
        );
      case 502:
        return ServerException(
          message: message ?? 'Bad gateway',
          code: 'BAD_GATEWAY',
          statusCode: statusCode,
        );
      case 503:
        return ServerException(
          message: message ?? 'Service unavailable',
          code: 'SERVICE_UNAVAILABLE',
          statusCode: statusCode,
        );
      default:
        return ServerException(
          message: message ?? 'Unknown server error',
          code: 'UNKNOWN',
          statusCode: statusCode,
        );
    }
  }

  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

//═══════════════════════════════════════════════════════════════
// CACHE EXCEPTIONS
//═══════════════════════════════════════════════════════════════

/// Cache Exception
/// Thrown when there's an error with local cache
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
    super.originalError,
  });

  factory CacheException.notFound([String? key]) {
    return CacheException(
      message:
          key != null ? 'Cache not found for key: $key' : 'Cache not found',
      code: 'CACHE_NOT_FOUND',
    );
  }

  factory CacheException.expired([String? key]) {
    return CacheException(
      message: key != null ? 'Cache expired for key: $key' : 'Cache expired',
      code: 'CACHE_EXPIRED',
    );
  }

  factory CacheException.writeError([String? message]) {
    return CacheException(
      message: message ?? 'Failed to write to cache',
      code: 'CACHE_WRITE_ERROR',
    );
  }

  factory CacheException.readError([String? message]) {
    return CacheException(
      message: message ?? 'Failed to read from cache',
      code: 'CACHE_READ_ERROR',
    );
  }

  @override
  String toString() => 'CacheException: $message';
}

//═══════════════════════════════════════════════════════════════
// NETWORK EXCEPTIONS
//═══════════════════════════════════════════════════════════════

/// Network Exception
/// Thrown when there's no internet connection
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'No internet connection',
    super.code = 'NO_NETWORK',
    super.originalError,
  });

  factory NetworkException.noConnection() {
    return const NetworkException(
      message: 'No internet connection. Please check your network settings.',
      code: 'NO_CONNECTION',
    );
  }

  factory NetworkException.timeout() {
    return const NetworkException(
      message: 'Connection timed out. Please try again.',
      code: 'TIMEOUT',
    );
  }

  factory NetworkException.poorConnection() {
    return const NetworkException(
      message: 'Poor internet connection. Please try again.',
      code: 'POOR_CONNECTION',
    );
  }

  @override
  String toString() => 'NetworkException: $message';
}

//═══════════════════════════════════════════════════════════════
// AUTHENTICATION EXCEPTIONS
//═══════════════════════════════════════════════════════════════

/// Authentication Exception
/// Thrown when authentication fails
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.code,
    super.originalError,
  });

  factory AuthException.invalidCredentials() {
    return const AuthException(
      message: 'Invalid email or password',
      code: 'INVALID_CREDENTIALS',
    );
  }

  factory AuthException.emailAlreadyInUse() {
    return const AuthException(
      message: 'This email is already registered',
      code: 'EMAIL_IN_USE',
    );
  }

  factory AuthException.weakPassword() {
    return const AuthException(
      message: 'Password is too weak',
      code: 'WEAK_PASSWORD',
    );
  }

  factory AuthException.invalidEmail() {
    return const AuthException(
      message: 'Invalid email address',
      code: 'INVALID_EMAIL',
    );
  }

  factory AuthException.userNotFound() {
    return const AuthException(
      message: 'No user found with this email',
      code: 'USER_NOT_FOUND',
    );
  }

  factory AuthException.sessionExpired() {
    return const AuthException(
      message: 'Session expired. Please login again.',
      code: 'SESSION_EXPIRED',
    );
  }

  factory AuthException.notAuthenticated() {
    return const AuthException(
      message: 'Please login to continue',
      code: 'NOT_AUTHENTICATED',
    );
  }

  factory AuthException.accountDisabled() {
    return const AuthException(
      message: 'Your account has been disabled',
      code: 'ACCOUNT_DISABLED',
    );
  }

  factory AuthException.emailNotVerified() {
    return const AuthException(
      message: 'Please verify your email address',
      code: 'EMAIL_NOT_VERIFIED',
    );
  }

  @override
  String toString() => 'AuthException: $message';
}

//═══════════════════════════════════════════════════════════════
// VALIDATION EXCEPTIONS
//═══════════════════════════════════════════════════════════════

/// Validation Exception
/// Thrown when input validation fails
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({
    required super.message,
    super.code,
    super.originalError,
    this.fieldErrors,
  });

  factory ValidationException.required(String fieldName) {
    return ValidationException(
      message: '$fieldName is required',
      code: 'REQUIRED',
      fieldErrors: {fieldName.toLowerCase(): '$fieldName is required'},
    );
  }

  factory ValidationException.invalid(String fieldName, [String? reason]) {
    return ValidationException(
      message: reason ?? 'Invalid $fieldName',
      code: 'INVALID',
      fieldErrors: {fieldName.toLowerCase(): reason ?? 'Invalid $fieldName'},
    );
  }

  factory ValidationException.minLength(String fieldName, int minLength) {
    return ValidationException(
      message: '$fieldName must be at least $minLength characters',
      code: 'MIN_LENGTH',
      fieldErrors: {
        fieldName.toLowerCase():
            '$fieldName must be at least $minLength characters'
      },
    );
  }

  factory ValidationException.maxLength(String fieldName, int maxLength) {
    return ValidationException(
      message: '$fieldName must not exceed $maxLength characters',
      code: 'MAX_LENGTH',
      fieldErrors: {
        fieldName.toLowerCase():
            '$fieldName must not exceed $maxLength characters'
      },
    );
  }

  @override
  String toString() => 'ValidationException: $message';
}

//═══════════════════════════════════════════════════════════════
// NOT FOUND EXCEPTIONS
//═══════════════════════════════════════════════════════════════

/// Not Found Exception
/// Thrown when a requested resource is not found
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Resource not found',
    super.code = 'NOT_FOUND',
    super.originalError,
  });

  factory NotFoundException.ingredient([String? id]) {
    return NotFoundException(
      message:
          id != null ? 'Ingredient not found: $id' : 'Ingredient not found',
      code: 'INGREDIENT_NOT_FOUND',
    );
  }

  factory NotFoundException.recipe([String? id]) {
    return NotFoundException(
      message: id != null ? 'Recipe not found: $id' : 'Recipe not found',
      code: 'RECIPE_NOT_FOUND',
    );
  }

  factory NotFoundException.user([String? id]) {
    return NotFoundException(
      message: id != null ? 'User not found: $id' : 'User not found',
      code: 'USER_NOT_FOUND',
    );
  }

  factory NotFoundException.profile([String? id]) {
    return NotFoundException(
      message: id != null ? 'Profile not found: $id' : 'Profile not found',
      code: 'PROFILE_NOT_FOUND',
    );
  }

  @override
  String toString() => 'NotFoundException: $message';
}

//═══════════════════════════════════════════════════════════════
// PERMISSION EXCEPTIONS
//═══════════════════════════════════════════════════════════════

/// Permission Exception
/// Thrown when user doesn't have required permissions
class PermissionException extends AppException {
  const PermissionException({
    super.message = 'Permission denied',
    super.code = 'PERMISSION_DENIED',
    super.originalError,
  });

  factory PermissionException.camera() {
    return const PermissionException(
      message: 'Camera permission is required',
      code: 'CAMERA_PERMISSION',
    );
  }

  factory PermissionException.storage() {
    return const PermissionException(
      message: 'Storage permission is required',
      code: 'STORAGE_PERMISSION',
    );
  }

  factory PermissionException.notification() {
    return const PermissionException(
      message: 'Notification permission is required',
      code: 'NOTIFICATION_PERMISSION',
    );
  }

  @override
  String toString() => 'PermissionException: $message';
}

//═══════════════════════════════════════════════════════════════
// TIMEOUT EXCEPTIONS
//═══════════════════════════════════════════════════════════════

/// Timeout Exception
/// Thrown when a request times out
class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'Request timed out',
    super.code = 'TIMEOUT',
    super.originalError,
  });

  factory TimeoutException.connection() {
    return const TimeoutException(
      message: 'Connection timed out',
      code: 'CONNECTION_TIMEOUT',
    );
  }

  factory TimeoutException.send() {
    return const TimeoutException(
      message: 'Send timeout',
      code: 'SEND_TIMEOUT',
    );
  }

  factory TimeoutException.receive() {
    return const TimeoutException(
      message: 'Receive timeout',
      code: 'RECEIVE_TIMEOUT',
    );
  }

  @override
  String toString() => 'TimeoutException: $message';
}

//═══════════════════════════════════════════════════════════════
// RATE LIMIT EXCEPTIONS
//═══════════════════════════════════════════════════════════════

/// Rate Limit Exception
/// Thrown when rate limit is exceeded
class RateLimitException extends AppException {
  final Duration? retryAfter;

  const RateLimitException({
    super.message = 'Rate limit exceeded',
    super.code = 'RATE_LIMITED',
    super.originalError,
    this.retryAfter,
  });

  factory RateLimitException.aiRecipes() {
    return const RateLimitException(
      message:
          'Daily AI recipe limit reached. Upgrade to premium for unlimited recipes.',
      code: 'AI_LIMIT_REACHED',
    );
  }

  factory RateLimitException.api([Duration? retryAfter]) {
    return RateLimitException(
      message: 'Too many requests. Please wait and try again.',
      code: 'API_RATE_LIMITED',
      retryAfter: retryAfter,
    );
  }

  @override
  String toString() =>
      'RateLimitException: $message (Retry after: $retryAfter)';
}

//═══════════════════════════════════════════════════════════════
// AI EXCEPTIONS
//═══════════════════════════════════════════════════════════════

/// AI Exception
/// Thrown when AI-related operations fail
class AIException extends AppException {
  const AIException({
    required super.message,
    super.code,
    super.originalError,
  });

  factory AIException.generationFailed([String? reason]) {
    return AIException(
      message: reason ?? 'Failed to generate recipe. Please try again.',
      code: 'GENERATION_FAILED',
    );
  }

  factory AIException.invalidResponse() {
    return const AIException(
      message: 'Invalid AI response. Please try again.',
      code: 'INVALID_RESPONSE',
    );
  }

  factory AIException.serviceUnavailable() {
    return const AIException(
      message: 'AI service is temporarily unavailable. Please try again later.',
      code: 'SERVICE_UNAVAILABLE',
    );
  }

  factory AIException.quotaExceeded() {
    return const AIException(
      message: 'AI usage quota exceeded. Please try again later.',
      code: 'QUOTA_EXCEEDED',
    );
  }

  @override
  String toString() => 'AIException: $message';
}

//═══════════════════════════════════════════════════════════════
// PARSE EXCEPTIONS
//═══════════════════════════════════════════════════════════════

/// Parse Exception
/// Thrown when parsing data fails
class ParseException extends AppException {
  const ParseException({
    required super.message,
    super.code = 'PARSE_ERROR',
    super.originalError,
  });

  factory ParseException.json([String? details]) {
    return ParseException(
      message: details ?? 'Failed to parse JSON data',
      code: 'JSON_PARSE_ERROR',
    );
  }

  factory ParseException.date([String? details]) {
    return ParseException(
      message: details ?? 'Failed to parse date',
      code: 'DATE_PARSE_ERROR',
    );
  }

  @override
  String toString() => 'ParseException: $message';
}

//═══════════════════════════════════════════════════════════════
// STORAGE EXCEPTIONS
//═══════════════════════════════════════════════════════════════

/// Storage Exception
/// Thrown when storage operations fail
class StorageException extends AppException {
  const StorageException({
    required super.message,
    super.code,
    super.originalError,
  });

  factory StorageException.uploadFailed([String? reason]) {
    return StorageException(
      message: reason ?? 'Failed to upload file',
      code: 'UPLOAD_FAILED',
    );
  }

  factory StorageException.downloadFailed([String? reason]) {
    return StorageException(
      message: reason ?? 'Failed to download file',
      code: 'DOWNLOAD_FAILED',
    );
  }

  factory StorageException.deleteFailed([String? reason]) {
    return StorageException(
      message: reason ?? 'Failed to delete file',
      code: 'DELETE_FAILED',
    );
  }

  factory StorageException.fileTooLarge(int maxSizeMB) {
    return StorageException(
      message: 'File size exceeds maximum limit of ${maxSizeMB}MB',
      code: 'FILE_TOO_LARGE',
    );
  }

  factory StorageException.invalidFileType(List<String> allowedTypes) {
    return StorageException(
      message: 'Invalid file type. Allowed types: ${allowedTypes.join(", ")}',
      code: 'INVALID_FILE_TYPE',
    );
  }

  @override
  String toString() => 'StorageException: $message';
}
