import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barakah_pantry/core/constants/route_constants.dart';
import 'package:barakah_pantry/core/theme/app_colors.dart';
import 'package:barakah_pantry/core/theme/app_spacing.dart';
import 'package:barakah_pantry/core/theme/app_typography.dart';
import 'package:barakah_pantry/core/utils/helpers/ui_helper.dart';

/// AI Recipe Screen
/// Input screen for generating AI recipes
class AIRecipeScreen extends StatefulWidget {
  const AIRecipeScreen({super.key});

  @override
  State<AIRecipeScreen> createState() => _AIRecipeScreenState();
}

class _AIRecipeScreenState extends State<AIRecipeScreen> {
  final List<String> _selectedIngredients = [];
  String? _selectedMealType;
  int _servings = 2;
  bool _isGenerating = false;

  final List<String> _availableIngredients = [
    'Dates',
    'Honey',
    'Black Seed',
    'Olive Oil',
    'Barley',
    'Milk',
    'Vinegar',
    'Watermelon',
    'Pumpkin',
    'Lamb',
    'Figs',
    'Olives',
    'Grapes',
    'Pomegranate',
    'Cucumber',
  ];

  final List<String> _mealTypes = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
    'Drink',
    'Dessert',
  ];

  Future<void> _generateRecipe() async {
    if (_selectedIngredients.isEmpty) {
      UIHelper.showSnackbar(
        title: 'Ingredients Required',
        message: 'Please select at least one ingredient',
        backgroundColor: AppColors.warning,
      );
      return;
    }

    setState(() => _isGenerating = true);

    // TODO: Call AI generation use case
    await Future.delayed(const Duration(seconds: 3));

    setState(() => _isGenerating = false);

    // Navigate to result screen
    Get.toNamed(RouteConstants.aiRecipeResult, arguments: {
      'ingredients': _selectedIngredients,
      'mealType': _selectedMealType,
      'servings': _servings,
    });
  }

  @override
  Widget build(BuildContext context) {
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
          'Generate Sunnah Recipe',
          style: AppTypography.h3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.honeyGold.withOpacity(0.2),
                    AppColors.honeyLight.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.honeyGold,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      'Let AI create a blessed recipe using Sunnah ingredients',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppSpacing.xl),

            // Select Ingredients
            Text(
              'Select Ingredients',
              style: AppTypography.h3.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableIngredients.map((ingredient) {
                final isSelected = _selectedIngredients.contains(ingredient);
                return FilterChip(
                  label: Text(ingredient),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedIngredients.add(ingredient);
                      } else {
                        _selectedIngredients.remove(ingredient);
                      }
                    });
                  },
                  selectedColor: AppColors.primary,
                  backgroundColor: AppColors.grey100,
                  labelStyle: AppTypography.body2.copyWith(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                  checkmarkColor: Colors.white,
                );
              }).toList(),
            ),

            SizedBox(height: AppSpacing.xl),

            // Meal Type
            Text(
              'Meal Type (Optional)',
              style: AppTypography.h3.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _mealTypes.map((type) {
                final isSelected = _selectedMealType == type;
                return ChoiceChip(
                  label: Text(type),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedMealType = selected ? type : null;
                    });
                  },
                  selectedColor: AppColors.secondary,
                  backgroundColor: AppColors.grey100,
                  labelStyle: AppTypography.body2.copyWith(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: AppSpacing.xl),

            // Servings
            Text(
              'Number of Servings',
              style: AppTypography.h3.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                IconButton(
                  onPressed:
                      _servings > 1 ? () => setState(() => _servings--) : null,
                  icon: const Icon(Icons.remove_circle_outline),
                  color: AppColors.primary,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _servings.toString(),
                    style: AppTypography.h2.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed:
                      _servings < 10 ? () => setState(() => _servings++) : null,
                  icon: const Icon(Icons.add_circle_outline),
                  color: AppColors.primary,
                ),
              ],
            ),

            SizedBox(height: AppSpacing.xxl),

            // Generate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isGenerating ? null : _generateRecipe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.honeyGold,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isGenerating
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.auto_awesome, size: 24),
                          SizedBox(width: AppSpacing.sm),
                          Text(
                            'Generate Recipe',
                            style: AppTypography.button.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
