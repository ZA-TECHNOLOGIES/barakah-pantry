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

/// Recipe Detail Screen
/// Display full recipe information
class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({super.key});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool _isFavorite = false;

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
          title: 'Prophetic Date Smoothie',
          description:
              'A blessed smoothie combining dates, honey, and milk - all mentioned in the Sunnah',
          slug: 'prophetic-date-smoothie',
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
              name: 'Fresh Milk',
              quantity: '2',
              unit: 'cups',
              isSunnah: true,
            ),
            RecipeIngredientEntity(
              name: 'Ice cubes',
              quantity: '4-5',
              unit: 'pieces',
              isSunnah: false,
            ),
          ],
          instructions: const [
            RecipeInstructionEntity(step: 1, description: 'Remove date pits'),
            RecipeInstructionEntity(
                step: 2, description: 'Blend all ingredients'),
          ],
          sunnahBenefits: const [
            'Dates: Prophetic tradition',
            'Honey: Healing mentions',
          ],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.share, color: Colors.white),
                ),
                onPressed: () {
                  // TODO: Share recipe
                },
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? AppColors.error : Colors.white,
                  ),
                ),
                onPressed: () {
                  setState(() => _isFavorite = !_isFavorite);
                  UIHelper.showSnackbar(
                    title: _isFavorite
                        ? 'Added to Favorites'
                        : 'Removed from Favorites',
                    message: recipe.title,
                    backgroundColor:
                        _isFavorite ? AppColors.success : AppColors.grey700,
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary,
                          AppColors.primaryLight,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.restaurant,
                        size: 100,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Rating
                  Text(
                    recipe.title,
                    style: AppTypography.h1.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      const Icon(Icons.star,
                          size: 20, color: AppColors.ratingStar),
                      SizedBox(width: 4),
                      Text(
                        (recipe.averageRating ?? 0.0).toString(),
                        style: AppTypography.body1.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '(${recipe.totalRatings ?? 0} reviews)',
                        style: AppTypography.body2.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'by ${recipe.userId ?? 'Barakah Kitchen'}',
                        style: AppTypography.body2.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.md),
                  Text(
                    recipe.description ?? '',
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: AppSpacing.xl),

                  // Quick Info Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.access_time,
                          label: 'Prep Time',
                          value: '${recipe.prepTimeMinutes} min',
                        ),
                      ),
                      SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.restaurant,
                          label: 'Servings',
                          value: recipe.servings.toString(),
                        ),
                      ),
                      SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _buildInfoCard(
                          icon: Icons.signal_cellular_alt,
                          label: 'Difficulty',
                          value: recipe.difficulty,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: AppSpacing.xl),

                  if (recipe.ingredients.isNotEmpty) ...[
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
                              )
                            else
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: AppColors.grey100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.circle_outlined,
                                  size: 16,
                                  color: AppColors.grey500,
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
                  ],

                  // Instructions Section
                  if (recipe.instructions.isNotEmpty) ...[
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
                                  '${instruction.step}',
                                  style: AppTypography.body2.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Text(
                                instruction.description,
                                style: AppTypography.body1.copyWith(
                                  color: AppColors.textPrimary,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: AppSpacing.xl),
                  ],

                  // Nutrition Facts
                  Container(
                    padding: EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nutrition Facts (per serving)',
                          style: AppTypography.h3.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: AppSpacing.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildNutritionItem(
                                'Calories',
                                (recipe.nutritionalInfo?['calories'] ?? 0)
                                    .toString()),
                            _buildNutritionItem(
                                'Protein',
                                recipe.nutritionalInfo?['protein']
                                        ?.toString() ??
                                    '0g'),
                            _buildNutritionItem(
                                'Carbs',
                                recipe.nutritionalInfo?['carbs']?.toString() ??
                                    '0g'),
                            _buildNutritionItem(
                                'Fat',
                                recipe.nutritionalInfo?['fat']?.toString() ??
                                    '0g'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppSpacing.xl),

                  // Sunnah Benefits
                  if (recipe.sunnahBenefits.isNotEmpty) ...[
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
                                      benefit.toString(),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.menu_book,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(width: AppSpacing.xs),
                                  Expanded(
                                    child: Text(
                                      recipe.hadithReference.toString(),
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
                  ],

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Mark as cooked
                        UIHelper.showSnackbar(
                          title: 'Great!',
                          message: 'Recipe marked as cooked',
                          backgroundColor: AppColors.success,
                        );
                      },
                      icon: const Icon(Icons.check_circle),
                      label: const Text('Mark as Cooked'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppTypography.body1.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
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

  Widget _buildNutritionItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.h3.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
