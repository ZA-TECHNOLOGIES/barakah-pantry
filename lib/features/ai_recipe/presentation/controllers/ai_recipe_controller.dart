import 'package:barakah_pantry/core/constants/route_constants.dart';
import 'package:barakah_pantry/core/theme/app_colors.dart';
import 'package:barakah_pantry/core/utils/helpers/ui_helper.dart';
import 'package:get/get.dart';
import '../../../../core/errors/failures.dart';
import '../../../../domain/entities/ingredient_entity.dart';
import '../../../../domain/entities/recipe_entity.dart';
import '../../../../domain/usecases/ai/generate_recipe_usecase.dart';
import '../../../../domain/usecases/ai/save_generated_recipe_usecase.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class AIRecipeController extends GetxController {
  final GenerateRecipeUseCase _generateRecipeUseCase;
  final SaveGeneratedRecipeUseCase _saveGeneratedRecipeUseCase;

  AIRecipeController(
    this._generateRecipeUseCase,
    this._saveGeneratedRecipeUseCase,
  );

  final isGenerating = false.obs;
  final generatedRecipe = Rx<RecipeEntity?>(null);
  final errorMessage = Rx<String?>(null);

  // Inputs
  final selectedIngredients = <IngredientEntity>[].obs;
  final mealType = Rx<String?>(null);
  final servings = 2.obs;
  final dietaryGoal = Rx<String?>(null);

  final mealTypes = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
    'Dessert',
    'Drink'
  ];
  final dietaryGoals = [
    'Sunnah Focus',
    'High Protein',
    'Low Carb',
    'Quick & Easy'
  ];

  void toggleIngredient(IngredientEntity ingredient) {
    if (selectedIngredients.contains(ingredient)) {
      selectedIngredients.remove(ingredient);
    } else {
      selectedIngredients.add(ingredient);
    }
  }

  void setMealType(String? type) {
    mealType.value = type;
  }

  void setDietaryGoal(String? goal) {
    dietaryGoal.value = goal;
  }

  void updateServings(int count) {
    servings.value = count;
  }

  Future<void> generateRecipe() async {
    if (selectedIngredients.isEmpty) {
      UIHelper.showSnackbar(
        title: 'Error',
        message: 'Please select at least one ingredient',
        backgroundColor: AppColors.error,
      );
      return;
    }

    isGenerating.value = true;
    errorMessage.value = null;

    final result = await _generateRecipeUseCase(GenerateRecipeParams(
      ingredients: selectedIngredients.map((e) => e.name).toList(),
      mealType: mealType.value,
      servings: servings.value,
      dietaryGoal: dietaryGoal.value,
    ));

    result.fold(
      (failure) {
        isGenerating.value = false;
        errorMessage.value = _mapFailureToMessage(failure);
        UIHelper.showSnackbar(
          title: 'Error',
          message: errorMessage.value!,
          backgroundColor: AppColors.error,
        );
      },
      (recipe) {
        generatedRecipe.value = recipe;
        isGenerating.value = false;
        Get.toNamed(RouteConstants.aiRecipeResult, arguments: recipe);
      },
    );
  }

  Future<void> saveRecipe() async {
    if (generatedRecipe.value == null) return;

    final authController = Get.find<AuthController>();
    final user = authController.currentUser.value;

    if (user == null) {
      UIHelper.showSnackbar(
        title: 'Error',
        message: 'You must be logged in to save recipes',
        backgroundColor: AppColors.error,
      );
      return;
    }

    final result = await _saveGeneratedRecipeUseCase(SaveGeneratedRecipeParams(
      userId: user.id,
      inputIngredients: selectedIngredients.map((e) => e.name).toList(),
      recipe: generatedRecipe.value!,
      mealType: mealType.value,
    ));

    result.fold(
      (failure) {
        UIHelper.showSnackbar(
          title: 'Error',
          message: 'Failed to save recipe',
          backgroundColor: AppColors.error,
        );
      },
      (_) {
        UIHelper.showSnackbar(
          title: 'Success',
          message: 'Recipe saved to your collection',
          backgroundColor: AppColors.success,
        );
      },
    );
  }

  void regenerate() {
    generateRecipe();
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return failure.message;
    return 'Unexpected error occurred';
  }
}
