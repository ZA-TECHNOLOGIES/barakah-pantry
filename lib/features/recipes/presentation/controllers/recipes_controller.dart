import 'package:barakah_pantry/core/constants/route_constants.dart';
import 'package:get/get.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import 'package:barakah_pantry/domain/entities/recipe_entity.dart';
import 'package:barakah_pantry/domain/usecases/recipe/get_recipes_usecase.dart';
import 'package:barakah_pantry/domain/usecases/recipe/search_recipes_usecase.dart';
import 'package:barakah_pantry/domain/usecases/recipe/get_recipes_by_category_usecase.dart';
import '../screens/recipe_detail_screen.dart';

class RecipesController extends GetxController {
  final GetRecipesUseCase _getRecipesUseCase;
  final SearchRecipesUseCase _searchRecipesUseCase;
  final GetRecipesByCategoryUseCase _getRecipesByCategoryUseCase;

  RecipesController(
    this._getRecipesUseCase,
    this._searchRecipesUseCase,
    this._getRecipesByCategoryUseCase,
  );

  final isLoading = true.obs;
  final errorMessage = Rx<String?>(null);

  final allRecipes = <RecipeEntity>[].obs;
  final displayedRecipes = <RecipeEntity>[].obs;

  final selectedCategory = 'All'.obs;
  final searchQuery = ''.obs;

  final categories = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
    'Drink',
    'Dessert',
  ];

  @override
  void onInit() {
    super.onInit();
    loadRecipes();
    debounce(searchQuery, (_) => _performSearch(),
        time: const Duration(milliseconds: 500));
  }

  Future<void> loadRecipes() async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await _getRecipesUseCase(const GetRecipesParams());

    result.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = _mapFailureToMessage(failure);
      },
      (recipes) {
        allRecipes.value = recipes;
        _applyFilters();
        isLoading.value = false;
      },
    );
  }

  void _performSearch() async {
    if (searchQuery.value.isEmpty) {
      _applyFilters();
      return;
    }

    isLoading.value = true;
    final result = await _searchRecipesUseCase(
        SearchRecipesParams(query: searchQuery.value));

    result.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = _mapFailureToMessage(failure);
      },
      (recipes) {
        displayedRecipes.value = recipes;
        isLoading.value = false;
      },
    );
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    if (searchQuery.value.isEmpty) {
      _applyFilters();
    } else {
      _performSearch();
    }
  }

  void _applyFilters() {
    var list = allRecipes.toList();
    if (selectedCategory.value != 'All') {
      list = list.where((r) => r.category == selectedCategory.value).toList();
    }
    displayedRecipes.value = list;
  }

  void navigateToRecipeDetail(RecipeEntity recipe) {
    Get.toNamed(
      RouteConstants.recipeDetailPath(recipe.id),
      arguments: recipe,
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return failure.message;
    return 'Unexpected error occurred';
  }
}
