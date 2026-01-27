/// Supabase Configuration
/// Contains all Supabase-related constants and configuration
class SupabaseConfig {
  SupabaseConfig._();

  //═══════════════════════════════════════════════════════════════
  // CONNECTION
  //═══════════════════════════════════════════════════════════════

  /// Supabase Project URL
  static const String url = 'https://ihzzpfukuvcebrlxyhja.supabase.co';
  static const String anonKey =
      'sb_publishable_bgucyrHpcubmxpBoeFvcnA_fQ87-ha6';

  //═══════════════════════════════════════════════════════════════
  // TABLE NAMES
  //═══════════════════════════════════════════════════════════════

  static const String profilesTable = 'profiles';
  static const String ingredientsTable = 'ingredients';
  static const String recipesTable = 'recipes';
  static const String favoritesTable = 'favorites';
  static const String dailyTipsTable = 'daily_tips';
  static const String hadithReferencesTable = 'hadith_references';
  static const String quranReferencesTable = 'quran_references';
  static const String cookingHistoryTable = 'cooking_history';
  static const String aiGenerationsTable = 'ai_generations';
  static const String recipeRatingsTable = 'recipe_ratings';

  //═══════════════════════════════════════════════════════════════
  // STORAGE BUCKETS
  //═══════════════════════════════════════════════════════════════

  static const String avatarsBucket = 'avatars';
  static const String recipeImagesBucket = 'recipe_images';
  static const String ingredientImagesBucket = 'ingredient_images';

  //═══════════════════════════════════════════════════════════════
  // QUERIES
  //═══════════════════════════════════════════════════════════════

  /// Query for ingredients with references
  static const String ingredientWithReferencesQuery = '''
    *,
    hadith_references(*),
    quran_references(*)
  ''';

  /// Query for recipes with details
  static const String recipeWithDetailsQuery = '''
    *,
    profiles(id, full_name, avatar_url)
  ''';

  /// Query for daily tips with ingredient
  static const String dailyTipWithIngredientQuery = '''
    *,
    ingredients(*)
  ''';

  /// Query for favorites with recipes
  static const String favoritesWithRecipesQuery = '''
    *,
    recipes(*)
  ''';

  /// Query for cooking history with recipes
  static const String cookingHistoryWithRecipesQuery = '''
    *,
    recipes(*)
  ''';
}
