import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/user_entity.dart';

/// User Repository
/// Repository for user profile operations
abstract class UserRepository {
  /// Get user profile
  Future<Either<Failure, UserEntity>> getProfile(String userId);

  /// Update user profile
  Future<Either<Failure, UserEntity>> updateProfile(UserEntity user);

  /// Update avatar
  Future<Either<Failure, String>> updateAvatar({
    required String userId,
    required String imagePath,
  });

  /// Update goals
  Future<Either<Failure, void>> updateGoals({
    required String userId,
    required List<String> goals,
  });

  /// Update dietary preferences
  Future<Either<Failure, void>> updateDietaryPreferences({
    required String userId,
    required List<String> preferences,
  });

  /// Update reminder settings
  Future<Either<Failure, void>> updateReminderSettings({
    required String userId,
    required bool enabled,
    String? time,
  });

  /// Complete onboarding
  Future<Either<Failure, void>> completeOnboarding(String userId);

  /// Delete account
  Future<Either<Failure, void>> deleteAccount(String userId);
}
