import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../core/errors/failures.dart';
import '../../domain/entities/recipe_entity.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../models/recipe_model.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final supabase.SupabaseClient _supabaseClient;

  FavoriteRepositoryImpl(this._supabaseClient);

  @override
  Future<Either<Failure, List<RecipeEntity>>> getFavorites(
      String userId) async {
    try {
      final response = await _supabaseClient
          .from('favorites')
          .select('recipe:recipes(*)')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final recipes = (response as List).map((json) {
        final recipeJson = json['recipe'] as Map<String, dynamic>;
        return RecipeModel.fromJson(recipeJson);
      }).toList();

      return Right(recipes);
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite({
    required String userId,
    required String recipeId,
  }) async {
    try {
      await _supabaseClient.from('favorites').insert({
        'user_id': userId,
        'recipe_id': recipeId,
      });
      return const Right(null);
    } on supabase.PostgrestException catch (e) {
      if (e.code == '23505') {
        return const Right(null);
      }
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite({
    required String userId,
    required String recipeId,
  }) async {
    try {
      await _supabaseClient
          .from('favorites')
          .delete()
          .eq('user_id', userId)
          .eq('recipe_id', recipeId);
      return const Right(null);
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite({
    required String userId,
    required String recipeId,
  }) async {
    try {
      final response = await _supabaseClient
          .from('favorites')
          .select()
          .eq('user_id', userId)
          .eq('recipe_id', recipeId)
          .maybeSingle();

      return Right(response != null);
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getFavoriteCount(String recipeId) async {
    try {
      final response = await _supabaseClient
          .from('favorites')
          .count()
          .eq('recipe_id', recipeId);

      return Right(response);
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
