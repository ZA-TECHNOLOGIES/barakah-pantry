import 'package:flutter/material.dart';

/// Application Spacing
/// Defines all spacing values used throughout the application
/// Following 4pt grid system
class AppSpacing {
  AppSpacing._();

  //═══════════════════════════════════════════════════════════════
  // BASE SPACING (4pt Grid)
  //═══════════════════════════════════════════════════════════════

  static const double xxs = 2.0; // 2pt
  static const double xs = 4.0; // 4pt
  static const double sm = 8.0; // 8pt
  static const double md = 16.0; // 16pt
  static const double lg = 24.0; // 24pt
  static const double xl = 32.0; // 32pt
  static const double xxl = 48.0; // 48pt
  static const double xxxl = 64.0; // 64pt

  //═══════════════════════════════════════════════════════════════
  // PADDING
  //═══════════════════════════════════════════════════════════════

  static const double pagePaddingHorizontal = 16.0;
  static const double pagePaddingVertical = 16.0;
  static const double cardPadding = 16.0;
  static const double cardPaddingSmall = 12.0;
  static const double cardPaddingLarge = 20.0;
  static const double inputPadding = 16.0;
  static const double buttonPaddingHorizontal = 24.0;
  static const double buttonPaddingVertical = 14.0;
  static const double chipPaddingHorizontal = 12.0;
  static const double chipPaddingVertical = 6.0;
  static const double sectionPadding = 24.0;
  static const double listItemPadding = 16.0;
  static const double dialogPadding = 24.0;

  //═══════════════════════════════════════════════════════════════
  // MARGIN
  //═══════════════════════════════════════════════════════════════

  static const double pageMargin = 16.0;
  static const double cardMargin = 12.0;
  static const double sectionMargin = 24.0;
  static const double itemSpacing = 12.0;
  static const double listSpacing = 16.0;
  static const double gridSpacing = 12.0;

  //═══════════════════════════════════════════════════════════════
  // BORDER RADIUS
  //═══════════════════════════════════════════════════════════════

  static const double radiusNone = 0.0;
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radiusXxl = 24.0;
  static const double radiusXxxl = 32.0;
  static const double radiusFull = 999.0;

  // Specific Radius
  static const double buttonRadius = 12.0;
  static const double cardRadius = 16.0;
  static const double inputRadius = 12.0;
  static const double chipRadius = 20.0;
  static const double bottomSheetRadius = 24.0;
  static const double dialogRadius = 16.0;
  static const double imageRadius = 12.0;
  static const double avatarRadius = 50.0;

  //═══════════════════════════════════════════════════════════════
  // ICON SIZES
  //═══════════════════════════════════════════════════════════════

  static const double iconXxs = 12.0;
  static const double iconXs = 16.0;
  static const double iconSm = 20.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;
  static const double iconXxl = 64.0;

  //═══════════════════════════════════════════════════════════════
  // AVATAR SIZES
  //═══════════════════════════════════════════════════════════════

  static const double avatarXs = 24.0;
  static const double avatarSm = 32.0;
  static const double avatarMd = 48.0;
  static const double avatarLg = 64.0;
  static const double avatarXl = 96.0;
  static const double avatarXxl = 120.0;

  //═══════════════════════════════════════════════════════════════
  // BUTTON SIZES
  //═══════════════════════════════════════════════════════════════

  static const double buttonHeightSm = 36.0;
  static const double buttonHeightMd = 48.0;
  static const double buttonHeightLg = 56.0;
  static const double buttonMinWidth = 88.0;

  //═══════════════════════════════════════════════════════════════
  // INPUT SIZES
  //═══════════════════════════════════════════════════════════════

  static const double inputHeightSm = 40.0;
  static const double inputHeightMd = 48.0;
  static const double inputHeightLg = 56.0;

  //═══════════════════════════════════════════════════════════════
  // CARD SIZES
  //═══════════════════════════════════════════════════════════════

