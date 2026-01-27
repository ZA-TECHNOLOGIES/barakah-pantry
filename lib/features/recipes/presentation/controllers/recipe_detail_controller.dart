import 'package:barakah_pantry/core/utils/helpers/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barakah_pantry/domain/entities/recipe_entity.dart';
import 'package:barakah_pantry/domain/usecases/recipe/get_recipe_detail_usecase.dart';
import 'package:barakah_pantry/domain/usecases/recipe/rate_recipe_usecase.dart';
import 'package:barakah_pantry/domain/usecases/favorite/add_favorite_usecase.dart';
import 'package:barakah_pantry/domain/usecases/favorite/remove_favorite_usecase.dart';
import 'package:barakah_pantry/domain/usecases/favorite/check_favorite_usecase.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class RecipeDetailController extends GetxController {
  final GetRecipeDetailUseCase _getRecipeDetailUseCase;
  final RateRecipeUseCase _rateRecipeUseCase;
  final AddFavoriteUseCase _addFavoriteUseCase;
  final RemoveFavoriteUseCase _removeFavoriteUseCase;
  final CheckFavoriteUseCase _checkFavoriteUseCase;

  RecipeDetailController(
    this._getRecipeDetailUseCase,
    this._rateRecipeUseCase,
    this._addFavoriteUseCase,
    this._removeFavoriteUseCase,
    this._checkFavoriteUseCase,
  );

  final isLoading = true.obs;
  final recipe = Rx<RecipeEntity?>(null);
  final isFavorite = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is RecipeEntity) {
      recipe.value = Get.arguments as RecipeEntity;
      checkIfFavorite();
      isLoading.value = false;
    } else if (Get.arguments is String) {
      loadRecipe(Get.arguments as String);
    }
  }

  Future<void> loadRecipe(String id) async {
    isLoading.value = true;
    final result = await _getRecipeDetailUseCase(GetRecipeParams(id: id));

    result.fold((failure) {
      isLoading.value = false;
      UIHelper.showSnackbar(
        title: 'Error',
        message: 'Failed to load recipe',
        backgroundColor: Colors.red,
      );
    }, (r) {
      recipe.value = r;
      checkIfFavorite();
      isLoading.value = false;
    });
  }

  Future<void> checkIfFavorite() async {
    if (recipe.value == null) return;

    final authController = Get.find<AuthController>();
    final user = authController.currentUser.value;
    if (user == null) return;

    final result = await _checkFavoriteUseCase(
        CheckFavoriteParams(userId: user.id, recipeId: recipe.value!.id));

    result.fold(
      (l) => null,
      (r) => isFavorite.value = r,
    );
  }

  Future<void> toggleFavorite() async {
    if (recipe.value == null) return;

    final authController = Get.find<AuthController>();
    final user = authController.currentUser.value;

    if (user == null) {
      UIHelper.showSnackbar(
        title: 'Login Required',
        message: 'Please login to save favorites',
        backgroundColor: Colors.orange,
      );
      return;
    }

    if (isFavorite.value) {
      final result = await _removeFavoriteUseCase(
          RemoveFavoriteParams(userId: user.id, recipeId: recipe.value!.id));
      result.fold(
          (l) => UIHelper.showSnackbar(
                title: 'Error',
                message: 'Failed to remove favorite',
                backgroundColor: Colors.red,
              ), (r) {
        isFavorite.value = false;
        UIHelper.showSnackbar(
          title: 'Removed',
          message: 'Removed from favorites',
          backgroundColor: Colors.green,
        );
      });
    } else {
      final result = await _addFavoriteUseCase(
          AddFavoriteParams(userId: user.id, recipeId: recipe.value!.id));
      result.fold(
          (l) => UIHelper.showSnackbar(
                title: 'Error',
                message: 'Failed to add favorite',
                backgroundColor: Colors.red,
              ), (r) {
        isFavorite.value = true;
        UIHelper.showSnackbar(
          title: 'Added',
          message: 'Added to favorites',
          backgroundColor: Colors.green,
        );
      });
    }
  }

  Future<void> rateRecipe(double rating) async {
    if (recipe.value == null) return;

    final authController = Get.find<AuthController>();
    final user = authController.currentUser.value;
    if (user == null) {
      UIHelper.showSnackbar(
        title: 'Login Required',
        message: 'Please login to rate recipes',
        backgroundColor: Colors.orange,
      );
      return;
    }

    final result = await _rateRecipeUseCase(RateRecipeParams(
      recipeId: recipe.value!.id,
      userId: user.id,
      rating: rating,
    ));

    result.fold(
      (l) => UIHelper.showSnackbar(
        title: 'Error',
        message: 'Failed to submit rating',
        backgroundColor: Colors.red,
      ),
      (_) => UIHelper.showSnackbar(
        title: 'Rated',
        message: 'You rated this recipe $rating stars',
        backgroundColor: Colors.green,
      ),
    );
  }

  void markAsCooked() {
    // Add to cooking history
    UIHelper.showSnackbar(
      title: 'Cooked!',
      message: 'Recipe marked as cooked',
      backgroundColor: Colors.green,
    );
  }
}
