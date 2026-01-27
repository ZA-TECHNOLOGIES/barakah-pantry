/// Storage Keys
/// Contains all keys used for local storage
class StorageKeys {
  StorageKeys._();

  //═══════════════════════════════════════════════════════════════
  // AUTH KEYS
  //═══════════════════════════════════════════════════════════════

  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String isLoggedIn = 'is_logged_in';

  //═══════════════════════════════════════════════════════════════
  // USER KEYS
  //═══════════════════════════════════════════════════════════════

  static const String userProfile = 'user_profile';
  static const String userEmail = 'user_email';
  static const String userName = 'user_name';
  static const String userAvatar = 'user_avatar';
  static const String userGoals = 'user_goals';
  static const String dietaryPreferences = 'dietary_preferences';

  //═══════════════════════════════════════════════════════════════
  // ONBOARDING KEYS
  //═══════════════════════════════════════════════════════════════

  static const String onboardingCompleted = 'onboarding_completed';
  static const String isFirstLaunch = 'is_first_launch';

  //═══════════════════════════════════════════════════════════════
  // SETTINGS KEYS
  //═══════════════════════════════════════════════════════════════

  static const String dailyReminderEnabled = 'daily_reminder_enabled';
  static const String reminderTime = 'reminder_time';
  static const String themeMode = 'theme_mode';
  static const String language = 'language';
  static const String notificationsEnabled = 'notifications_enabled';

  //═══════════════════════════════════════════════════════════════
  // CACHE KEYS
  //═══════════════════════════════════════════════════════════════

  static const String ingredientsCache = 'ingredients_cache';
  static const String ingredientsCacheTime = 'ingredients_cache_time';
  static const String recipesCache = 'recipes_cache';
  static const String recipesCacheTime = 'recipes_cache_time';
  static const String dailyTipCache = 'daily_tip_cache';
  static const String dailyTipCacheDate = 'daily_tip_cache_date';
  static const String featuredRecipesCache = 'featured_recipes_cache';

  //═══════════════════════════════════════════════════════════════
  // AI KEYS
  //═══════════════════════════════════════════════════════════════

  static const String aiRecipesUsedToday = 'ai_recipes_used_today';
  static const String aiRecipesUsedDate = 'ai_recipes_used_date';
  static const String lastGeneratedRecipe = 'last_generated_recipe';

  //═══════════════════════════════════════════════════════════════
  // SEARCH KEYS
  //═══════════════════════════════════════════════════════════════

  static const String recentSearches = 'recent_searches';
  static const String searchHistory = 'search_history';

  //═══════════════════════════════════════════════════════════════
  // FAVORITES KEYS
  //═══════════════════════════════════════════════════════════════

  static const String favoriteRecipes = 'favorite_recipes';
  static const String favoriteIngredients = 'favorite_ingredients';
}
