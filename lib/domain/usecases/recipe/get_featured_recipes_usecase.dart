import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import '../../repositories/recipe_repository.dart';
import '../../entities/recipe_entity.dart';

class GetFeaturedRecipesUseCase implements UseCase<List<RecipeEntity>, int> {
  final RecipeRepository repository;

  GetFeaturedRecipesUseCase(this.repository);

  @override
  Future<Either<Failure, List<RecipeEntity>>> call(int limit) async {
    return await repository.getFeaturedRecipes(limit: limit);
  }
}
