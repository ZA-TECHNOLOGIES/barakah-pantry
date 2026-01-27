import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Core
import 'package:barakah_pantry/core/config/supabase_config.dart';
import 'package:barakah_pantry/core/network/network_info.dart';

// Data Sources (Remote)
import 'package:barakah_pantry/data/datasources/remote/gemini_datasource.dart';

// Repositories
import 'package:barakah_pantry/domain/repositories/auth_repository.dart';
import 'package:barakah_pantry/domain/repositories/user_repository.dart';
import 'package:barakah_pantry/domain/repositories/ingredient_repository.dart';
import 'package:barakah_pantry/domain/repositories/recipe_repository.dart';
import 'package:barakah_pantry/domain/repositories/favorite_repository.dart';
import 'package:barakah_pantry/domain/repositories/daily_tip_repository.dart';
import 'package:barakah_pantry/domain/repositories/ai_repository.dart';
import 'package:barakah_pantry/domain/repositories/cooking_history_repository.dart';

import 'package:barakah_pantry/data/repositories/auth_repository_impl.dart';
import 'package:barakah_pantry/data/repositories/user_repository_impl.dart';
import 'package:barakah_pantry/data/repositories/ingredient_repository_impl.dart';
import 'package:barakah_pantry/data/repositories/recipe_repository_impl.dart';
import 'package:barakah_pantry/data/repositories/favorite_repository_impl.dart';
import 'package:barakah_pantry/data/repositories/daily_tip_repository_impl.dart';
import 'package:barakah_pantry/data/repositories/ai_repository_impl.dart';
import 'package:barakah_pantry/data/repositories/cooking_history_repository_impl.dart';

// Use Cases - Auth
import 'package:barakah_pantry/domain/usecases/auth/login_usecase.dart';
import 'package:barakah_pantry/domain/usecases/auth/signup_usecase.dart';
import 'package:barakah_pantry/domain/usecases/auth/logout_usecase.dart';
import 'package:barakah_pantry/domain/usecases/auth/check_auth_usecase.dart';
import 'package:barakah_pantry/domain/usecases/auth/reset_password_usecase.dart';

// Use Cases - User
import 'package:barakah_pantry/domain/usecases/user/get_profile_usecase.dart';
import 'package:barakah_pantry/domain/usecases/user/update_profile_usecase.dart';
import 'package:barakah_pantry/domain/usecases/user/delete_account_usecase.dart';

// Use Cases - Ingredient
import 'package:barakah_pantry/domain/usecases/ingredient/get_ingredients_usecase.dart';
import 'package:barakah_pantry/domain/usecases/ingredient/get_ingredient_detail_usecase.dart';
import 'package:barakah_pantry/domain/usecases/ingredient/search_ingredients_usecase.dart';
import 'package:barakah_pantry/domain/usecases/ingredient/get_ingredients_by_category_usecase.dart';
import 'package:barakah_pantry/domain/usecases/ingredient/get_featured_ingredient_usecase.dart';

// Use Cases - Recipe
import 'package:barakah_pantry/domain/usecases/recipe/get_recipes_usecase.dart';
import 'package:barakah_pantry/domain/usecases/recipe/get_recipe_detail_usecase.dart';
import 'package:barakah_pantry/domain/usecases/recipe/get_featured_recipes_usecase.dart';
import 'package:barakah_pantry/domain/usecases/recipe/search_recipes_usecase.dart';
import 'package:barakah_pantry/domain/usecases/recipe/get_recipes_by_category_usecase.dart';
import 'package:barakah_pantry/domain/usecases/recipe/rate_recipe_usecase.dart';

// Use Cases - AI
import 'package:barakah_pantry/domain/usecases/ai/generate_recipe_usecase.dart';
import 'package:barakah_pantry/domain/usecases/ai/save_generated_recipe_usecase.dart';
import 'package:barakah_pantry/domain/usecases/ai/get_sunnah_alternative_usecase.dart';

// Use Cases - Favorite
import 'package:barakah_pantry/domain/usecases/favorite/get_favorites_usecase.dart';
import 'package:barakah_pantry/domain/usecases/favorite/add_favorite_usecase.dart';
import 'package:barakah_pantry/domain/usecases/favorite/remove_favorite_usecase.dart';
import 'package:barakah_pantry/domain/usecases/favorite/check_favorite_usecase.dart';

// Use Cases - Daily Tip
import 'package:barakah_pantry/domain/usecases/daily_tip/get_today_tip_usecase.dart';
import 'package:barakah_pantry/domain/usecases/daily_tip/get_all_tips_usecase.dart';

// Use Cases - Cooking History
import 'package:barakah_pantry/domain/usecases/cooking_history/get_cooking_history_usecase.dart';
import 'package:barakah_pantry/domain/usecases/cooking_history/get_cooking_stats_usecase.dart';

// Controllers
import 'package:barakah_pantry/features/auth/presentation/controllers/auth_controller.dart';
import 'package:barakah_pantry/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:barakah_pantry/features/home/presentation/controllers/home_controller.dart';
import 'package:barakah_pantry/features/pantry/presentation/controllers/pantry_controller.dart';
import 'package:barakah_pantry/features/pantry/presentation/controllers/ingredient_detail_controller.dart';
import 'package:barakah_pantry/features/ai_recipe/presentation/controllers/ai_recipe_controller.dart';
import 'package:barakah_pantry/features/recipes/presentation/controllers/recipes_controller.dart';
import 'package:barakah_pantry/features/recipes/presentation/controllers/recipe_detail_controller.dart';
import 'package:barakah_pantry/features/favorites/presentation/controllers/favorites_controller.dart';
import 'package:barakah_pantry/features/daily_tips/presentation/controllers/daily_tips_controller.dart';
import 'package:barakah_pantry/features/profile/presentation/controllers/profile_controller.dart';
import 'package:barakah_pantry/features/profile/presentation/controllers/settings_controller.dart';
import 'package:barakah_pantry/features/search/presentation/controllers/search_controller.dart';
import 'package:barakah_pantry/features/navigation/presentation/controllers/navigation_controller.dart';
import 'package:barakah_pantry/features/progress/presentation/controllers/progress_controller.dart';

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(sharedPreferences);
  Get.put<FlutterSecureStorage>(const FlutterSecureStorage());
  Get.put<Connectivity>(Connectivity());

  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );

