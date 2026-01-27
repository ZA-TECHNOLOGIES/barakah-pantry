import 'package:get/get.dart';
import 'presentation/controllers/navigation_controller.dart';

class NavigationModule extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController(), fenix: true);
  }
}
