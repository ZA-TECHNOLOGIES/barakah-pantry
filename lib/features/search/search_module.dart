import 'package:get/get.dart';
import 'presentation/controllers/search_controller.dart';

class SearchModule extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController(Get.find(), Get.find()), fenix: true);
  }
}
