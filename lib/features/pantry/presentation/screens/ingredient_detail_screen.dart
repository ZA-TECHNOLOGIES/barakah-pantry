import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barakah_pantry/core/theme/app_colors.dart';
import 'package:barakah_pantry/core/theme/app_spacing.dart';
import 'package:barakah_pantry/core/theme/app_typography.dart';

/// Ingredient Detail Screen
/// Display detailed information about a Sunnah ingredient
class IngredientDetailScreen extends StatelessWidget {
  const IngredientDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Get actual ingredient from arguments or controller
    final ingredient = Get.arguments ??
        {
          'name': 'Honey',
          'nameArabic': 'عسل',
          'slug': 'honey',
          'description':
              'Pure, raw honey is one of the most blessed foods mentioned in the Quran. It is described as containing healing for mankind and was highly recommended by the Prophet Muhammad ﷺ.',
          'category': 'Other',
          'sunnahLevel': 'Explicit',
          'benefits': [
            'Natural antibacterial and antifungal properties',
            'Soothes sore throats and coughs',
            'Boosts immune system',
            'Aids in digestion',
            'Provides natural energy',
            'Promotes wound healing',
          ],
          'usageTips': [
            'Take a spoonful on an empty stomach in the morning',
            'Mix with warm water and lemon for a healing drink',
            'Use as a natural sweetener in recipes',
            'Apply topically for wound healing',
            'Combine with black seed for enhanced benefits',
          ],
          'quranReferences': [
            {
              'surah': 'An-Nahl',
              'surahNumber': 16,
              'ayah': 69,
              'text':
                  'There emerges from their bellies a drink, varying in colors, in which there is healing for people.',
              'context': 'Allah describes honey as containing healing',
            },
          ],
          'hadithReferences': [
            {
              'source': 'Sahih al-Bukhari 5684',
              'text':
                  'The Prophet ﷺ said: "Honey is a remedy for every illness and the Quran is a remedy for all illness of the mind."',
            },
            {
              'source': 'Sahih Muslim 2217',
              'text':
                  'A man came to the Prophet ﷺ and said, "My brother has some abdominal trouble." The Prophet ﷺ said to him "Let him drink honey."',
            },
          ],
          'nutritionalInfo': {
            'calories': '64 per tbsp',
            'carbs': '17g',
            'sugars': '17g',
            'vitamins': 'B vitamins, Vitamin C',
            'minerals': 'Iron, Zinc, Potassium',
          },
        };

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor:
                AppColors.getCategoryColor(ingredient['category'] ?? 'Other'),
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
                  // TODO: Share ingredient
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
                          AppColors.getCategoryColor(
                              ingredient['category'] ?? 'Other'),
                          AppColors.getCategoryColor(
                                  ingredient['category'] ?? 'Other')
                              .withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.eco,
                        size: 120,
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
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.sunnahGold,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.verified,
                            size: 16,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            ingredient['sunnahLevel'] ?? 'Sunnah',
                            style: AppTypography.caption.copyWith(
                              color: Colors.white,
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
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    ingredient['name'] ?? 'Ingredient',
                    style: AppTypography.h1.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: AppSpacing.xs),
                  Text(
                    ingredient['nameArabic'] ?? '',
                    style: AppTypography.h2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),

                  SizedBox(height: AppSpacing.md),

