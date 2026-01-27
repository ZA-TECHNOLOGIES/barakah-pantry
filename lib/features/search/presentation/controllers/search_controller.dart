import 'package:barakah_pantry/core/constants/route_constants.dart';
import 'package:get/get.dart';
import '../../../../domain/entities/ingredient_entity.dart';
import '../../../../domain/entities/recipe_entity.dart';
import '../../../../domain/usecases/ingredient/search_ingredients_usecase.dart';
import '../../../../domain/usecases/recipe/search_recipes_usecase.dart';

class SearchController extends GetxController {
  final SearchIngredientsUseCase _searchIngredientsUseCase;
  final SearchRecipesUseCase _searchRecipesUseCase;

  SearchController(
    this._searchIngredientsUseCase,
    this._searchRecipesUseCase,
  );

  final isLoading = false.obs;
  final searchQuery = ''.obs;
  final searchResultsRecipes = <RecipeEntity>[].obs;
  final searchResultsIngredients = <IngredientEntity>[].obs;
  final recentSearches = <String>[].obs; // Should cache locally

  @override
  void onInit() {
    super.onInit();
    debounce(searchQuery, (_) => performSearch(),
        time: const Duration(milliseconds: 500));
  }

  void performSearch() async {
    if (searchQuery.value.isEmpty) {
      searchResultsRecipes.clear();
      searchResultsIngredients.clear();
      return;
    }

    isLoading.value = true;
    _addToRecent(searchQuery.value);

    // Parallel search using Future.wait
    // Note: results will be Either<Failure, List<T>>
    final results = await Future.wait([
      _searchRecipesUseCase(SearchRecipesParams(query: searchQuery.value)),
      _searchIngredientsUseCase(
          SearchIngredientsParams(query: searchQuery.value)),
    ]);

    // Handle Recipe results
    results[0].fold(
      (l) => searchResultsRecipes.clear(),
      (r) => searchResultsRecipes.value = r as List<RecipeEntity>,
    );

    // Handle Ingredient results
    results[1].fold(
      (l) => searchResultsIngredients.clear(),
      (r) => searchResultsIngredients.value = r as List<IngredientEntity>,
    );

    isLoading.value = false;
  }

  void _addToRecent(String query) {
    if (!recentSearches.contains(query)) {
      recentSearches.insert(0, query);
      if (recentSearches.length > 5) recentSearches.removeLast();
    }
  }

  void clearRecentSearches() {
    recentSearches.clear();
  }

  void navigateToRecipe(RecipeEntity recipe) {
    Get.toNamed(
      RouteConstants.recipeDetailPath(recipe.id),
      arguments: recipe,
    );
  }

  void navigateToIngredient(IngredientEntity ingredient) {
    Get.toNamed(
      RouteConstants.ingredientDetailPath(ingredient.id),
      arguments: ingredient,
    );
  }
}
