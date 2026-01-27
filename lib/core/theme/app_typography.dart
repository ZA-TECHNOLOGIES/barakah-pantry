import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Application Typography
/// Defines all text styles used throughout the application
class AppTypography {
  AppTypography._();

  //═══════════════════════════════════════════════════════════════
  // FONT FAMILIES
  //═══════════════════════════════════════════════════════════════

  static const String fontFamily = 'Poppins';
  static const String arabicFontFamily = 'Amiri';

  //═══════════════════════════════════════════════════════════════
  // TEXT THEME - LIGHT
  //═══════════════════════════════════════════════════════════════

  static TextTheme get textTheme {
    return TextTheme(
      // Display Styles
      displayLarge: GoogleFonts.poppins(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 1.12,
        color: AppColors.textPrimary,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.16,
        color: AppColors.textPrimary,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.22,
        color: AppColors.textPrimary,
      ),

      // Headline Styles
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.25,
        color: AppColors.textPrimary,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.29,
        color: AppColors.textPrimary,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.33,
        color: AppColors.textPrimary,
      ),

      // Title Styles
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.27,
        color: AppColors.textPrimary,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.5,
        color: AppColors.textPrimary,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.43,
        color: AppColors.textPrimary,
      ),

      // Body Styles
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.5,
        color: AppColors.textPrimary,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
        color: AppColors.textSecondary,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
        color: AppColors.textSecondary,
      ),

      // Label Styles
      labelLarge: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
        color: AppColors.textPrimary,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.33,
        color: AppColors.textSecondary,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.45,
        color: AppColors.textTertiary,
      ),
    );
  }

  //═══════════════════════════════════════════════════════════════
  // TEXT THEME - DARK
  //═══════════════════════════════════════════════════════════════

  static TextTheme get textThemeDark {
    return textTheme.apply(
      bodyColor: AppColors.white,
      displayColor: AppColors.white,
      decorationColor: AppColors.white,
    );
  }

  //═══════════════════════════════════════════════════════════════
  // CUSTOM TEXT STYLES
  //═══════════════════════════════════════════════════════════════

  // Arabic Styles
  static TextStyle get arabicDisplayLarge => GoogleFonts.amiri(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.8,
        color: AppColors.textPrimary,
      );

  static TextStyle get arabicTitle => GoogleFonts.amiri(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.8,
        color: AppColors.primary,
      );

  static TextStyle get arabicBody => GoogleFonts.amiri(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 2.0,
        color: AppColors.textPrimary,
      );

  static TextStyle get arabicCaption => GoogleFonts.amiri(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.8,
        color: AppColors.textSecondary,
      );

  // Quote Styles
  static TextStyle get quoteText => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        height: 1.6,
        color: AppColors.textSecondary,
      );

  static TextStyle get quoteSource => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
      );

  // Button Styles
  static TextStyle get buttonLarge => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      );

  static TextStyle get buttonMedium => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      );

  static TextStyle get buttonSmall => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      );

  // Badge Styles
  static TextStyle get badgeText => GoogleFonts.poppins(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      );

  static TextStyle get chipText => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );

  // Price/Number Styles
  static TextStyle get priceText => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      );

  static TextStyle get numberLarge => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
      );

  static TextStyle get numberMedium => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  // Input Styles
  static TextStyle get inputText => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  static TextStyle get inputHint => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textHint,
      );

  static TextStyle get inputLabel => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  static TextStyle get inputError => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.error,
      );

  // Link Styles
  static TextStyle get linkText => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
        decoration: TextDecoration.underline,
      );

  // Greeting Styles
  static TextStyle get greetingSmall => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      );

  static TextStyle get greetingLarge => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
      );

  // Section Header
  static TextStyle get sectionTitle => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get sectionSubtitle => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  // Card Styles
  static TextStyle get cardTitle => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get cardSubtitle => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get cardCaption => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiary,
      );

  // Timer/Duration Styles
  static TextStyle get timerText => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
      );

  // Step Number Style
  static TextStyle get stepNumber => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
      );
  //═══════════════════════════════════════════════════════════════
  // CONVENIENCE GETTERS (Material 2 / Custom map)
  //═══════════════════════════════════════════════════════════════

  static TextStyle get h1 => textTheme.displayLarge!
      .copyWith(fontSize: 18, fontWeight: FontWeight.w300, letterSpacing: -1.5);
  static TextStyle get h2 => textTheme.displayMedium!
      .copyWith(fontSize: 16, fontWeight: FontWeight.w300, letterSpacing: -0.5);
  static TextStyle get h3 => textTheme.displaySmall!
      .copyWith(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0);
  static TextStyle get h4 => textTheme.headlineMedium!
      .copyWith(fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25);
  static TextStyle get h5 => textTheme.headlineSmall!
      .copyWith(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0);
  static TextStyle get subtitle1 => textTheme.titleMedium!
      .copyWith(fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 0.15);
  static TextStyle get body1 => textTheme.bodyLarge!
      .copyWith(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5);
  static TextStyle get body2 => textTheme.bodyMedium!
      .copyWith(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25);
  static TextStyle get button => textTheme.labelLarge!
      .copyWith(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25);
  static TextStyle get caption => textTheme.bodySmall!
      .copyWith(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4);
  static TextStyle get overline => textTheme.labelSmall!
      .copyWith(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5);
}
