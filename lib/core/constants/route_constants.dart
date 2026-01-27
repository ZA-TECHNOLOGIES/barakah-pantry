/// Route Constants
/// Contains all route paths used in the application
class RouteConstants {
  RouteConstants._();

  //═══════════════════════════════════════════════════════════════
  // INITIAL ROUTES
  //═══════════════════════════════════════════════════════════════

  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String goalsSelection = '/goals-selection';
  static const String ingredientSelection = '/ingredient-selection';

  //═══════════════════════════════════════════════════════════════
  // AUTH ROUTES
  //═══════════════════════════════════════════════════════════════

  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String otpVerification = '/otp-verification';

  //═══════════════════════════════════════════════════════════════
  // MAIN ROUTES
  //═══════════════════════════════════════════════════════════════

  static const String main = '/main';
  static const String home = '/home';
  static const String pantry = '/pantry';
  static const String recipes = '/recipes';
  static const String progress = '/progress';
  static const String profile = '/profile';

  //═══════════════════════════════════════════════════════════════
  // DETAIL ROUTES
  //═══════════════════════════════════════════════════════════════

  static const String ingredientDetail = '/ingredient/:id';
  static const String recipeDetail = '/recipe/:id';
  static const String tipDetail = '/tip/:id';

  //═══════════════════════════════════════════════════════════════
  // AI ROUTES
  //═══════════════════════════════════════════════════════════════

  static const String aiRecipe = '/ai-recipe';
  static const String aiRecipeResult = '/ai-recipe-result';

  //═══════════════════════════════════════════════════════════════
  // OTHER ROUTES
  //═══════════════════════════════════════════════════════════════

  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String dailyTips = '/daily-tips';
  static const String cookingHistory = '/cooking-history';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String about = '/about';
  static const String premium = '/premium';

  //═══════════════════════════════════════════════════════════════
  // HELPER METHODS
  //═══════════════════════════════════════════════════════════════

  /// Generate ingredient detail route with ID
  static String ingredientDetailPath(String id) => '/ingredient/$id';

  /// Generate recipe detail route with ID
  static String recipeDetailPath(String id) => '/recipe/$id';

  /// Generate tip detail route with ID
  static String tipDetailPath(String id) => '/tip/$id';
}
