import 'package:barakah_pantry/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barakah_pantry/core/constants/route_constants.dart';
import 'package:barakah_pantry/core/theme/app_colors.dart';
import 'package:barakah_pantry/core/theme/app_spacing.dart';
import 'package:barakah_pantry/core/theme/app_typography.dart';

/// Onboarding Screen
/// Introduction to the app
class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is loaded if not already
    // Ideally this is done in binding, but safeguards here
    if (!Get.isRegistered<OnboardingController>()) {
      Get.put(OnboardingController());
    }

    final List<Map<String, String>> pages = [
      {
        'title': 'Welcome to Barakah Pantry',
        'description':
            'Discover the blessed foods mentioned in the Quran and Sunnah',
        'icon': 'eco',
      },
      {
        'title': 'AI-Powered Recipes',
        'description':
            'Generate delicious recipes using Sunnah ingredients with AI',
        'icon': 'auto_awesome',
      },
      {
        'title': 'Learn & Grow',
        'description':
            'Daily tips and insights about prophetic nutrition and wellness',
        'icon': 'menu_book',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => Get.toNamed(RouteConstants.goalsSelection),
                child: Text(
                  'Skip',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),

            // Pages
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(pages[index]);
                },
              ),
            ),

            // Indicators
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: controller.currentPage.value == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: controller.currentPage.value == index
                            ? AppColors.primary
                            : AppColors.grey300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                )),

            SizedBox(height: AppSpacing.xl),

            // Next Button
            Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: SizedBox(
                width: double.infinity,
                child: Obx(() => ElevatedButton(
                      onPressed: controller.nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        controller.currentPage.value == pages.length - 1
                            ? 'Get Started'
                            : 'Next',
                        style: AppTypography.button.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(Map<String, String> page) {
    IconData icon;
    switch (page['icon']) {
      case 'auto_awesome':
        icon = Icons.auto_awesome;
        break;
      case 'menu_book':
        icon = Icons.menu_book;
        break;
      default:
        icon = Icons.eco;
    }

    return Padding(
      padding: EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 80,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: AppSpacing.xxl),
          Text(
            page['title']!,
            style: AppTypography.h1.copyWith(
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            page['description']!,
            style: AppTypography.body1.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
