import 'package:get/get.dart';
import '../../domain/usecases/ai/generate_recipe_usecase.dart';
import '../../domain/usecases/ai/save_generated_recipe_usecase.dart';
import 'presentation/controllers/ai_recipe_controller.dart';

class AIRecipeModule extends Bindings {
  @override
  void dependencies() {
    // Usecases
    Get.lazyPut(() => GenerateRecipeUseCase(Get.find()));
    Get.lazyPut(() => SaveGeneratedRecipeUseCase(Get.find()));

    // Controller
    Get.lazyPut(() => AIRecipeController(Get.find(), Get.find()));
  }
}
