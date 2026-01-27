import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../core/errors/failures.dart';
import '../../domain/entities/recipe_entity.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../models/recipe_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final supabase.SupabaseClient _supabaseClient;

  RecipeRepositoryImpl(this._supabaseClient);

  @override
  Future<Either<Failure, List<RecipeEntity>>> getRecipes({
    String? category,
    bool? isApproved,
    bool? isFeatured,
  }) async {
    try {
      var query = _supabaseClient.from('recipes').select();

      if (category != null && category != 'All') {
        query = query.eq('category', category);
      }

      if (isApproved != null) {
        query = query.eq('is_approved', isApproved);
      }

      if (isFeatured != null) {
        query = query.eq('is_featured', isFeatured);
      }

      final response = await query.order('created_at', ascending: false);
      final recipes =
          (response as List).map((json) => RecipeModel.fromJson(json)).toList();

      return Right(recipes);
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RecipeEntity>> getRecipeById(String id) async {
    try {
      final response =
          await _supabaseClient.from('recipes').select().eq('id', id).single();

      return Right(RecipeModel.fromJson(response));
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RecipeEntity>> getRecipeBySlug(String slug) async {
    try {
      final response = await _supabaseClient
          .from('recipes')
          .select()
          .eq('slug', slug)
          .single();

      return Right(RecipeModel.fromJson(response));
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> searchRecipes(
      String query) async {
    try {
      final response = await _supabaseClient
          .from('recipes')
          .select()
          .ilike('title', '%$query%')
          .order('created_at', ascending: false);

      final recipes =
          (response as List).map((json) => RecipeModel.fromJson(json)).toList();

      return Right(recipes);
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> getFeaturedRecipes(
      {int limit = 10}) async {
    try {
      final response = await _supabaseClient
          .from('recipes')
          .select()
          .eq('is_featured', true)
          .limit(limit);

      final recipes =
          (response as List).map((json) => RecipeModel.fromJson(json)).toList();

      return Right(recipes);
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> getRecipesByCategory(
      String category) async {
    return getRecipes(category: category);
  }

  @override
  Future<Either<Failure, void>> rateRecipe({
    required String recipeId,
    required String userId,
    required double rating,
    String? comment,
  }) async {
    try {
      await _supabaseClient.from('recipe_ratings').upsert({
        'user_id': userId,
        'recipe_id': recipeId,
        'rating': rating,
        'comment': comment,
        'updated_at': DateTime.now().toIso8601String(),
      });
      return const Right(null);
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> incrementViewCount(String recipeId) async {
    try {
      // Logic for incrementing view count
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RecipeEntity>> createRecipe(
      RecipeEntity recipe) async {
    try {
      final model = RecipeModel.fromEntity(recipe);
      final json = model.toJson();
      json.remove('id');

      final response =
          await _supabaseClient.from('recipes').insert(json).select().single();

      return Right(RecipeModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, RecipeEntity>> updateRecipe(
      RecipeEntity recipe) async {
    try {
      final model = RecipeModel.fromEntity(recipe);
      final json = model.toJson();

      final response = await _supabaseClient
          .from('recipes')
          .update(json)
          .eq('id', recipe.id)
          .select()
          .single();

      return Right(RecipeModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRecipe(String id) async {
    try {
      await _supabaseClient.from('recipes').delete().eq('id', id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
