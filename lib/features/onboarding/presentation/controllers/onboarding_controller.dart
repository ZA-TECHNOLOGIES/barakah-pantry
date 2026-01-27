import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barakah_pantry/core/constants/route_constants.dart';

// Assuming we might have use cases for updating profile preferences later
// For now, handling local state and navigating

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;

  // Selection State
  final selectedGoals = <String>[].obs;
  final selectedIngredients = <String>[].obs;
  final reminderTime = Rx<TimeOfDay>(const TimeOfDay(hour: 9, minute: 0));

  final List<String> availableGoals = [
    'Eat More Sunnah Foods',
    'Improve Overall Health',
    'Follow Prophetic Diet',
    'Learn Islamic Nutrition',
    'Cook for Family',
    'Lose Weight Naturally',
  ];

  final List<String> availableIngredients = [
    'Dates',
    'Honey',
    'Olive Oil',
    'Black Seed',
    'Barley',
    'Figs',
    'Pomegranate',
    'Milk',
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void completeOnboarding() {
    Get.offAllNamed(RouteConstants.goalsSelection);
  }

  void completeGoals() {
    // Navigate to Ingredient Selection (to be created)
    Get.toNamed(RouteConstants.ingredientSelection);
  }

  void completeIngredients() {
    // Navigate to Main (Home)
    Get.offAllNamed(RouteConstants.main);
  }

  void toggleGoal(String goal) {
    if (selectedGoals.contains(goal)) {
      selectedGoals.remove(goal);
    } else {
      selectedGoals.add(goal);
    }
  }

  void toggleIngredient(String ingredient) {
    if (selectedIngredients.contains(ingredient)) {
      selectedIngredients.remove(ingredient);
    } else {
      selectedIngredients.add(ingredient);
    }
  }

  void updateReminderTime(TimeOfDay time) {
    reminderTime.value = time;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
