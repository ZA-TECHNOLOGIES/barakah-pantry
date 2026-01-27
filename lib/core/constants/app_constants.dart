/// Application Constants
/// Contains all app-wide constant values
class AppConstants {
  AppConstants._();

  //═══════════════════════════════════════════════════════════════
  // APP INFO
  //═══════════════════════════════════════════════════════════════

  static const String appName = 'Barakah Pantry';
  static const String appTagline = 'Nourishment with Barakah';
  static const String appTaglineArabic = 'بركة';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  //═══════════════════════════════════════════════════════════════
  // LIMITS
  //═══════════════════════════════════════════════════════════════

  /// Maximum free AI recipes per day
  static const int maxFreeAIRecipes = 5;

  /// Maximum AI recipes for guest users
  static const int maxGuestAIRecipes = 3;

  /// Maximum ingredients per recipe generation
  static const int maxIngredientsPerRecipe = 20;

  /// Maximum favorites for free users
  static const int maxFreeFavorites = 50;

  /// Maximum recent searches to store
  static const int maxRecentSearches = 10;

  /// Minimum password length
  static const int minPasswordLength = 6;

  /// Maximum username length
  static const int maxUsernameLength = 30;

  //═══════════════════════════════════════════════════════════════
  // PAGINATION
  //═══════════════════════════════════════════════════════════════

  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;
  static const int initialPage = 1;

  //═══════════════════════════════════════════════════════════════
  // CACHE DURATION
  //═══════════════════════════════════════════════════════════════

  static const Duration ingredientsCacheDuration = Duration(hours: 24);
  static const Duration recipesCacheDuration = Duration(hours: 12);
  static const Duration dailyTipCacheDuration = Duration(hours: 24);
  static const Duration profileCacheDuration = Duration(hours: 1);

  //═══════════════════════════════════════════════════════════════
  // ANIMATION DURATION
  //═══════════════════════════════════════════════════════════════

  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);
  static const Duration splashDuration = Duration(seconds: 3);

  //═══════════════════════════════════════════════════════════════
  // DEBOUNCE DURATION
  //═══════════════════════════════════════════════════════════════

  static const Duration searchDebounceDuration = Duration(milliseconds: 500);
  static const Duration scrollDebounceDuration = Duration(milliseconds: 100);

  //═══════════════════════════════════════════════════════════════
  // SNACKBAR DURATION
  //═══════════════════════════════════════════════════════════════

  static const Duration snackbarDuration = Duration(seconds: 3);
  static const Duration snackbarLongDuration = Duration(seconds: 5);

  //═══════════════════════════════════════════════════════════════
  // IMAGE QUALITY
  //═══════════════════════════════════════════════════════════════

  static const int imageQuality = 85;
  static const int thumbnailSize = 150;
  static const int maxImageSize = 1024;

  //═══════════════════════════════════════════════════════════════
  // SUPPORT
  //═══════════════════════════════════════════════════════════════

  static const String supportEmail = 'support@barakahpantry.com';
  static const String websiteUrl = 'https://barakahpantry.com';
  static const String privacyPolicyUrl = 'https://barakahpantry.com/privacy';
  static const String termsOfServiceUrl = 'https://barakahpantry.com/terms';
}
