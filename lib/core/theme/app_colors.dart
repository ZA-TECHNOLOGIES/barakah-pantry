import 'package:flutter/material.dart';

/// App Colors
/// Contains all color definitions used throughout the application
class AppColors {
  AppColors._();

  //═══════════════════════════════════════════════════════════════
  // PRIMARY COLORS - Islamic Green Theme
  //═══════════════════════════════════════════════════════════════

  static const Color primary = Color(0xFF0D4A2D);
  static const Color primaryLight = Color(0xFF2D7A4F);
  static const Color primaryMedium = Color(0xFF1B5E3F);
  static const Color primaryDark = Color(0xFF083D22);
  static const Color primarySoft = Color(0xFF4CAF50);
  static const Color primarySurface = Color(0xFFE8F5E9);
  static const Color primaryContainer = Color(0xFFC8E6C9);

  //═══════════════════════════════════════════════════════════════
  // SECONDARY COLORS - Honey Gold Theme
  //═══════════════════════════════════════════════════════════════

  static const Color secondary = Color(0xFFD4A574);
  static const Color secondaryLight = Color(0xFFE8C49A);
  static const Color secondaryDark = Color(0xFFB8864E);
  static const Color secondarySurface = Color(0xFFFFF8E1);
  static const Color secondaryContainer = Color(0xFFFFECB3);
  static const Color honeyGold = Color(0xFFFFB300);
  static const Color honeyLight = Color(0xFFFFD54F);

  //═══════════════════════════════════════════════════════════════
  // ACCENT COLORS - Date Brown Theme
  //═══════════════════════════════════════════════════════════════

  static const Color accent = Color(0xFF8B5A2B);
  static const Color accentLight = Color(0xFFA67B4C);
  static const Color accentDark = Color(0xFF5D3A1A);
  static const Color dateBrown = Color(0xFF5D3A1A);
  static const Color dateSurface = Color(0xFFFBE9E7);

  //═══════════════════════════════════════════════════════════════
  // OLIVE COLORS - Olive Theme
  //═══════════════════════════════════════════════════════════════

  static const Color olive = Color(0xFF4A7C59);
  static const Color oliveLight = Color(0xFF6B9B7A);
  static const Color oliveDark = Color(0xFF2D5A3D);
  static const Color oliveSurface = Color(0xFFE8F5E9);

  //═══════════════════════════════════════════════════════════════
  // NEUTRAL COLORS
  //═══════════════════════════════════════════════════════════════

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Colors.transparent;

  // Grey Scale
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  //═══════════════════════════════════════════════════════════════
  // BACKGROUND COLORS
  //═══════════════════════════════════════════════════════════════

  static const Color background = Color(0xFFF8F9FA);
  static const Color backgroundWarm = Color(0xFFFAF8F5);
  static const Color backgroundCool = Color(0xFFF5F7FA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color backgroundDarkElevated = Color(0xFF1E1E1E);

  //═══════════════════════════════════════════════════════════════
  // SURFACE COLORS
  //═══════════════════════════════════════════════════════════════

  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF5F2ED);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color surfaceDarkVariant = Color(0xFF2C2C2C);
  static const Color cardBackground = Color(0xFFFFFDF4);
  static const Color cardBackgroundDark = Color(0xFF2C2C2C);

  //═══════════════════════════════════════════════════════════════
  // TEXT COLORS
  //═══════════════════════════════════════════════════════════════

