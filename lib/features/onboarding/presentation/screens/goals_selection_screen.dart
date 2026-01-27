import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barakah_pantry/core/theme/app_colors.dart';
import 'package:barakah_pantry/core/theme/app_spacing.dart';
import 'package:barakah_pantry/core/theme/app_typography.dart';
import '../controllers/onboarding_controller.dart';

class GoalsSelectionScreen extends GetView<OnboardingController> {
  const GoalsSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<OnboardingController>()) {
      Get.put(OnboardingController());
    }

    final List<Map<String, dynamic>> goalsUiData = [
      {
        'title': 'Eat More Sunnah Foods',
        'icon': Icons.eco,
        'description': 'Incorporate blessed ingredients into my diet',
      },
      {
        'title': 'Improve Overall Health',
        'icon': Icons.favorite,
        'description': 'Follow prophetic nutrition for wellness',
      },
      {
        'title': 'Follow Prophetic Diet',
        'icon': Icons.menu_book,
        'description': 'Understand the wisdom behind Sunnah foods',
      },
      {
        'title': 'Cook for Family',
        'icon': Icons.people,
        'description': 'Prepare blessed meals for loved ones',
      },
      {
        'title': 'Lose Weight Naturally',
        'icon': Icons.monitor_weight,
        'description': 'Healthy eating habits',
      },
      {
        'title': 'Learn Islamic Nutrition',
        'icon': Icons.school,
        'description': 'Educational journey',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What are your goals?',
                      style: AppTypography.h1.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: AppSpacing.sm),
                    Text(
                      'Select all that apply to personalize your experience',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: AppSpacing.xl),
                    ...goalsUiData.map((goal) => _buildGoalCard(goal)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: SizedBox(
                width: double.infinity,
                child: Obx(() {
                  final isEnabled = controller.selectedGoals.isNotEmpty;
                  return ElevatedButton(
                    onPressed: isEnabled ? controller.completeGoals : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isEnabled ? AppColors.primary : AppColors.grey300,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: AppTypography.button.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(Map<String, dynamic> goal) {
    return Obx(() {
      final isSelected = controller.selectedGoals.contains(goal['title']);

      return GestureDetector(
        onTap: () => controller.toggleGoal(goal['title']),
        child: Container(
          margin: EdgeInsets.only(bottom: AppSpacing.md),
          padding: EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.grey100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  goal['icon'],
                  color:
                      isSelected ? AppColors.primary : AppColors.textSecondary,
                  size: 28,
                ),
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal['title'],
                      style: AppTypography.body1.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      goal['description'],
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(
                  Icons.check_circle,
                  color: AppColors.primary,
                  size: 24,
                ),
            ],
          ),
        ),
      );
    });
  }
}
