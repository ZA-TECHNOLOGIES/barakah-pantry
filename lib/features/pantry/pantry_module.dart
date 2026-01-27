import 'package:get/get.dart';
import '../../domain/usecases/ingredient/get_ingredients_usecase.dart';
import '../../domain/usecases/ingredient/get_ingredients_by_category_usecase.dart';
import '../../domain/usecases/ingredient/search_ingredients_usecase.dart';
import '../../domain/usecases/ingredient/get_ingredient_detail_usecase.dart';
import 'presentation/controllers/pantry_controller.dart';
import 'presentation/controllers/ingredient_detail_controller.dart';

class PantryModule extends Bindings {
  @override
  void dependencies() {
    // Usecases
    Get.lazyPut(() => GetIngredientsUseCase(Get.find()));
    Get.lazyPut(() => GetIngredientsByCategoryUseCase(Get.find()));
    Get.lazyPut(() => SearchIngredientsUseCase(Get.find()));
    Get.lazyPut(() => GetIngredientDetailUseCase(Get.find()));

    // Controllers
    Get.lazyPut(
      () => PantryController(
        Get.find(),
        Get.find(),
        Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut(
      () => IngredientDetailController(
        Get.find(),
      ),
      fenix: true,
    );
  }
}
