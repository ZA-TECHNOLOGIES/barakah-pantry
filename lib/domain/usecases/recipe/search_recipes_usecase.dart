import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import '../../repositories/recipe_repository.dart';
import '../../entities/recipe_entity.dart';

class SearchRecipesUseCase
    implements UseCase<List<RecipeEntity>, SearchRecipesParams> {
  final RecipeRepository repository;

  SearchRecipesUseCase(this.repository);

  @override
  Future<Either<Failure, List<RecipeEntity>>> call(
      SearchRecipesParams params) async {
    return await repository.searchRecipes(params.query);
  }
}

class SearchRecipesParams extends Equatable {
  final String query;

  const SearchRecipesParams({required this.query});

  @override
  List<Object?> get props => [query];
}
