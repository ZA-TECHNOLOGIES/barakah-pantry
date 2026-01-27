import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/recipe_entity.dart';

/// AI Repository
/// Repository for AI-powered recipe generation
abstract class AIRepository {
  /// Generate a recipe based on user inputs
  Future<Either<Failure, RecipeEntity>> generateRecipe({
    required List<String> ingredients,
    String? mealType,
    String? dietaryGoal,
    int? servings,
    int? timeConstraint,
  });

  /// Get Sunnah alternative for a given ingredient
  Future<Either<Failure, String>> getSunnahAlternative(String ingredient);

  /// Validate if ingredients are Sunnah-compliant
  Future<Either<Failure, Map<String, bool>>> validateSunnahIngredients(
    List<String> ingredients,
  );

  /// Save AI-generated recipe to history
  Future<Either<Failure, void>> saveGeneratedRecipe({
    required String userId,
    required List<String> inputIngredients,
    required RecipeEntity recipe,
    String? mealType,
  });
}
