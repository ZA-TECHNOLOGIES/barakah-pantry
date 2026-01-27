import 'package:get/get.dart';
import '../../domain/usecases/daily_tip/get_today_tip_usecase.dart';
import '../../domain/usecases/ingredient/get_featured_ingredient_usecase.dart';
import '../../domain/usecases/recipe/get_featured_recipes_usecase.dart';
import 'presentation/controllers/home_controller.dart';

class HomeModule extends Bindings {
  @override
  void dependencies() {
    // Usecases
    Get.lazyPut(() => GetTodayTipUseCase(Get.find()));
    Get.lazyPut(() => GetFeaturedIngredientUseCase(Get.find()));
    Get.lazyPut(() => GetFeaturedRecipesUseCase(Get.find()));

    // Controller
    Get.lazyPut(() => HomeController(Get.find(), Get.find(), Get.find()));
  }
}
