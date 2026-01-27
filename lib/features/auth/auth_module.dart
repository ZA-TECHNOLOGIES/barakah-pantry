import 'package:get/get.dart';
import '../../domain/usecases/auth/check_auth_usecase.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/logout_usecase.dart';
import '../../domain/usecases/auth/reset_password_usecase.dart';
import '../../domain/usecases/auth/signup_usecase.dart';
import 'presentation/controllers/auth_controller.dart';

class AuthModule extends Bindings {
  @override
  void dependencies() {
    // Usecases
    Get.lazyPut(() => LoginUseCase(Get.find()));
    Get.lazyPut(() => SignupUseCase(Get.find()));
    Get.lazyPut(() => LogoutUseCase(Get.find()));
    Get.lazyPut(() => ResetPasswordUseCase(Get.find()));
    Get.lazyPut(() => GetCurrentUserUseCase(Get.find()));
    Get.lazyPut(() => IsAuthenticatedUseCase(Get.find()));

    // Controller
    Get.lazyPut(() => AuthController(
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          Get.find(),
          // IsAuthenticatedUseCase was removed from controller constructor
        ));
  }
}
