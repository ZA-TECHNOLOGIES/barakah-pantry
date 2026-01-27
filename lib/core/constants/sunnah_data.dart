/// Sunnah Data Constants
/// Contains all Sunnah-related static data
class SunnahData {
  SunnahData._();

  //═══════════════════════════════════════════════════════════════
  // SUNNAH INGREDIENTS LIST
  //═══════════════════════════════════════════════════════════════

  /// List of explicit Sunnah ingredients (lowercase for matching)
  static const List<String> sunnahIngredients = [
    'dates',
    'ajwa',
    'ajwa dates',
    'medjool',
    'honey',
    'raw honey',
    'olive oil',
    'olives',
    'black seed',
    'black seed oil',
    'nigella',
    'nigella sativa',
    'kalonji',
    'barley',
    'talbina',
    'milk',
    'vinegar',
    'apple cider vinegar',
    'watermelon',
    'pumpkin',
    'gourd',
    'squash',
    'lamb',
    'mutton',
    'sheep',
    'figs',
    'grapes',
    'raisins',
    'pomegranate',
    'cucumber',
    'zam zam',
    'zamzam',
  ];

  //═══════════════════════════════════════════════════════════════
  // INGREDIENT CATEGORIES
  //═══════════════════════════════════════════════════════════════

  static const List<Map<String, dynamic>> categories = [
    {'name': 'All', 'icon': 'apps', 'slug': 'all'},
    {'name': 'Fruits', 'icon': 'nutrition', 'slug': 'fruit'},
    {'name': 'Grains', 'icon': 'grain', 'slug': 'grain'},
    {'name': 'Oils', 'icon': 'water_drop', 'slug': 'oil'},
    {'name': 'Dairy', 'icon': 'egg', 'slug': 'dairy'},
    {'name': 'Meat', 'icon': 'restaurant', 'slug': 'meat'},
    {'name': 'Spices', 'icon': 'spa', 'slug': 'spice'},
    {'name': 'Other', 'icon': 'category', 'slug': 'other'},
  ];

  //═══════════════════════════════════════════════════════════════
  // MEAL TYPES
  //═══════════════════════════════════════════════════════════════

  static const List<String> mealTypes = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
    'Drink',
    'Dessert',
  ];

  //═══════════════════════════════════════════════════════════════
  // DIFFICULTY LEVELS
  //═══════════════════════════════════════════════════════════════

  static const List<String> difficultyLevels = [
    'Easy',
    'Medium',
    'Hard',
  ];

  //═══════════════════════════════════════════════════════════════
  // RECIPE TAGS
  //═══════════════════════════════════════════════════════════════

  static const List<String> recipeTags = [
    'Sunnah',
    'Quick',
    'Healthy',
    'Ramadan',
    'Kids',
    'Healing',
    'Energy',
    'Immunity',
    'Digestive',
    'Traditional',
  ];

  //═══════════════════════════════════════════════════════════════
  // USER GOALS
  //═══════════════════════════════════════════════════════════════

  static const List<Map<String, String>> userGoals = [
    {
      'id': 'eat_sunnah',
      'title': 'Eat More Sunnah Foods',
      'description': 'Incorporate blessed foods into my daily diet',
      'icon': 'star',
    },
    {
      'id': 'improve_health',
      'title': 'Improve My Health',
      'description': 'Use prophetic nutrition for better wellbeing',
      'icon': 'favorite',
    },
    {
      'id': 'learn_nutrition',
      'title': 'Learn Prophetic Nutrition',
      'description': 'Understand the wisdom behind Sunnah foods',
      'icon': 'school',
    },
    {
      'id': 'cook_family',
      'title': 'Cook for My Family',
      'description': 'Prepare blessed meals for loved ones',
      'icon': 'family_restroom',
    },
    {
      'id': 'lose_weight',
      'title': 'Manage Weight',
      'description': 'Healthy weight management the Sunnah way',
      'icon': 'monitor_weight',
    },
    {
      'id': 'build_habits',
      'title': 'Build Healthy Habits',
      'description': 'Develop consistent Sunnah eating habits',
      'icon': 'trending_up',
    },
  ];

  //═══════════════════════════════════════════════════════════════
  // QUICK ADD INGREDIENTS FOR AI
  //═══════════════════════════════════════════════════════════════

  static const List<String> quickAddIngredients = [
    'Dates',
    'Honey',
    'Olive Oil',
    'Black Seed',
    'Barley',
    'Milk',
    'Vinegar',
    'Figs',
    'Pomegranate',
    'Lamb',
  ];

  //═══════════════════════════════════════════════════════════════
  // HELPER METHODS
  //═══════════════════════════════════════════════════════════════

  /// Check if an ingredient is a Sunnah ingredient
  static bool isSunnahIngredient(String ingredient) {
    final lowerIngredient = ingredient.toLowerCase().trim();
    return sunnahIngredients.any(
      (sunnah) =>
          lowerIngredient.contains(sunnah) || sunnah.contains(lowerIngredient),
    );
  }

  /// Get Sunnah level for an ingredient
  static String getSunnahLevel(String ingredient) {
    if (isSunnahIngredient(ingredient)) {
      return 'explicit';
    }
    return 'halal_general';
  }
}
