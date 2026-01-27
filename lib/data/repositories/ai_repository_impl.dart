import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../core/errors/failures.dart';
import '../../domain/entities/recipe_entity.dart';
import '../../domain/repositories/ai_repository.dart';
import '../datasources/remote/gemini_datasource.dart';
import '../models/recipe_model.dart';

class AIRepositoryImpl implements AIRepository {
  final GeminiDatasource _geminiDatasource;
  final supabase.SupabaseClient _supabaseClient;

  AIRepositoryImpl(this._geminiDatasource, this._supabaseClient);

  @override
  Future<Either<Failure, RecipeEntity>> generateRecipe({
    required List<String> ingredients,
    String? mealType,
    String? dietaryGoal,
    int? servings,
    int? timeConstraint,
  }) async {
    try {
      final json = await _geminiDatasource.generateRecipe(
        ingredients: ingredients,
        mealType: mealType ?? 'Any',
        servings: servings ?? 2,
        dietaryGoal: dietaryGoal,
        timeConstraint: timeConstraint,
      );

      return Right(RecipeModel.fromJson(json));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getSunnahAlternative(
      String ingredient) async {
    try {
      final result = await _geminiDatasource.getSunnahAlternative(ingredient);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, bool>>> validateSunnahIngredients(
      List<String> ingredients) async {
    try {
      final result =
          await _geminiDatasource.validateSunnahIngredients(ingredients);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveGeneratedRecipe({
    required String userId,
    required List<String> inputIngredients,
    required RecipeEntity recipe,
    String? mealType,
  }) async {
    try {
      final model = RecipeModel.fromEntity(recipe);
      final json = model.toJson();
      json.remove('id');
      json['user_id'] = userId;
      json['is_ai_generated'] = true;

      final response =
          await _supabaseClient.from('recipes').insert(json).select().single();

      await _supabaseClient.from('ai_generations').insert({
        'user_id': userId,
        'input_ingredients': inputIngredients,
        'generated_recipe_id': response['id'],
        'meal_type': mealType,
        'created_at': DateTime.now().toIso8601String(),
      });

      return const Right(null);
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
