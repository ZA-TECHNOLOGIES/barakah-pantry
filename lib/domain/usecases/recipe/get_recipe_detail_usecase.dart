import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import '../../repositories/recipe_repository.dart';
import '../../entities/recipe_entity.dart';

class GetRecipeDetailUseCase implements UseCase<RecipeEntity, GetRecipeParams> {
  final RecipeRepository repository;

  GetRecipeDetailUseCase(this.repository);

  @override
  Future<Either<Failure, RecipeEntity>> call(GetRecipeParams params) async {
    return await repository.getRecipeById(params.id);
  }
}

class GetRecipeParams extends Equatable {
  final String id;

  const GetRecipeParams({required this.id});

  @override
  List<Object?> get props => [id];
}
