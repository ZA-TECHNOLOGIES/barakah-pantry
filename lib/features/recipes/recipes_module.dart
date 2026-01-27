import 'package:get/get.dart';
import '../../domain/usecases/recipe/get_recipes_usecase.dart';
import '../../domain/usecases/recipe/get_recipe_detail_usecase.dart';
import '../../domain/usecases/recipe/search_recipes_usecase.dart';
import '../../domain/usecases/recipe/get_recipes_by_category_usecase.dart';
import '../../domain/usecases/recipe/rate_recipe_usecase.dart';
import 'presentation/controllers/recipes_controller.dart';
import 'presentation/controllers/recipe_detail_controller.dart';

class RecipesModule extends Bindings {
  @override
  void dependencies() {
    // Usecases
    Get.lazyPut(() => GetRecipesUseCase(Get.find()));
    Get.lazyPut(() => GetRecipeDetailUseCase(Get.find()));
    Get.lazyPut(() => SearchRecipesUseCase(Get.find()));
    Get.lazyPut(() => GetRecipesByCategoryUseCase(Get.find()));
    Get.lazyPut(() => RateRecipeUseCase(Get.find()));

    // Controllers
    Get.lazyPut(() => RecipesController(Get.find(), Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut(
        () => RecipeDetailController(
              Get.find(),
              Get.find(),
              Get.find(),
              Get.find(),
              Get.find(),
            ),
        fenix: true);
  }
}
