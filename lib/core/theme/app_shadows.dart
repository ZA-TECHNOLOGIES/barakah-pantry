import 'package:flutter/material.dart';
import 'app_colors.dart';

/// App Shadows
/// Contains all shadow definitions used throughout the application
class AppShadows {
  AppShadows._();

  //═══════════════════════════════════════════════════════════════
  // ELEVATION SHADOWS (Material Design inspired)
  //═══════════════════════════════════════════════════════════════

  /// No shadow
  static List<BoxShadow> get none => [];

  /// Elevation 1 - Subtle shadow for cards
  static List<BoxShadow> get elevation1 => [
        BoxShadow(
          color: AppColors.shadow,
          offset: const Offset(0, 1),
          blurRadius: 3,
          spreadRadius: 0,
        ),
      ];

  /// Elevation 2 - Default card shadow
  static List<BoxShadow> get elevation2 => [
        BoxShadow(
          color: AppColors.shadow,
          offset: const Offset(0, 2),
          blurRadius: 6,
          spreadRadius: 0,
        ),
      ];

  /// Elevation 4 - Raised elements
  static List<BoxShadow> get elevation4 => [
        BoxShadow(
          color: AppColors.shadow,
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ];

  /// Elevation 8 - Floating elements, bottom sheets
  static List<BoxShadow> get elevation8 => [
        BoxShadow(
          color: AppColors.shadowMedium,
          offset: const Offset(0, 8),
          blurRadius: 24,
          spreadRadius: 0,
        ),
      ];

  /// Elevation 16 - Dialogs, modals
  static List<BoxShadow> get elevation16 => [
        BoxShadow(
          color: AppColors.shadowMedium,
          offset: const Offset(0, 16),
          blurRadius: 32,
          spreadRadius: 0,
        ),
      ];

  /// Elevation 24 - Maximum elevation
  static List<BoxShadow> get elevation24 => [
        BoxShadow(
          color: AppColors.shadowDark,
          offset: const Offset(0, 24),
          blurRadius: 48,
          spreadRadius: 0,
        ),
      ];

  //═══════════════════════════════════════════════════════════════
  // CARD SHADOWS
  //═══════════════════════════════════════════════════════════════

  /// Soft card shadow
  static List<BoxShadow> get cardSoft => [
        BoxShadow(
          color: AppColors.black.withOpacity(0.05),
          offset: const Offset(0, 2),
          blurRadius: 8,
          spreadRadius: 0,
        ),
      ];

  /// Medium card shadow
  static List<BoxShadow> get cardMedium => [
        BoxShadow(
          color: AppColors.black.withOpacity(0.08),
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ];

  /// Strong card shadow
  static List<BoxShadow> get cardStrong => [
        BoxShadow(
          color: AppColors.black.withOpacity(0.1),
          offset: const Offset(0, 6),
          blurRadius: 16,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: AppColors.black.withOpacity(0.05),
          offset: const Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ];

  //═══════════════════════════════════════════════════════════════
  // COLORED SHADOWS
  //═══════════════════════════════════════════════════════════════

  /// Primary color shadow
  static List<BoxShadow> get primaryShadow => [
        BoxShadow(
          color: AppColors.primary.withOpacity(0.3),
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ];

  /// Primary color shadow (large)
  static List<BoxShadow> get primaryShadowLarge => [
        BoxShadow(
          color: AppColors.primary.withOpacity(0.25),
          offset: const Offset(0, 8),
          blurRadius: 24,
          spreadRadius: 0,
        ),
      ];

  /// Success color shadow
  static List<BoxShadow> get successShadow => [
        BoxShadow(
          color: AppColors.success.withOpacity(0.3),
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ];

  /// Error color shadow
  static List<BoxShadow> get errorShadow => [
        BoxShadow(
          color: AppColors.error.withOpacity(0.3),
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ];

  /// Warning color shadow
  static List<BoxShadow> get warningShadow => [
        BoxShadow(
          color: AppColors.warning.withOpacity(0.3),
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ];

  /// Honey gold shadow
  static List<BoxShadow> get honeyShadow => [
        BoxShadow(
          color: AppColors.honeyGold.withOpacity(0.3),
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ];

  //═══════════════════════════════════════════════════════════════
  // SPECIAL SHADOWS
  //═══════════════════════════════════════════════════════════════

  /// Bottom navigation shadow
  static List<BoxShadow> get bottomNav => [
        BoxShadow(
          color: AppColors.black.withOpacity(0.08),
          offset: const Offset(0, -4),
          blurRadius: 16,
          spreadRadius: 0,
        ),
      ];

  /// Top shadow (for sticky headers)
  static List<BoxShadow> get topShadow => [
        BoxShadow(
          color: AppColors.black.withOpacity(0.08),
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ];

  /// Inner shadow (for inset effects)
  static List<BoxShadow> get innerShadow => [
        BoxShadow(
          color: AppColors.black.withOpacity(0.1),
          offset: const Offset(0, 2),
          blurRadius: 4,
          spreadRadius: -2,
        ),
      ];

  /// Glow shadow (for highlighted elements)
  static List<BoxShadow> get glow => [
        BoxShadow(
          color: AppColors.primary.withOpacity(0.4),
          offset: Offset.zero,
          blurRadius: 20,
          spreadRadius: 0,
        ),
      ];

  /// Floating button shadow
  static List<BoxShadow> get floatingButton => [
        BoxShadow(
          color: AppColors.primary.withOpacity(0.3),
          offset: const Offset(0, 6),
          blurRadius: 16,
          spreadRadius: 0,
        ),
        BoxShadow(
          color: AppColors.primary.withOpacity(0.1),
          offset: const Offset(0, 2),
          blurRadius: 4,
          spreadRadius: 0,
        ),
      ];

  //═══════════════════════════════════════════════════════════════
  // HELPER METHODS
  //═══════════════════════════════════════════════════════════════

  /// Create custom shadow with color
  static List<BoxShadow> withColor(Color color, {double opacity = 0.3}) => [
        BoxShadow(
          color: color.withOpacity(opacity),
          offset: const Offset(0, 4),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ];

  /// Create custom elevation shadow
  static List<BoxShadow> withElevation(double elevation) => [
        BoxShadow(
          color: AppColors.black.withOpacity(0.1),
          offset: Offset(0, elevation / 2),
          blurRadius: elevation * 1.5,
          spreadRadius: 0,
        ),
      ];
}
