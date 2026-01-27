import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final supabase.SupabaseClient _supabaseClient;

  UserRepositoryImpl(this._supabaseClient);

  @override
  Future<Either<Failure, UserEntity>> getProfile(String userId) async {
    try {
      final response = await _supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      return Right(_mapProfileToEntity(response));
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile(UserEntity user) async {
    try {
      final updates = {
        'full_name': user.fullName,
        'updated_at': DateTime.now().toIso8601String(),
      };

      final response = await _supabaseClient
          .from('profiles')
          .update(updates)
          .eq('id', user.id)
          .select()
          .single();

      return Right(_mapProfileToEntity(response));
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateAvatar({
    required String userId,
    required String imagePath,
  }) async {
    try {
      final file = File(imagePath);
      final fileExt = imagePath.split('.').last;
      final fileName =
          '$userId/avatar_${DateTime.now().millisecondsSinceEpoch}.$fileExt';

      await _supabaseClient.storage.from('avatars').upload(fileName, file);

      final imageUrl =
          _supabaseClient.storage.from('avatars').getPublicUrl(fileName);

      await _supabaseClient
          .from('profiles')
          .update({'avatar_url': imageUrl}).eq('id', userId);

      return Right(imageUrl);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateGoals({
    required String userId,
    required List<String> goals,
  }) async {
    try {
      await _supabaseClient
          .from('profiles')
          .update({'goals': goals}).eq('id', userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateDietaryPreferences({
    required String userId,
    required List<String> preferences,
  }) async {
    try {
      await _supabaseClient
          .from('profiles')
          .update({'dietary_preferences': preferences}).eq('id', userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateReminderSettings({
    required String userId,
    required bool enabled,
    String? time,
  }) async {
    try {
      final updates = {
        'daily_reminder_enabled': enabled,
        if (time != null) 'daily_reminder_time': time,
      };
      await _supabaseClient.from('profiles').update(updates).eq('id', userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> completeOnboarding(String userId) async {
    try {
      await _supabaseClient
          .from('profiles')
          .update({'is_onboarding_completed': true}).eq('id', userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(String userId) async {
    try {
      await _supabaseClient.from('profiles').delete().eq('id', userId);
      await _supabaseClient.auth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  UserEntity _mapProfileToEntity(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      email: json['email'] ?? '',
      fullName: json['full_name'] ?? '',
      avatarUrl: json['avatar_url'],
      phone: json['phone'],
      goals: List<String>.from(json['goals'] ?? []),
      dietaryPreferences: List<String>.from(json['dietary_preferences'] ?? []),
      onboardingCompleted: json['is_onboarding_completed'] ?? false,
      dailyReminderEnabled: json['daily_reminder_enabled'] ?? true,
      reminderTime: json['daily_reminder_time'],
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}