  static const double cardHeightSm = 100.0;
  static const double cardHeightMd = 150.0;
  static const double cardHeightLg = 200.0;
  static const double cardHeightXl = 250.0;

  static const double cardWidthSm = 150.0;
  static const double cardWidthMd = 200.0;
  static const double cardWidthLg = 280.0;

  //═══════════════════════════════════════════════════════════════
  // NAVIGATION
  //═══════════════════════════════════════════════════════════════

  static const double bottomNavHeight = 80.0;
  static const double appBarHeight = 56.0;
  static const double appBarExpandedHeight = 200.0;
  static const double tabBarHeight = 48.0;

  //═══════════════════════════════════════════════════════════════
  // DIVIDER
  //═══════════════════════════════════════════════════════════════

  static const double dividerThickness = 1.0;
  static const double dividerThicknessBold = 2.0;
  static const double dividerIndent = 16.0;

  //═══════════════════════════════════════════════════════════════
  // GRID
  //═══════════════════════════════════════════════════════════════

  static const int gridColumns = 2;
  static const double gridCrossAxisSpacing = 12.0;
  static const double gridMainAxisSpacing = 12.0;
  static const double gridChildAspectRatio = 0.85;

  //═══════════════════════════════════════════════════════════════
  // LIST
  //═══════════════════════════════════════════════════════════════

  static const double listItemHeight = 72.0;
  static const double listItemHeightSmall = 56.0;
  static const double listItemHeightLarge = 88.0;
  static const double listSeparatorHeight = 1.0;

  //═══════════════════════════════════════════════════════════════
  // BORDER WIDTH
  //═══════════════════════════════════════════════════════════════

  static const double borderWidth = 1.0;
  static const double borderWidthMedium = 1.5;
  static const double borderWidthBold = 2.0;
  static const double borderWidthThick = 3.0;

  //═══════════════════════════════════════════════════════════════
  // EDGE INSETS HELPERS
  //═══════════════════════════════════════════════════════════════

  static const EdgeInsets paddingAllXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingAllSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingAllMd = EdgeInsets.all(md);
  static const EdgeInsets paddingAllLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingAllXl = EdgeInsets.all(xl);

  static const EdgeInsets paddingHorizontalSm =
      EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets paddingHorizontalMd =
      EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets paddingHorizontalLg =
      EdgeInsets.symmetric(horizontal: lg);

  static const EdgeInsets paddingVerticalSm =
      EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets paddingVerticalMd =
      EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets paddingVerticalLg =
      EdgeInsets.symmetric(vertical: lg);

  static const EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: pagePaddingHorizontal,
    vertical: pagePaddingVertical,
  );

  static const EdgeInsets cardContentPadding = EdgeInsets.all(cardPadding);

  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: buttonPaddingHorizontal,
    vertical: buttonPaddingVertical,
  );

  //═══════════════════════════════════════════════════════════════
  // BORDER RADIUS HELPERS
  //═══════════════════════════════════════════════════════════════

  static BorderRadius get borderRadiusSm => BorderRadius.circular(radiusSm);
  static BorderRadius get borderRadiusMd => BorderRadius.circular(radiusMd);
  static BorderRadius get borderRadiusLg => BorderRadius.circular(radiusLg);
  static BorderRadius get borderRadiusXl => BorderRadius.circular(radiusXl);
  static BorderRadius get borderRadiusFull => BorderRadius.circular(radiusFull);

  static BorderRadius get cardBorderRadius => BorderRadius.circular(cardRadius);
  static BorderRadius get buttonBorderRadius =>
      BorderRadius.circular(buttonRadius);
  static BorderRadius get inputBorderRadius =>
      BorderRadius.circular(inputRadius);
  static BorderRadius get bottomSheetBorderRadius => BorderRadius.vertical(
        top: Radius.circular(bottomSheetRadius),
      );
}
