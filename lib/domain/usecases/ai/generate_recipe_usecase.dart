import 'package:barakah_pantry/core/errors/failures.dart';
import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:barakah_pantry/domain/entities/recipe_entity.dart';
import 'package:barakah_pantry/domain/repositories/ai_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GenerateRecipeParams extends Equatable {
  final List<String> ingredients;
  final String? mealType;
  final String? dietaryGoal;
  final int? servings;
  final int? timeConstraint;

  const GenerateRecipeParams({
    required this.ingredients,
    this.mealType,
    this.dietaryGoal,
    this.servings,
    this.timeConstraint,
  });

  @override
  List<Object?> get props => [
        ingredients,
        mealType,
        dietaryGoal,
        servings,
        timeConstraint,
      ];
}

class GenerateRecipeUseCase
    implements UseCase<RecipeEntity, GenerateRecipeParams> {
  final AIRepository repository;

  GenerateRecipeUseCase(this.repository);

  @override
  Future<Either<Failure, RecipeEntity>> call(
      GenerateRecipeParams params) async {
    return await repository.generateRecipe(
      ingredients: params.ingredients,
      mealType: params.mealType,
      dietaryGoal: params.dietaryGoal,
      servings: params.servings,
      timeConstraint: params.timeConstraint,
    );
  }
}
