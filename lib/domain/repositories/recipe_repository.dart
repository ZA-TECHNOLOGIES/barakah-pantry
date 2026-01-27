import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/recipe_entity.dart';

/// Recipe Repository
/// Repository for recipe operations
abstract class RecipeRepository {
  /// Get all recipes
  Future<Either<Failure, List<RecipeEntity>>> getRecipes({
    String? category,
    bool? isApproved,
    bool? isFeatured,
  });

  /// Get recipe by ID
  Future<Either<Failure, RecipeEntity>> getRecipeById(String id);

  /// Get recipe by slug
  Future<Either<Failure, RecipeEntity>> getRecipeBySlug(String slug);

  /// Get featured recipes
  Future<Either<Failure, List<RecipeEntity>>> getFeaturedRecipes(
      {int limit = 10});

  /// Get recipes by category
  Future<Either<Failure, List<RecipeEntity>>> getRecipesByCategory(
      String category);

  /// Search recipes
  Future<Either<Failure, List<RecipeEntity>>> searchRecipes(String query);

  /// Create recipe
  Future<Either<Failure, RecipeEntity>> createRecipe(RecipeEntity recipe);

  /// Update recipe
  Future<Either<Failure, RecipeEntity>> updateRecipe(RecipeEntity recipe);

  /// Delete recipe
  Future<Either<Failure, void>> deleteRecipe(String id);

  /// Rate recipe
  Future<Either<Failure, void>> rateRecipe({
    required String recipeId,
    required String userId,
    required double rating,
    String? comment,
  });

  /// Increment view count
  Future<Either<Failure, void>> incrementViewCount(String recipeId);
}
