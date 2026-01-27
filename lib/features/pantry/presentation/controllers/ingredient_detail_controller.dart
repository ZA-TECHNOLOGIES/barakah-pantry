import 'package:get/get.dart';
import '../../../../domain/entities/ingredient_entity.dart';
import '../../../../domain/usecases/ingredient/get_ingredient_detail_usecase.dart';

class IngredientDetailController extends GetxController {
  final GetIngredientDetailUseCase _getIngredientDetailUseCase;

  IngredientDetailController(this._getIngredientDetailUseCase);

  final ingredient = Rx<IngredientEntity?>(null);

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is IngredientEntity) {
      ingredient.value = Get.arguments as IngredientEntity;
    } else if (Get.arguments is String) {
      loadIngredient(Get.arguments as String);
    }
  }

  Future<void> loadIngredient(String id) async {
    final result =
        await _getIngredientDetailUseCase(GetIngredientDetailParams(id: id));
    result.fold((l) => null, (r) => ingredient.value = r);
  }

  void shareIngredient() {
    if (ingredient.value == null) return;
    // Implement share logic
  }
}
