import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Application Gradients
/// Defines all gradient styles used throughout the application
class AppGradients {
  AppGradients._();

  //═══════════════════════════════════════════════════════════════
  // PRIMARY GRADIENTS
  //═══════════════════════════════════════════════════════════════

  /// Primary vertical gradient (top to bottom)
  static const LinearGradient primaryVertical = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.primary,
      AppColors.primaryMedium,
      AppColors.primaryLight,
    ],
  );

  /// Primary horizontal gradient (left to right)
  static const LinearGradient primaryHorizontal = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.primary,
      AppColors.primaryLight,
    ],
  );

  /// Primary diagonal gradient
  static const LinearGradient primaryDiagonal = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primary,
      AppColors.primaryLight,
    ],
  );

  /// Primary soft gradient
  static const LinearGradient primarySoft = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primarySurface,
      Color(0xFFE8F5E8),
    ],
  );

  //═══════════════════════════════════════════════════════════════
  // SECONDARY GRADIENTS (Honey)
  //═══════════════════════════════════════════════════════════════

  /// Honey gradient
  static const LinearGradient honey = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFF8E1),
      Color(0xFFFFECB3),
    ],
  );

  /// Gold gradient
  static const LinearGradient gold = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      AppColors.honeyGold,
      AppColors.secondaryDark,
    ],
  );

  //═══════════════════════════════════════════════════════════════
  // OLIVE GRADIENTS
  //═══════════════════════════════════════════════════════════════

  /// Olive gradient
  static const LinearGradient olive = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.olive,
      AppColors.oliveLight,
    ],
  );

  /// Sunnah gradient (for Sunnah badges/cards)
  static const LinearGradient sunnah = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.sunnahExplicit,
      AppColors.sunnahImplied,
    ],
  );

  //═══════════════════════════════════════════════════════════════
  // CARD GRADIENTS
  //═══════════════════════════════════════════════════════════════

  /// Light card gradient
  static const LinearGradient cardLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF1F8E9),
      Color(0xFFE8F5E8),
    ],
  );

  /// Warm card gradient
  static const LinearGradient cardWarm = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFDF4),
      Color(0xFFFFF8E1),
    ],
  );

  /// White to grey gradient
  static const LinearGradient cardWhite = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.white,
      Color(0xFFFAFAFA),
    ],
  );

  //═══════════════════════════════════════════════════════════════
  // BUTTON GRADIENTS
  //═══════════════════════════════════════════════════════════════

  /// Primary button gradient
  static const LinearGradient buttonPrimary = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.primary,
      AppColors.primaryLight,
    ],
  );

  /// Secondary button gradient
  static const LinearGradient buttonSecondary = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.secondary,
      AppColors.secondaryLight,
    ],
  );

  /// Success button gradient
  static const LinearGradient buttonSuccess = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.success,
      Color(0xFF66BB6A),
    ],
  );

  /// Disabled button gradient
  static const LinearGradient buttonDisabled = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.grey400,
      AppColors.grey300,
    ],
  );

  //═══════════════════════════════════════════════════════════════
  // OVERLAY GRADIENTS
  //═══════════════════════════════════════════════════════════════

  /// Dark overlay gradient (for images)
  static const LinearGradient overlayDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Color(0xB3000000),
    ],
  );

  /// Light overlay gradient
  static const LinearGradient overlayLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Color(0x40000000),
    ],
  );

  /// White overlay gradient
  static const LinearGradient overlayWhite = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Color(0xE6FFFFFF),
    ],
  );

  /// Bottom fade gradient
  static const LinearGradient bottomFade = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.3, 1.0],
    colors: [
      Colors.transparent,
      Colors.transparent,
      Color(0xCC000000),
    ],
  );

  //═══════════════════════════════════════════════════════════════
  // SHIMMER GRADIENTS
  //═══════════════════════════════════════════════════════════════

  /// Shimmer gradient (light mode)
  static const LinearGradient shimmerLight = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.shimmerBase,
      AppColors.shimmerHighlight,
      AppColors.shimmerBase,
    ],
    stops: [0.0, 0.5, 1.0],
  );

  /// Shimmer gradient (dark mode)
  static const LinearGradient shimmerDark = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      AppColors.shimmerBaseDark,
      AppColors.shimmerHighlightDark,
      AppColors.shimmerBaseDark,
    ],
    stops: [0.0, 0.5, 1.0],
  );

  //═══════════════════════════════════════════════════════════════
  // STATUS GRADIENTS
  //═══════════════════════════════════════════════════════════════

  /// Success gradient
  static const LinearGradient success = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.success,
      Color(0xFF81C784),
    ],
  );

  /// Warning gradient
  static const LinearGradient warning = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.warning,
      Color(0xFFFFCC80),
    ],
  );

  /// Error gradient
  static const LinearGradient error = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.error,
      Color(0xFFEF5350),
    ],
  );

  //═══════════════════════════════════════════════════════════════
  // RADIAL GRADIENTS
  //═══════════════════════════════════════════════════════════════

  /// Primary radial gradient
  static const RadialGradient primaryRadial = RadialGradient(
    center: Alignment.center,
    radius: 0.8,
    colors: [
      AppColors.primaryLight,
      AppColors.primary,
    ],
  );

  /// Glow effect gradient
  static const RadialGradient glow = RadialGradient(
    center: Alignment.center,
    radius: 0.5,
    colors: [
      Color(0x4D4CAF50),
      Colors.transparent,
    ],
  );

  //═══════════════════════════════════════════════════════════════
  // HELPER METHODS
  //═══════════════════════════════════════════════════════════════

  /// Create custom linear gradient
  static LinearGradient custom({
    required List<Color> colors,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
    List<double>? stops,
  }) {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: colors,
      stops: stops,
    );
  }

  /// Create gradient with opacity
  static LinearGradient withOpacity(LinearGradient gradient, double opacity) {
    return LinearGradient(
      begin: gradient.begin,
      end: gradient.end,
      colors: gradient.colors.map((c) => c.withOpacity(opacity)).toList(),
      stops: gradient.stops,
    );
  }
}
