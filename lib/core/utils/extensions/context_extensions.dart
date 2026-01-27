import 'package:flutter/material.dart';

/// BuildContext Extensions
/// Utility extension methods for BuildContext
extension ContextExtensions on BuildContext {
  //═══════════════════════════════════════════════════════════════
  // THEME
  //═══════════════════════════════════════════════════════════════

  /// Get current theme
  ThemeData get theme => Theme.of(this);

  /// Get text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Check if dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Get primary color
  Color get primaryColor => Theme.of(this).primaryColor;

  /// Get scaffold background color
  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;

  //═══════════════════════════════════════════════════════════════
  // MEDIA QUERY
  //═══════════════════════════════════════════════════════════════

  /// Get media query data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Get safe area padding
  EdgeInsets get safeAreaPadding => MediaQuery.of(this).padding;

  /// Get view insets (keyboard height)
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  /// Get top padding (status bar height)
  double get topPadding => MediaQuery.of(this).padding.top;

  /// Get bottom padding (home indicator height)
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  /// Get keyboard height
  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;

  /// Get device pixel ratio
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// Get text scale factor
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;

  //═══════════════════════════════════════════════════════════════
  // RESPONSIVE
  //═══════════════════════════════════════════════════════════════

  /// Check if screen is mobile (< 600)
  bool get isMobile => screenWidth < 600;

  /// Check if screen is tablet (600 - 900)
  bool get isTablet => screenWidth >= 600 && screenWidth < 900;

  /// Check if screen is desktop (>= 900)
  bool get isDesktop => screenWidth >= 900;

  /// Check if screen is in landscape orientation
  bool get isLandscape => screenWidth > screenHeight;

  /// Check if screen is in portrait orientation
  bool get isPortrait => screenHeight > screenWidth;

  /// Get responsive value based on screen size
  T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  //═══════════════════════════════════════════════════════════════
  // NAVIGATION
  //═══════════════════════════════════════════════════════════════

  /// Pop current route
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  /// Check if can pop
  bool get canPop => Navigator.of(this).canPop();

  /// Pop until first route
  void popToFirst() => Navigator.of(this).popUntil((route) => route.isFirst);

  //═══════════════════════════════════════════════════════════════
  // FOCUS
  //═══════════════════════════════════════════════════════════════

  /// Unfocus current focus (dismiss keyboard)
  void unfocus() => FocusScope.of(this).unfocus();

  /// Request focus on node
  void requestFocus(FocusNode node) => FocusScope.of(this).requestFocus(node);

  //═══════════════════════════════════════════════════════════════
  // SNACKBAR
  //═══════════════════════════════════════════════════════════════

  /// Show snackbar
  void showSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  /// Show simple snackbar with message
  void showMessage(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }

  /// Show success snackbar
  void showSuccess(String message) {
    showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  /// Show error snackbar
  void showError(String message) {
    showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  /// Hide current snackbar
  void hideSnackBar() => ScaffoldMessenger.of(this).hideCurrentSnackBar();

  //═══════════════════════════════════════════════════════════════
  // DIALOG
  //═══════════════════════════════════════════════════════════════

  /// Show dialog
  Future<T?> showAppDialog<T>(Widget dialog) {
    return showDialog<T>(
      context: this,
      builder: (_) => dialog,
    );
  }

  /// Show bottom sheet
  Future<T?> showAppBottomSheet<T>(Widget sheet,
      {bool isScrollControlled = true}) {
    return showModalBottomSheet<T>(
      context: this,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (_) => sheet,
    );
  }
}
