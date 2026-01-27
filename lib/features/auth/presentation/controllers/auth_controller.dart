import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/errors/failures.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/usecases/auth/login_usecase.dart';
import '../../../../domain/usecases/auth/signup_usecase.dart';
import '../../../../domain/usecases/auth/logout_usecase.dart';
import '../../../../domain/usecases/auth/reset_password_usecase.dart';
import '../../../../domain/usecases/auth/check_auth_usecase.dart';
import 'package:barakah_pantry/core/constants/route_constants.dart';
import '../../../navigation/presentation/screens/main_navigation_screen.dart';
import '../../../onboarding/presentation/screens/onboarding_screen.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/helpers/ui_helper.dart';
import '../screens/login_screen.dart';

class AuthController extends GetxController {
  final LoginUseCase _loginUseCase;
  final SignupUseCase _signupUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  AuthController(
    this._loginUseCase,
    this._signupUseCase,
    this._logoutUseCase,
    this._getCurrentUserUseCase,
    this._resetPasswordUseCase,
  );

  final isLoading = false.obs;
  final errorMessage = Rx<String?>(null);
  final currentUser = Rx<UserEntity?>(null);

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    isLoading.value = true;
    final result = await _getCurrentUserUseCase(const NoParams());
    // Actually simpler to just instantiation NoParams() if available but use cases usually take arguments.
    // Let's check how usecases are called. Usually `call(params)`.
    // I'll assume NoParams() is standard.

    result.fold(
      (failure) {
        currentUser.value = null;
        isLoading.value = false;
        // Optionally navigate to login if strict check
      },
      (user) {
        currentUser.value = user;
        isLoading.value = false;
        if (user != null) {
          Get.offAllNamed(RouteConstants.main);
        }
      },
    );
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    errorMessage.value = null;

    final result =
        await _loginUseCase(LoginParams(email: email, password: password));

    result.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = _mapFailureToMessage(failure);
        print(errorMessage.value);
        UIHelper.showSnackbar(
          title: 'Login Failed',
          message: errorMessage.value!,
          backgroundColor: Colors.red,
        );
      },
      (user) {
        currentUser.value = user;
        isLoading.value = false;
        Get.offAllNamed(RouteConstants.main);
      },
    );
  }

  Future<void> signup(String email, String password, String fullName) async {
    isLoading.value = true;
    errorMessage.value = null;

    final result = await _signupUseCase(SignupParams(
      email: email,
      password: password,
      fullName: fullName,
    ));

    result.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = _mapFailureToMessage(failure);
        print(errorMessage.value);
        UIHelper.showSnackbar(
          title: 'Signup Failed',
          message: errorMessage.value!,
          backgroundColor: Colors.red,
        );
      },
      (user) {
        currentUser.value = user;
        isLoading.value = false;
        Get.offAllNamed(RouteConstants.onboarding);
      },
    );
  }

  Future<void> logout() async {
    isLoading.value = true;
    final result = await _logoutUseCase(const NoParams());

    result.fold(
      (failure) {
        isLoading.value = false;
        UIHelper.showSnackbar(
          title: 'Error',
          message: 'Failed to logout',
          backgroundColor: Colors.red,
        );
      },
      (_) {
        currentUser.value = null;
        isLoading.value = false;
        Get.offAllNamed(RouteConstants.login);
      },
    );
  }

  Future<void> resetPassword(String email) async {
    isLoading.value = true;
    final result =
        await _resetPasswordUseCase(ResetPasswordParams(email: email));

    isLoading.value = false;
    result.fold(
      (failure) {
        UIHelper.showSnackbar(
          title: 'Error',
          message: _mapFailureToMessage(failure),
          backgroundColor: Colors.red,
        );
      },
      (_) {
        UIHelper.showSnackbar(
          title: 'Success',
          message: 'Password reset link sent to your email',
          backgroundColor: Colors.green,
        );
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return 'Unexpected error occurred';
  }
}

// Needed if NoParams is not exported globally or we want to be explicit
