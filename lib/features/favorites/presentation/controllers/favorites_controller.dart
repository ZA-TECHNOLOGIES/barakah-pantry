import 'package:barakah_pantry/core/utils/helpers/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/errors/failures.dart';
import '../../../../domain/entities/recipe_entity.dart';
import '../../../../domain/usecases/favorite/get_favorites_usecase.dart';
import '../../../../domain/usecases/favorite/remove_favorite_usecase.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class FavoritesController extends GetxController {
  final GetFavoritesUseCase _getFavoritesUseCase;
  final RemoveFavoriteUseCase _removeFavoriteUseCase;

  FavoritesController(
    this._getFavoritesUseCase,
    this._removeFavoriteUseCase,
  );

  final isLoading = true.obs;
  final favorites = <RecipeEntity>[].obs;
  final errorMessage = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final authController = Get.find<AuthController>();
    final user = authController.currentUser.value;

    if (user == null) {
      isLoading.value = false;
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    final result =
        await _getFavoritesUseCase(GetFavoritesParams(userId: user.id));

    result.fold(
      (failure) {
        isLoading.value = false;
        errorMessage.value = _mapFailureToMessage(failure);
      },
      (recipes) {
        favorites.value = recipes;
        isLoading.value = false;
      },
    );
  }

  Future<void> removeFavorite(RecipeEntity recipe) async {
    final authController = Get.find<AuthController>();
    final user = authController.currentUser.value;
    if (user == null) return;

    final result = await _removeFavoriteUseCase(
        RemoveFavoriteParams(userId: user.id, recipeId: recipe.id));

    result.fold(
      (failure) => UIHelper.showSnackbar(
        title: 'Error',
        message: 'Failed to remove favorite',
        backgroundColor: Colors.red,
      ),
      (_) {
        favorites.remove(recipe);
        UIHelper.showSnackbar(
          title: 'Removed',
          message: 'Removed from favorites',
          backgroundColor: Colors.green,
        );
      },
    );
  }

  void refreshFavorites() {
    loadFavorites();
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return failure.message;
    return 'Unexpected error occurred';
  }
}
