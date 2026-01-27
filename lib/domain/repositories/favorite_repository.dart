import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/favorite_entity.dart';
import '../entities/recipe_entity.dart';

/// Favorite Repository
/// Repository for favorite operations
abstract class FavoriteRepository {
  /// Get user's favorite recipes
  Future<Either<Failure, List<RecipeEntity>>> getFavorites(String userId);

  /// Add recipe to favorites
  Future<Either<Failure, void>> addFavorite({
    required String userId,
    required String recipeId,
  });

  /// Remove recipe from favorites
  Future<Either<Failure, void>> removeFavorite({
    required String userId,
    required String recipeId,
  });

  /// Check if recipe is favorited
  Future<Either<Failure, bool>> isFavorite({
    required String userId,
    required String recipeId,
  });

  /// Get favorite count for a recipe
  Future<Either<Failure, int>> getFavoriteCount(String recipeId);
}
