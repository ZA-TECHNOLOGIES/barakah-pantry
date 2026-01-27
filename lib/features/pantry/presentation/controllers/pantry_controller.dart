import 'package:get/get.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import 'package:barakah_pantry/core/constants/route_constants.dart';
import 'package:barakah_pantry/domain/entities/ingredient_entity.dart';
import 'package:barakah_pantry/domain/usecases/ingredient/get_ingredients_usecase.dart';
import 'package:barakah_pantry/domain/usecases/ingredient/search_ingredients_usecase.dart';
import 'package:barakah_pantry/domain/usecases/ingredient/get_ingredients_by_category_usecase.dart';

class PantryController extends GetxController {
  final GetIngredientsUseCase _getIngredientsUseCase;
  final SearchIngredientsUseCase _searchIngredientsUseCase;
  final GetIngredientsByCategoryUseCase _getIngredientsByCategoryUseCase;

  PantryController(
    this._getIngredientsUseCase,
    this._searchIngredientsUseCase,
    this._getIngredientsByCategoryUseCase,
  );

  final isLoading = true.obs;
  final errorMessage = Rx<String?>(null);

  // Data
  final allIngredients = <IngredientEntity>[].obs;
  final displayedIngredients = <IngredientEntity>[].obs;

  // Filters
  final selectedCategory = 'All'.obs;
  final isSunnahFilter = false.obs;
  final searchQuery = ''.obs;

  final categories = [
    'All',
    'Fruit',
    'Grain',
    'Oil',
    'Dairy',
    'Meat',
    'Spice',
    'Herb',
    'Sweetener',
    'Vegetable',
    'Other'
  ];

  @override
  void onInit() {
    super.onInit();
    loadIngredients();

    // Debounce search
    debounce(searchQuery, (_) => _performSearch(),
        time: const Duration(milliseconds: 500));
  }

  Future<void> loadIngredients() async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await _getIngredientsUseCase(const GetIngredientsParams());

    result.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = _mapFailureToMessage(failure);
      },
      (ingredients) {
        allIngredients.value = ingredients;
        _applyLocalFilters();
        isLoading.value = false;
      },
    );
  }

  void _performSearch() async {
    if (searchQuery.value.isEmpty) {
      _applyLocalFilters();
      return;
    }

    isLoading.value = true;
    final result = await _searchIngredientsUseCase(
        SearchIngredientsParams(query: searchQuery.value));

    result.fold((failure) {
      isLoading.value = false;
      errorMessage.value = _mapFailureToMessage(failure);
    }, (ingredients) {
      displayedIngredients.value = ingredients;
      isLoading.value = false;
    });
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    if (searchQuery.value.isEmpty) {
      _applyLocalFilters();
    } else {
      _performSearch();
    }
  }

  void _applyLocalFilters() {
    var list = allIngredients.toList();

    if (selectedCategory.value != 'All') {
      list = list.where((i) => i.category == selectedCategory.value).toList();
    }

    if (isSunnahFilter.value) {
      list = list.where((i) => i.isSunnah).toList();
    }

    displayedIngredients.value = list;
  }

  void navigateToIngredientDetail(IngredientEntity ingredient) {
    Get.toNamed(
      RouteConstants.ingredientDetailPath(ingredient.id),
      arguments: ingredient,
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return 'Unexpected error occurred';
  }
}