  static const Color textPrimary = Color(0xFF2C2C2C);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textTertiary = Color(0xFF9B9B9B);
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFF000000);
  static const Color textOnDark = Color(0xFFFFFFFF);
  static const Color textOnDarkSecondary = Color(0xFFB0B0B0);

  //═══════════════════════════════════════════════════════════════
  // BORDER COLORS
  //═══════════════════════════════════════════════════════════════

  static const Color border = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFF0F0F0);
  static const Color borderDark = Color(0xFFBDBDBD);
  static const Color borderFocused = primary;
  static const Color divider = Color(0xFFEEEEEE);
  static const Color dividerDark = Color(0xFF424242);

  //═══════════════════════════════════════════════════════════════
  // STATUS COLORS
  //═══════════════════════════════════════════════════════════════

  // Success
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFFE8F5E9);
  static const Color successDark = Color(0xFF388E3C);

  // Error
  static const Color error = Color(0xFFE53935);
  static const Color errorLight = Color(0xFFFFEBEE);
  static const Color errorDark = Color(0xFFC62828);

  // Warning
  static const Color warning = Color(0xFFFFA726);
  static const Color warningLight = Color(0xFFFFF3E0);
  static const Color warningDark = Color(0xFFF57C00);

  // Info
  static const Color info = Color(0xFF29B6F6);
  static const Color infoLight = Color(0xFFE1F5FE);
  static const Color infoDark = Color(0xFF0288D1);

  //═══════════════════════════════════════════════════════════════
  // SUNNAH BADGE COLORS
  //═══════════════════════════════════════════════════════════════

  static const Color sunnahExplicit = Color(0xFF4A7C59);
  static const Color sunnahImplied = Color(0xFF7CB69B);
  static const Color halalGeneral = Color(0xFFB0D4C1);
  static const Color sunnahGold = Color(0xFFFFB300);

  //═══════════════════════════════════════════════════════════════
  // CATEGORY COLORS
  //═══════════════════════════════════════════════════════════════

  static const Color categoryFruit = Color(0xFFE57373);
  static const Color categoryGrain = Color(0xFFFFB74D);
  static const Color categoryOil = Color(0xFFFFD54F);
  static const Color categoryDairy = Color(0xFF81D4FA);
  static const Color categoryMeat = Color(0xFFE57373);
  static const Color categorySpice = Color(0xFFBA68C8);
  static const Color categoryOther = Color(0xFF90A4AE);

  //═══════════════════════════════════════════════════════════════
  // SHIMMER COLORS
  //═══════════════════════════════════════════════════════════════

  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
  static const Color shimmerBaseDark = Color(0xFF424242);
  static const Color shimmerHighlightDark = Color(0xFF616161);

  //═══════════════════════════════════════════════════════════════
  // SHADOW COLORS
  //═══════════════════════════════════════════════════════════════

  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0D000000);
  static const Color shadowMedium = Color(0x26000000);
  static const Color shadowDark = Color(0x33000000);
  static const Color shadowPrimary = Color(0x330D4A2D);

  //═══════════════════════════════════════════════════════════════
  // OVERLAY COLORS
  //═══════════════════════════════════════════════════════════════

  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);
  static const Color overlayDark = Color(0xBF000000);
  static const Color scrim = Color(0x52000000);

  //═══════════════════════════════════════════════════════════════
  // RATING COLORS
  //═══════════════════════════════════════════════════════════════

  static const Color ratingStar = Color(0xFFFFB300);
  static const Color ratingStarEmpty = Color(0xFFE0E0E0);

  //═══════════════════════════════════════════════════════════════
  // SOCIAL COLORS
  //═══════════════════════════════════════════════════════════════

  static const Color google = Color(0xFFDB4437);
  static const Color facebook = Color(0xFF4267B2);
  static const Color apple = Color(0xFF000000);
  static const Color twitter = Color(0xFF1DA1F2);

  //═══════════════════════════════════════════════════════════════
  // HELPER METHODS
  //═══════════════════════════════════════════════════════════════

  /// Get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  /// Get category color by name
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'fruit':
        return categoryFruit;
      case 'grain':
        return categoryGrain;
      case 'oil':
        return categoryOil;
      case 'dairy':
        return categoryDairy;
      case 'meat':
        return categoryMeat;
      case 'spice':
        return categorySpice;
      default:
        return categoryOther;
    }
  }

  /// Get Sunnah level color
  static Color getSunnahColor(String level) {
    switch (level.toLowerCase()) {
      case 'explicit':
        return sunnahExplicit;
      case 'implied':
        return sunnahImplied;
      default:
        return halalGeneral;
    }
  }
}