                  // Category Badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.getCategoryColor(
                              ingredient['category'] ?? 'Other')
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      ingredient['category'] ?? 'Other',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.getCategoryColor(
                            ingredient['category'] ?? 'Other'),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: AppSpacing.lg),

                  // Description
                  Text(
                    ingredient['description'] ?? '',
                    style: AppTypography.body1.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),

                  SizedBox(height: AppSpacing.xl),

                  // Quran References
                  if (ingredient['quranReferences'] != null) ...[
                    _buildSectionHeader('Quranic References', Icons.menu_book),
                    SizedBox(height: AppSpacing.md),
                    ...(ingredient['quranReferences'] as List).map((ref) {
                      return Container(
                        margin: EdgeInsets.only(bottom: AppSpacing.md),
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
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSpacing.sm,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Surah ${ref['surah']} (${ref['surahNumber']}:${ref['ayah']})',
                                    style: AppTypography.caption.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppSpacing.sm),
                            Text(
                              ref['text']!,
                              style: AppTypography.body1.copyWith(
                                color: AppColors.textPrimary,
                                fontStyle: FontStyle.italic,
                                height: 1.6,
                              ),
                            ),
                            if (ref['context'] != null) ...[
                              SizedBox(height: AppSpacing.sm),
                              Text(
                                ref['context']!,
                                style: AppTypography.body2.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: AppSpacing.xl),
                  ],

                  // Hadith References
                  if (ingredient['hadithReferences'] != null) ...[
                    _buildSectionHeader(
                        'Hadith References', Icons.auto_stories),
                    SizedBox(height: AppSpacing.md),
                    ...(ingredient['hadithReferences'] as List).map((ref) {
                      return Container(
                        margin: EdgeInsets.only(bottom: AppSpacing.md),
                        padding: EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.secondary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                ref['source'] ?? 'Source',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: AppSpacing.sm),
                            Text(
                              ref['text'] ?? '',
                              style: AppTypography.body1.copyWith(
                                color: AppColors.textPrimary,
                                fontStyle: FontStyle.italic,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: AppSpacing.xl),
                  ],

                  // Health Benefits
                  if (ingredient['benefits'] != null &&
                      (ingredient['benefits'] as List).isNotEmpty) ...[
                    _buildSectionHeader('Health Benefits', Icons.favorite),
                    SizedBox(height: AppSpacing.md),
                    Container(
                      padding: EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        children:
                            (ingredient['benefits'] as List).map((benefit) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: AppSpacing.sm),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  size: 20,
                                  color: AppColors.success,
                                ),
                                SizedBox(width: AppSpacing.sm),
                                Expanded(
                                  child: Text(
                                    benefit.toString(),
                                    style: AppTypography.body2.copyWith(
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: AppSpacing.xl),
                  ],

                  // Usage Tips
                  if (ingredient['usageTips'] != null &&
                      (ingredient['usageTips'] as List).isNotEmpty) ...[
                    _buildSectionHeader('Usage Tips', Icons.lightbulb_outline),
                    SizedBox(height: AppSpacing.md),
                    ...(ingredient['usageTips'] as List)
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final tip = entry.value;
                      return Container(
                        margin: EdgeInsets.only(bottom: AppSpacing.sm),
                        padding: EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: AppColors.honeyLight.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.honeyGold.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColors.honeyGold,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: AppTypography.caption.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                tip.toString(),
                                style: AppTypography.body2.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    SizedBox(height: AppSpacing.xl),
                  ],

                  // Nutritional Information
                  if (ingredient['nutritionalInfo'] != null) ...[
                    _buildSectionHeader(
                        'Nutritional Information', Icons.analytics_outlined),
                    SizedBox(height: AppSpacing.md),
                    Container(
                      padding: EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        children: [
                          if (ingredient['nutritionalInfo']['calories'] != null)
                            _buildNutritionRow('Calories',
                                ingredient['nutritionalInfo']['calories']!),
                          if (ingredient['nutritionalInfo']['carbs'] != null)
                            _buildNutritionRow('Carbohydrates',
                                ingredient['nutritionalInfo']['carbs']!),
                          if (ingredient['nutritionalInfo']['sugars'] != null)
                            _buildNutritionRow('Sugars',
                                ingredient['nutritionalInfo']['sugars']!),
                          if (ingredient['nutritionalInfo']['vitamins'] != null)
                            _buildNutritionRow('Vitamins',
                                ingredient['nutritionalInfo']['vitamins']!),
                          if (ingredient['nutritionalInfo']['minerals'] != null)
                            _buildNutritionRow('Minerals',
                                ingredient['nutritionalInfo']['minerals']!,
                                isLast: true),
                        ],
                      ),
                    ),
                    SizedBox(height: AppSpacing.xxl),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        SizedBox(width: AppSpacing.sm),
        Text(
          title,
          style: AppTypography.h2.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionRow(String label, String value, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTypography.body1.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                value,
                style: AppTypography.body1.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 1),
      ],
    );
  }
}
