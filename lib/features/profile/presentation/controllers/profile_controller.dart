import 'package:get/get.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/usecases/user/get_profile_usecase.dart';
import 'package:flutter/material.dart';
import 'package:barakah_pantry/core/constants/route_constants.dart';
import '../../../../domain/usecases/auth/logout_usecase.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  final GetProfileUseCase _getProfileUseCase;
  final LogoutUseCase _logoutUseCase;

  ProfileController(
    this._getProfileUseCase,
    this._logoutUseCase,
  );

  final isLoading = true.obs;
  final userProfile = Rx<UserEntity?>(null);

  // Cooking Stats (could be separate use case)
  final recipesCooked = 0.obs;
  final currentStreak = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final authController = Get.find<AuthController>();
    final currentUser = authController.currentUser.value;

    if (currentUser == null) {
      isLoading.value = false;
      return;
    }

    isLoading.value = true;
    final result =
        await _getProfileUseCase(GetProfileParams(userId: currentUser.id));

    result.fold((l) => null, // Handle error
        (r) {
      userProfile.value = r;
      // Mock stats for MVP or fetch real stats if use case exists
      recipesCooked.value = 12;
      currentStreak.value = 5;
    });
    isLoading.value = false;
  }

  void navigateToEditProfile() {
    Get.toNamed(RouteConstants.editProfile);
  }

  void navigateToSettings() {
    Get.toNamed(RouteConstants.settings);
  }

  Future<void> logout() async {
    await _logoutUseCase(const NoParams());
    Get.offAllNamed(RouteConstants.login);
  }
}
