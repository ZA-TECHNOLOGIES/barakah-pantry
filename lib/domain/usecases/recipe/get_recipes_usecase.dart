import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import 'package:barakah_pantry/core/usecase/usecase.dart';
import '../../repositories/recipe_repository.dart';
import '../../entities/recipe_entity.dart';

class GetRecipesUseCase
    implements UseCase<List<RecipeEntity>, GetRecipesParams> {
  final RecipeRepository repository;

  GetRecipesUseCase(this.repository);

  @override
  Future<Either<Failure, List<RecipeEntity>>> call(
      GetRecipesParams params) async {
    return await repository.getRecipes(
      category: params.category,
      isApproved: params.isApproved,
      isFeatured: params.isFeatured,
    );
  }
}

class GetRecipesParams extends Equatable {
  final String? category;
  final bool? isApproved;
  final bool? isFeatured;

  const GetRecipesParams({this.category, this.isApproved, this.isFeatured});

  @override
  List<Object?> get props => [category, isApproved, isFeatured];
}
