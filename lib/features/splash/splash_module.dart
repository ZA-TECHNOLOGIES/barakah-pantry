import 'package:get/get.dart';
import 'presentation/controllers/splash_controller.dart';

class SplashModule extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
