import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barakah_pantry/core/constants/route_constants.dart';
import 'package:barakah_pantry/core/theme/app_colors.dart';
import 'package:barakah_pantry/core/theme/app_spacing.dart';
import 'package:barakah_pantry/core/theme/app_typography.dart';
import '../controllers/home_controller.dart';
import '../widgets/daily_tip_card.dart';
import '../widgets/featured_ingredient_card.dart';
import '../widgets/ai_recipe_button.dart';
import '../widgets/recipe_carousel.dart';
import '../widgets/home_app_bar.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => await controller.refreshData(),
          color: AppColors.primary,
          child: CustomScrollView(
            slivers: [
              // Custom App Bar
              const SliverToBoxAdapter(
                child: HomeAppBar(),
              ),

              // Content wrapped in Obx for reactivity
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (controller.errorMessage.value != null) {
                      return Center(
                        child: Text(controller.errorMessage.value!),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. Daily Barakah Tip
                        Text(
                          'Daily Barakah',
                          style: AppTypography.h2.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: AppSpacing.sm),
                        DailyTipCard(
                          tip: controller.dailyTip.value,
                        ),

                        SizedBox(height: AppSpacing.xl),

                        // 2. Featured Ingredient
                        if (controller.featuredIngredient.value != null) ...[
                          Text(
                            'Featured Sunnah Ingredient',
                            style: AppTypography.h2.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: AppSpacing.sm),
                          FeaturedIngredientCard(
                            ingredient: controller.featuredIngredient.value!,
                            onTap: () => controller.navigateToIngredient(
                              controller.featuredIngredient.value!,
                            ),
                          ),
                          SizedBox(height: AppSpacing.xl),
                        ],

                        // 3. AI Recipe Button
                        AIRecipeButton(),

                        SizedBox(height: AppSpacing.xl),

                        // 4. Trending Recipes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Trending Recipes',
                              style: AppTypography.h2.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed(RouteConstants.recipes);
                              },
                              child: Text(
                                'See All',
                                style: AppTypography.body2.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSpacing.sm),
                        RecipeCarousel(
                          recipes: controller.trendingRecipes,
                          onRecipeTap: controller.navigateToRecipe,
                        ),

                        SizedBox(height: AppSpacing.xl),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
