import 'package:barakah_pantry/core/errors/failures.dart';
import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:barakah_pantry/domain/entities/recipe_entity.dart';
import 'package:barakah_pantry/domain/repositories/ai_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SaveGeneratedRecipeParams extends Equatable {
  final String userId;
  final RecipeEntity recipe;
  final List<String> inputIngredients;
  final String? mealType;

  const SaveGeneratedRecipeParams({
    required this.userId,
    required this.recipe,
    required this.inputIngredients,
    this.mealType,
  });

  @override
  List<Object?> get props => [userId, recipe, inputIngredients, mealType];
}

class SaveGeneratedRecipeUseCase
    implements UseCase<void, SaveGeneratedRecipeParams> {
  final AIRepository repository;

  SaveGeneratedRecipeUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SaveGeneratedRecipeParams params) async {
    return await repository.saveGeneratedRecipe(
      userId: params.userId,
      recipe: params.recipe,
      inputIngredients: params.inputIngredients,
      mealType: params.mealType,
    );
  }
}
