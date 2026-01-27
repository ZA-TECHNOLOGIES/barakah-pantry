import 'package:get/get.dart';
import 'presentation/controllers/progress_controller.dart';

class ProgressModule extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProgressController(Get.find(), Get.find()), fenix: true);
  }
}
