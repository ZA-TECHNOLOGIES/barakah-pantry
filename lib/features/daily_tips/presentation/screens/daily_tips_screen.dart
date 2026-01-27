import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barakah_pantry/core/theme/app_colors.dart';
import 'package:barakah_pantry/core/theme/app_spacing.dart';
import 'package:barakah_pantry/core/theme/app_typography.dart';

/// Daily Tips Screen
/// Display daily Barakah tips and archive
class DailyTipsScreen extends StatelessWidget {
  const DailyTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Get actual tips from controller
    final tips = [
      {
        'title': 'The Blessing of Dates',
        'content':
            'The Prophet ﷺ said: "A house without dates is like a house without food." Start your day with the Sunnah by keeping dates in your home.',
        'reference': 'Sahih Muslim',
        'date': 'Today',
      },
      {
        'title': 'Honey: Nature\'s Healer',
        'content':
            'Allah mentions honey as a healing in the Quran. Consider replacing processed sugar with pure honey in your daily diet.',
        'reference': 'Surah An-Nahl 16:69',
        'date': 'Yesterday',
      },
      {
        'title': 'Black Seed: The Blessed Cure',
        'content':
            'The Prophet ﷺ said black seed cures everything except death. Add a teaspoon of black seed oil to your morning routine.',
        'reference': 'Sahih al-Bukhari 5688',
        'date': '2 days ago',
      },
    ];

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
          'Daily Barakah Tips',
          style: AppTypography.h2.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(AppSpacing.md),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          final tip = tips[index];
          final isToday = index == 0;
          return _buildTipCard(tip, isToday);
        },
      ),
    );
  }

  Widget _buildTipCard(Map<String, String> tip, bool isToday) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.md),
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: isToday
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.secondary.withOpacity(0.2),
                  AppColors.secondaryLight.withOpacity(0.1),
                ],
              )
            : null,
        color: isToday ? null : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isToday
            ? Border.all(
                color: AppColors.secondary.withOpacity(0.3),
                width: 2,
              )
            : null,
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
          Row(
            children: [
              if (isToday)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        size: 14,
                        color: Colors.white,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Today\'s Tip',
                        style: AppTypography.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              if (!isToday)
                Text(
                  tip['date']!,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  // TODO: Share tip
                },
                icon: const Icon(
                  Icons.share,
                  size: 20,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            tip['title']!,
            style: AppTypography.h3.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            tip['content']!,
            style: AppTypography.body2.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Icon(
                Icons.menu_book,
                size: 16,
                color: AppColors.primary,
              ),
              SizedBox(width: AppSpacing.xs),
              Text(
                tip['reference']!,
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
