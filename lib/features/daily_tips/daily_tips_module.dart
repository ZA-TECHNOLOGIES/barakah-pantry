import 'package:get/get.dart';
import '../../domain/usecases/daily_tip/get_all_tips_usecase.dart';
import '../../domain/usecases/daily_tip/get_today_tip_usecase.dart';
import 'presentation/controllers/daily_tips_controller.dart';

class DailyTipsModule extends Bindings {
  @override
  void dependencies() {
    // Usecases
    Get.lazyPut(() => GetTodayTipUseCase(Get.find()));
    Get.lazyPut(() => GetAllTipsUseCase(Get.find()));

    // Controller
    Get.lazyPut(() => DailyTipsController(Get.find(), Get.find()), fenix: true);
  }
}
