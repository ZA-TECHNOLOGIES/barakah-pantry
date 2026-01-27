import 'package:get/get.dart';
import '../../domain/usecases/favorite/get_favorites_usecase.dart';
import '../../domain/usecases/favorite/remove_favorite_usecase.dart';
import 'presentation/controllers/favorites_controller.dart';

class FavoritesModule extends Bindings {
  @override
  void dependencies() {
    // Usecases
    Get.lazyPut(() => GetFavoritesUseCase(Get.find()));
    Get.lazyPut(() => RemoveFavoriteUseCase(Get.find()));

    // Controller
    Get.lazyPut(() => FavoritesController(Get.find(), Get.find()), fenix: true);
  }
}
