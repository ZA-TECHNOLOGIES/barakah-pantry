import 'package:barakah_pantry/core/constants/route_constants.dart';
import 'package:get/get.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../domain/entities/daily_tip_entity.dart';
import '../../../../domain/entities/ingredient_entity.dart';
import '../../../../domain/entities/recipe_entity.dart';
import '../../../../domain/usecases/daily_tip/get_today_tip_usecase.dart';
import '../../../../domain/usecases/ingredient/get_featured_ingredient_usecase.dart';
import '../../../../domain/usecases/recipe/get_featured_recipes_usecase.dart';

class HomeController extends GetxController {
  final GetTodayTipUseCase _getTodayTipUseCase;
  final GetFeaturedIngredientUseCase _getFeaturedIngredientUseCase;
  final GetFeaturedRecipesUseCase _getFeaturedRecipesUseCase;

  HomeController(
    this._getTodayTipUseCase,
    this._getFeaturedIngredientUseCase,
    this._getFeaturedRecipesUseCase,
  );

  final isLoading = true.obs;
  final dailyTip = Rx<DailyTipEntity?>(null);
  final featuredIngredient = Rx<IngredientEntity?>(null);
  final trendingRecipes = <RecipeEntity>[].obs;
  final errorMessage = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    isLoading.value = true;
    errorMessage.value = null;

    // Parallel execution for performance
    final results = await Future.wait([
      _getTodayTipUseCase(const NoParams()),
      _getFeaturedIngredientUseCase(const NoParams()),
      _getFeaturedRecipesUseCase(5),
    ]);

    // Handle Daily Tip
    results[0].fold(
      (l) => null, // Silently fail or log
      (r) => dailyTip.value = r as DailyTipEntity,
    );

    // Handle Featured Ingredient
    results[1].fold(
      (l) => null,
      (r) => featuredIngredient.value = r as IngredientEntity,
    );

    // Handle Featured Recipes
    results[2].fold(
      (l) => errorMessage.value =
          l is ServerFailure ? l.message : 'Error loading data',
      (r) => trendingRecipes.value = r as List<RecipeEntity>,
    );

    isLoading.value = false;
  }

  Future<void> refreshData() async {
    await loadHomeData();
  }

  void navigateToIngredient(IngredientEntity ingredient) {
    Get.toNamed(RouteConstants.ingredientDetailPath(ingredient.id),
        arguments: ingredient);
  }

  void navigateToRecipe(RecipeEntity recipe) {
    Get.toNamed(RouteConstants.recipeDetailPath(recipe.id), arguments: recipe);
  }

  void navigateToAIRecipe() {
    Get.toNamed(RouteConstants.aiRecipe);
  }
}
