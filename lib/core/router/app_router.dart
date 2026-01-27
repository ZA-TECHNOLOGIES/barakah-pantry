import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/route_constants.dart';

// Feature Modules
import '../../features/splash/splash_module.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/onboarding_module.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/onboarding/presentation/screens/goals_selection_screen.dart';
import '../../features/onboarding/presentation/screens/ingredient_selection_screen.dart';
import '../../features/auth/auth_module.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/navigation/navigation_module.dart';
import '../../features/navigation/presentation/screens/main_navigation_screen.dart';
import '../../features/home/home_module.dart';
import '../../features/pantry/pantry_module.dart';
import '../../features/pantry/presentation/screens/pantry_screen.dart';
import '../../features/pantry/presentation/screens/ingredient_detail_screen.dart';
import '../../features/recipes/recipes_module.dart';
import '../../features/recipes/presentation/screens/recipes_screen.dart';
import '../../features/recipes/presentation/screens/recipe_detail_screen.dart';
import '../../features/ai_recipe/ai_recipe_module.dart';
import '../../features/ai_recipe/presentation/screens/ai_recipe_screen.dart';
import '../../features/ai_recipe/presentation/screens/ai_recipe_result_screen.dart';
import '../../features/favorites/favorites_module.dart';
import '../../features/favorites/presentation/screens/favorites_screen.dart';
import '../../features/progress/progress_module.dart';
import '../../features/progress/presentation/screens/progress_screen.dart';
import '../../features/profile/profile_module.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';
import '../../features/daily_tips/daily_tips_module.dart';
import '../../features/daily_tips/presentation/screens/daily_tips_screen.dart';
import '../../features/search/search_module.dart';
import '../../features/search/presentation/screens/search_screen.dart';

/// App Router
/// Manages all application routes and navigation
class AppRouter {
  AppRouter._();

  /// Initial route
  static const String initial = RouteConstants.splash;

  /// All application routes
  static final List<GetPage> routes = [
    // SPLASH & ONBOARDING
    GetPage(
      name: RouteConstants.splash,
      page: () => const SplashScreen(),
      binding: SplashModule(),
      transition: Transition.fade,
    ),

    GetPage(
      name: RouteConstants.onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingModule(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: RouteConstants.goalsSelection,
      page: () => const GoalsSelectionScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: RouteConstants.ingredientSelection,
      page: () => const IngredientSelectionScreen(),
      transition: Transition.rightToLeft,
    ),

    // AUTHENTICATION
    GetPage(
      name: RouteConstants.login,
      page: () => const LoginScreen(),
      binding: AuthModule(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: RouteConstants.signup,
      page: () => const SignupScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: RouteConstants.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      transition: Transition.rightToLeft,
    ),

    // MAIN NAVIGATION
    GetPage(
      name: RouteConstants.main,
      page: () => const MainNavigationScreen(),
      binding: NavigationModule(),
      bindings: [
        HomeModule(),
        PantryModule(),
        RecipesModule(),
        ProgressModule(),
        ProfileModule(),
      ],
      transition: Transition.fadeIn,
    ),

    // PANTRY
    GetPage(
      name: RouteConstants.pantry,
      page: () => const PantryScreen(),
      binding: PantryModule(),
    ),

    GetPage(
      name: RouteConstants.ingredientDetail,
      page: () => const IngredientDetailScreen(),
      transition: Transition.rightToLeft,
    ),

    // RECIPES
    GetPage(
      name: RouteConstants.recipes,
      page: () => const RecipesScreen(),
      binding: RecipesModule(),
    ),

    GetPage(
      name: RouteConstants.recipeDetail,
      page: () => const RecipeDetailScreen(),
      transition: Transition.rightToLeft,
    ),

    // AI RECIPE
    GetPage(
      name: RouteConstants.aiRecipe,
      page: () => const AIRecipeScreen(),
      binding: AIRecipeModule(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: RouteConstants.aiRecipeResult,
      page: () => const AIRecipeResultScreen(),
      transition: Transition.rightToLeft,
    ),

    // FAVORITES
    GetPage(
      name: RouteConstants.favorites,
      page: () => const FavoritesScreen(),
      binding: FavoritesModule(),
      transition: Transition.rightToLeft,
    ),

    // DAILY TIPS
    GetPage(
      name: RouteConstants.dailyTips,
      page: () => const DailyTipsScreen(),
      binding: DailyTipsModule(),
      transition: Transition.rightToLeft,
    ),

    // PROGRESS
    GetPage(
      name: RouteConstants.progress,
      page: () => const ProgressScreen(),
      binding: ProgressModule(),
    ),

    // PROFILE
    GetPage(
      name: RouteConstants.profile,
      page: () => const ProfileScreen(),
      binding: ProfileModule(),
    ),

    GetPage(
      name: RouteConstants.editProfile,
      page: () => const EditProfileScreen(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: RouteConstants.settings,
      page: () => const SettingsScreen(),
      transition: Transition.rightToLeft,
    ),

    // SEARCH
    GetPage(
      name: RouteConstants.search,
      page: () => const SearchScreen(),
      binding: SearchModule(),
      transition: Transition.fadeIn,
    ),
  ];

  static final GetPage unknownRoute = GetPage(
    name: '/not-found',
    page: () => const Scaffold(
      body: Center(
        child: Text('Page Not Found'),
      ),
    ),
  );
}
