import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../core/errors/failures.dart';
import '../../domain/entities/cooking_history_entity.dart';
import '../../domain/repositories/cooking_history_repository.dart';
import '../models/cooking_history_model.dart';

class CookingHistoryRepositoryImpl implements CookingHistoryRepository {
  final supabase.SupabaseClient _supabaseClient;

  CookingHistoryRepositoryImpl(this._supabaseClient);

  @override
  Future<Either<Failure, List<CookingHistoryEntity>>> getHistory(
      String userId) async {
    try {
      final response = await _supabaseClient
          .from('cooking_history')
          .select('*, recipe:recipes(*)')
          .eq('user_id', userId)
          .order('cooked_at', ascending: false);

      final history = (response as List).map((json) {
        return CookingHistoryModel.fromJson(json);
      }).toList();

      return Right(history);
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addToHistory({
    required String userId,
    required String recipeId,
    String? notes,
    double? rating,
  }) async {
    try {
      await _supabaseClient.from('cooking_history').insert({
        'user_id': userId,
        'recipe_id': recipeId,
        'notes': notes,
        'rating': rating,
        'cooked_at': DateTime.now().toIso8601String(),
      });
      return const Right(null);
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getCookingStats(
      String userId) async {
    try {
      final countResponse = await _supabaseClient
          .from('cooking_history')
          .count()
          .eq('user_id', userId);

      return Right({
        'total_cooked': countResponse,
        'current_streak': 0,
      });
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
