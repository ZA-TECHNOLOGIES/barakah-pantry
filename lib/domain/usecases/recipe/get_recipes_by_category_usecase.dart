import 'package:barakah_pantry/core/errors/failures.dart';
import 'package:barakah_pantry/domain/entities/recipe_entity.dart';
import 'package:barakah_pantry/domain/repositories/recipe_repository.dart';
import 'package:dartz/dartz.dart';

class GetRecipesByCategoryParams {
  final String category;
  final int? limit;
  final int? offset;

  GetRecipesByCategoryParams({required this.category, this.limit, this.offset});
}

class GetRecipesByCategoryUseCase {
  final RecipeRepository repository;

  GetRecipesByCategoryUseCase(this.repository);

  Future<Either<Failure, List<RecipeEntity>>> call(
      GetRecipesByCategoryParams params) async {
    return await repository.getRecipesByCategory(params.category);
  }
}
