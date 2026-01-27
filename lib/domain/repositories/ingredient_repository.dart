import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/ingredient_entity.dart';

/// Ingredient Repository
/// Repository for ingredient operations
abstract class IngredientRepository {
  /// Get all ingredients
  Future<Either<Failure, List<IngredientEntity>>> getIngredients({
    String? category,
    bool? isSunnah,
  });

  /// Get ingredient by ID
  Future<Either<Failure, IngredientEntity>> getIngredientById(String id);

  /// Get ingredient by slug
  Future<Either<Failure, IngredientEntity>> getIngredientBySlug(String slug);

  /// Search ingredients
  Future<Either<Failure, List<IngredientEntity>>> searchIngredients(
    String query,
  );

  /// Get ingredients by category
  Future<Either<Failure, List<IngredientEntity>>> getIngredientsByCategory(
    String category,
  );

  /// Get featured ingredient
  Future<Either<Failure, IngredientEntity>> getFeaturedIngredient();

  /// Get random Sunnah ingredient
  Future<Either<Failure, IngredientEntity>> getRandomSunnahIngredient();
}
