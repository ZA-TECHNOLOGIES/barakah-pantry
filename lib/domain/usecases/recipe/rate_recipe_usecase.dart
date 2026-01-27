import 'package:barakah_pantry/core/errors/failures.dart';
import 'package:barakah_pantry/domain/repositories/recipe_repository.dart';
import 'package:dartz/dartz.dart';

class RateRecipeParams {
  final String recipeId;
  final String userId;
  final double rating;
  final String? comment;

  RateRecipeParams(
      {required this.recipeId,
      required this.userId,
      required this.rating,
      this.comment});
}

class RateRecipeUseCase {
  final RecipeRepository repository;

  RateRecipeUseCase(this.repository);

  Future<Either<Failure, void>> call(RateRecipeParams params) async {
    return await repository.rateRecipe(
      recipeId: params.recipeId,
      userId: params.userId,
      rating: params.rating,
      comment: params.comment,
    );
  }
}