// Add this temporary check:
  try {
    final client = Supabase.instance.client;
    // Try to pick up the list of tables or a single public record
    await client.from('ingredients').select().limit(1);
    print('✅ Supabase Connection: SUCCESS');
  } catch (e) {
    print('❌ Supabase Connection: FAILED ($e)');
  }

  Get.put<SupabaseClient>(Supabase.instance.client);

  // Core
  Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(connectivity: Get.find()));

  // Datasources
  Get.lazyPut<GeminiDatasource>(() => GeminiDatasourceImpl());

  // Repositories
  Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find(), Get.find()));
  Get.lazyPut<UserRepository>(() => UserRepositoryImpl(Get.find()));
  Get.lazyPut<IngredientRepository>(() => IngredientRepositoryImpl(Get.find()));
  Get.lazyPut<RecipeRepository>(() => RecipeRepositoryImpl(Get.find()));
  Get.lazyPut<FavoriteRepository>(() => FavoriteRepositoryImpl(Get.find()));
  Get.lazyPut<DailyTipRepository>(() => DailyTipRepositoryImpl(Get.find()));
  Get.lazyPut<AIRepository>(() => AIRepositoryImpl(Get.find(), Get.find()));
  Get.lazyPut<CookingHistoryRepository>(
      () => CookingHistoryRepositoryImpl(Get.find()));

  // Use Cases
  // Auth
  Get.lazyPut(() => LoginUseCase(Get.find()));
  Get.lazyPut(() => SignupUseCase(Get.find()));
  Get.lazyPut(() => LogoutUseCase(Get.find()));
  Get.lazyPut(() => GetCurrentUserUseCase(Get.find()));
  Get.lazyPut(() => IsAuthenticatedUseCase(Get.find()));
  Get.lazyPut(() => ResetPasswordUseCase(Get.find()));

  // User
  Get.lazyPut(() => GetProfileUseCase(Get.find()));
  Get.lazyPut(() => UpdateProfileUseCase(Get.find()));
  Get.lazyPut(() => DeleteAccountUseCase(Get.find()));

  // Ingredient
  Get.lazyPut(() => GetIngredientsUseCase(Get.find()));
  Get.lazyPut(() => SearchIngredientsUseCase(Get.find()));
  Get.lazyPut(() => GetIngredientsByCategoryUseCase(Get.find()));
  Get.lazyPut(() => GetFeaturedIngredientUseCase(Get.find()));
  Get.lazyPut(() => GetIngredientDetailUseCase(Get.find()));

  // Recipe
  Get.lazyPut(() => GetRecipesUseCase(Get.find()));
  Get.lazyPut(() => SearchRecipesUseCase(Get.find()));
  Get.lazyPut(() => GetFeaturedRecipesUseCase(Get.find()));
  Get.lazyPut(() => GetRecipesByCategoryUseCase(Get.find()));
  Get.lazyPut(() => GetRecipeDetailUseCase(Get.find()));
  Get.lazyPut(() => RateRecipeUseCase(Get.find()));

  // AI
  Get.lazyPut(() => GenerateRecipeUseCase(Get.find()));
  Get.lazyPut(() => SaveGeneratedRecipeUseCase(Get.find()));
  Get.lazyPut(() => GetSunnahAlternativeUseCase(Get.find()));

  // Favorites
  Get.lazyPut(() => GetFavoritesUseCase(Get.find()));
  Get.lazyPut(() => AddFavoriteUseCase(Get.find()));
  Get.lazyPut(() => RemoveFavoriteUseCase(Get.find()));
  Get.lazyPut(() => CheckFavoriteUseCase(Get.find()));

  // Daily Tips
  Get.lazyPut(() => GetTodayTipUseCase(Get.find()));
  Get.lazyPut(() => GetAllTipsUseCase(Get.find()));

  // Cooking History
  Get.lazyPut(() => GetCookingHistoryUseCase(Get.find()));
  Get.lazyPut(() => GetCookingStatsUseCase(Get.find()));

  // Controllers
  Get.lazyPut(() => NavigationController(), fenix: true);
  Get.lazyPut(
      () => AuthController(
          Get.find(), Get.find(), Get.find(), Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut(() => OnboardingController(), fenix: true);
  Get.lazyPut(() => HomeController(Get.find(), Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut(() => PantryController(Get.find(), Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut(() => IngredientDetailController(Get.find()), fenix: true);
  Get.lazyPut(() => AIRecipeController(Get.find(), Get.find()), fenix: true);
  Get.lazyPut(() => RecipesController(Get.find(), Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut(
      () => RecipeDetailController(
          Get.find(), Get.find(), Get.find(), Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut(() => FavoritesController(Get.find(), Get.find()), fenix: true);
  Get.lazyPut(() => DailyTipsController(Get.find(), Get.find()), fenix: true);
  Get.lazyPut(() => ProfileController(Get.find(), Get.find()), fenix: true);
  Get.lazyPut(() => SettingsController(), fenix: true);
  Get.lazyPut(() => SearchController(Get.find(), Get.find()), fenix: true);
  Get.lazyPut(() => ProgressController(Get.find(), Get.find()), fenix: true);
}
