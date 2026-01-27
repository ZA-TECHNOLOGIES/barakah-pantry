import 'package:get/get.dart';
import 'package:barakah_pantry/core/constants/route_constants.dart';
import 'package:barakah_pantry/features/auth/presentation/controllers/auth_controller.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // Wait for splash screen to show for at least 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    final authController = Get.find<AuthController>();
    // The auth check logic is in AuthController.checkAuthStatus()
    // but we can add additional logic here if needed.
    // For now, let's assume AuthController handles navigation if logged in.
    // If not, we go to onboarding.

    if (authController.currentUser.value == null) {
      Get.offAllNamed(RouteConstants.onboarding);
    }
  }
}
