import 'package:get/get.dart';
import '../../domain/usecases/user/get_profile_usecase.dart';
import '../../domain/usecases/user/update_profile_usecase.dart';
import '../../domain/usecases/user/delete_account_usecase.dart';
import 'presentation/controllers/profile_controller.dart';
import 'presentation/controllers/settings_controller.dart';

class ProfileModule extends Bindings {
  @override
  void dependencies() {
    // Usecases
    Get.lazyPut(() => GetProfileUseCase(Get.find()));
    Get.lazyPut(() => UpdateProfileUseCase(Get.find()));
    Get.lazyPut(() => DeleteAccountUseCase(Get.find()));

    // Controllers
    Get.lazyPut(() => ProfileController(Get.find(), Get.find()), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
  }
}
