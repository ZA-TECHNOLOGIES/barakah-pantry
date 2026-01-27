import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/user_entity.dart';

/// Auth Repository
/// Repository for authentication operations
abstract class AuthRepository {
  /// Login with email and password
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  /// Sign up with email and password
  Future<Either<Failure, UserEntity>> signup({
    required String email,
    required String password,
    String? fullName,
  });

  /// Logout current user
  Future<Either<Failure, void>> logout();

  /// Check if user is authenticated
  Future<Either<Failure, bool>> isAuthenticated();

  /// Get current user
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  /// Reset password
  Future<Either<Failure, void>> resetPassword(String email);

  /// Update password
  Future<Either<Failure, void>> updatePassword({
    required String currentPassword,
    required String newPassword,
  });
}
