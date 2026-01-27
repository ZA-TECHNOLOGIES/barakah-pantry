import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barakah_pantry/core/constants/route_constants.dart';
import 'package:barakah_pantry/core/theme/app_colors.dart';
import 'package:barakah_pantry/core/theme/app_spacing.dart';
import 'package:barakah_pantry/core/theme/app_typography.dart';

/// Pantry Screen
/// Display all Sunnah ingredients
class PantryScreen extends StatefulWidget {
  const PantryScreen({super.key});

  @override
  State<PantryScreen> createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Fruit',
    'Grain',
    'Oil',
    'Dairy',
    'Meat',
    'Spice',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: Get actual ingredients from controller
    final ingredients = [
      {
        'name': 'Dates (Ajwa)',
        'nameArabic': 'تمر عجوة',
        'category': 'Fruit',
        'sunnahLevel': 'Explicit',
      },
      {
        'name': 'Honey',
        'nameArabic': 'عسل',
        'category': 'Other',
        'sunnahLevel': 'Explicit',
      },
      {
        'name': 'Black Seed',
        'nameArabic': 'الحبة السوداء',
        'category': 'Spice',
        'sunnahLevel': 'Explicit',
      },
      {
        'name': 'Olive Oil',
        'nameArabic': 'زيت الزيتون',
        'category': 'Oil',
        'sunnahLevel': 'Explicit',
      },
      {
        'name': 'Barley',
        'nameArabic': 'شعير',
        'category': 'Grain',
        'sunnahLevel': 'Explicit',
      },
      {
        'name': 'Milk',
        'nameArabic': 'لبن',
        'category': 'Dairy',
        'sunnahLevel': 'Explicit',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Sunnah Pantry',
          style: AppTypography.h2.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () {
              Get.toNamed(RouteConstants.search);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 50,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: EdgeInsets.only(right: AppSpacing.sm),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() => _selectedCategory = category);
                    },
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.grey100,
                    labelStyle: AppTypography.body2.copyWith(
                      color:
                          isSelected ? Colors.white : AppColors.textSecondary,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),

          // Ingredients Grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(AppSpacing.md),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = ingredients[index];
                return _buildIngredientCard(ingredient);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientCard(Map<String, String> ingredient) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteConstants.ingredientDetail, arguments: ingredient);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.getCategoryColor(ingredient['category']!)
                    .withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.eco,
                      size: 48,
                      color: AppColors.getCategoryColor(ingredient['category']!)
                          .withOpacity(0.3),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.xs,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.sunnahGold,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.verified,
                            size: 12,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            ingredient['sunnahLevel']!,
                            style: AppTypography.caption.copyWith(
                              color: Colors.white,
                              fontSize: 10,
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

            // Content
            Padding(
              padding: EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ingredient['name']!,
                    style: AppTypography.body1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    ingredient['nameArabic']!,
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.getCategoryColor(ingredient['category']!)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      ingredient['category']!,
                      style: AppTypography.caption.copyWith(
                        color:
                            AppColors.getCategoryColor(ingredient['category']!),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
