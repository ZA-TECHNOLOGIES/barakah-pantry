import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barakah_pantry/core/theme/app_colors.dart';
import 'package:barakah_pantry/core/theme/app_spacing.dart';
import 'package:barakah_pantry/core/theme/app_typography.dart';
import 'package:barakah_pantry/core/utils/helpers/ui_helper.dart';
import 'package:barakah_pantry/domain/entities/recipe_entity.dart';
import 'package:barakah_pantry/domain/entities/recipe_ingredient_entity.dart';
import 'package:barakah_pantry/domain/entities/recipe_instruction_entity.dart';
import 'package:barakah_pantry/data/models/recipe_model.dart';

/// AI Recipe Result Screen
/// Display the generated recipe from AI
class AIRecipeResultScreen extends StatelessWidget {
  const AIRecipeResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    RecipeEntity? recipeArg;

    if (args is RecipeEntity) {
      recipeArg = args;
    } else if (args is Map) {
      try {
        recipeArg = RecipeModel.fromJson(Map<String, dynamic>.from(args));
      } catch (e) {
        debugPrint('Error parsing recipe arguments: $e');
      }
    }

    final RecipeEntity recipe = recipeArg ??
        RecipeEntity(
          id: 'default',
          title: 'Prophetic Date & Honey Smoothie',
          description: 'A blessed smoothie combining dates and honey',
          slug: 'prophetic-date-honey-smoothie',
          prepTimeMinutes: 5,
          cookTimeMinutes: 0,
          servings: 2,
          difficulty: 'Easy',
          category: 'Breakfast',
          ingredients: const [
            RecipeIngredientEntity(
              name: 'Ajwa Dates',
              quantity: '7',
              unit: 'pieces',
              isSunnah: true,
            ),
            RecipeIngredientEntity(
              name: 'Raw Honey',
              quantity: '2',
              unit: 'tbsp',
              isSunnah: true,
            ),
            RecipeIngredientEntity(
              name: 'Milk',
              quantity: '2',
              unit: 'cups',
              isSunnah: true,
            ),
          ],
          instructions: const [
            RecipeInstructionEntity(
                step: 1, description: 'Remove pits from dates'),
            RecipeInstructionEntity(
              step: 2,
              description: 'Add all ingredients to blender',
            ),
            RecipeInstructionEntity(step: 3, description: 'Blend until smooth'),
          ],
          sunnahBenefits: const [
            'Dates provide natural energy and are blessed by the Prophet ﷺ',
            'Honey contains healing properties mentioned in the Quran',
            'Milk was loved by the Prophet ﷺ',
          ],
          hadithReference:
              'The Prophet ﷺ said: "Whoever eats seven Ajwa dates..." (Bukhari 5445)',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Generated Recipe',
          style: AppTypography.h3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: AppColors.textPrimary),
            onPressed: () {
              // TODO: Share recipe
            },
          ),
          IconButton(
            icon:
                const Icon(Icons.favorite_border, color: AppColors.textPrimary),
            onPressed: () {
              // TODO: Save to favorites
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.honeyGold,
                    AppColors.honeyLight,
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.auto_awesome,
                      size: 80,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.auto_awesome,
                            size: 16,
                            color: AppColors.honeyGold,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'AI Generated',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.honeyGold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    recipe.title,
                    style: AppTypography.h1.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    recipe.description ?? '',
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg),

                  // Quick Info
                  Row(
                    children: [
                      _buildInfoChip(
                        icon: Icons.access_time,
                        label: '${recipe.prepTimeMinutes} min',
                      ),
                      SizedBox(width: AppSpacing.sm),
                      _buildInfoChip(
                        icon: Icons.restaurant,
                        label: '${recipe.servings} servings',
                      ),
                      SizedBox(width: AppSpacing.sm),
                      _buildInfoChip(
                        icon: Icons.signal_cellular_alt,
                        label: recipe.difficulty,
                      ),
                    ],
                  ),

                  SizedBox(height: AppSpacing.xl),

                  // Ingredients
                  Text(
                    'Ingredients',
                    style: AppTypography.h2.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.md),
                  ...recipe.ingredients.map((ingredient) {
                    return Container(
                      margin: EdgeInsets.only(bottom: AppSpacing.sm),
                      padding: EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          if (ingredient.isSunnah)
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppColors.sunnahGold.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.verified,
                                size: 16,
                                color: AppColors.sunnahGold,
                              ),
                            ),
                          SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              ingredient.name,
                              style: AppTypography.body1.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Text(
                            '${ingredient.quantity} ${ingredient.unit}',
                            style: AppTypography.body2.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  SizedBox(height: AppSpacing.xl),

                  // Instructions
                  Text(
                    'Instructions',
                    style: AppTypography.h2.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.md),
                  ...recipe.instructions.map((instruction) {
                    return Container(
                      margin: EdgeInsets.only(bottom: AppSpacing.md),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                instruction.step.toString(),
                                style: AppTypography.body2.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  instruction.description,
                                  style: AppTypography.body1.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                if (instruction.durationMinutes != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      '${instruction.durationMinutes} min',
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.textTertiary,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  SizedBox(height: AppSpacing.xl),

                  // Sunnah Benefits
                  Container(
                    padding: EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withOpacity(0.1),
                          AppColors.primaryLight.withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.eco,
                              color: AppColors.primary,
                              size: 24,
                            ),
                            SizedBox(width: AppSpacing.sm),
                            Text(
                              'Sunnah Benefits',
                              style: AppTypography.h3.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSpacing.md),
                        ...recipe.sunnahBenefits.map((benefit) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: AppSpacing.sm),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: AppSpacing.sm),
                                Expanded(
                                  child: Text(
                                    benefit,
                                    style: AppTypography.body2.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        if (recipe.hadithReference != null) ...[
                          SizedBox(height: AppSpacing.sm),
                          Container(
                            padding: EdgeInsets.all(AppSpacing.sm),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.menu_book,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: AppSpacing.xs),
                                Expanded(
                                  child: Text(
                                    recipe.hadithReference!,
                                    style: AppTypography.caption.copyWith(
                                      color: AppColors.primary,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: AppSpacing.xl),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Save recipe
                            UIHelper.showSnackbar(
                              title: 'Success',
                              message: 'Recipe saved to favorites!',
                              backgroundColor: AppColors.success,
                            );
                          },
                          icon: const Icon(Icons.favorite),
                          label: const Text('Save Recipe'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding:
                                EdgeInsets.symmetric(vertical: AppSpacing.md),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // TODO: Regenerate recipe
                            Get.back();
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Regenerate'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            padding:
                                EdgeInsets.symmetric(vertical: AppSpacing.md),
                            side: const BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          SizedBox(width: 4),
          Text(
            label,
            style: AppTypography.caption.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
