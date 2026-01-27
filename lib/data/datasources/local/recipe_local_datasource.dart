import 'dart:convert';
import '../../../core/constants/storage_keys.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/services/storage/local_storage_service.dart';
import '../../models/recipe_model.dart';

/// Recipe Local Datasource Interface
abstract class RecipeLocalDatasource {
  /// Get cached recipes
  Future<List<RecipeModel>> getCachedRecipes();

  /// Cache recipes
  Future<void> cacheRecipes(List<RecipeModel> recipes);

  /// Get cached featured recipes
  Future<List<RecipeModel>> getCachedFeaturedRecipes();

  /// Cache featured recipes
  Future<void> cacheFeaturedRecipes(List<RecipeModel> recipes);

  /// Get last generated AI recipe
  Future<RecipeModel?> getLastGeneratedRecipe();

  /// Cache last generated AI recipe
  Future<void> cacheLastGeneratedRecipe(RecipeModel recipe);

  /// Clear all cached recipes
  Future<void> clearCache();

  /// Check if cache is valid
  bool isCacheValid();

  /// Get AI recipes used today
  int getAIRecipesUsedToday();

  /// Increment AI recipes used today
  Future<void> incrementAIRecipesUsed();

  /// Reset AI recipes counter (for new day)
  Future<void> resetAIRecipesCounter();

  /// Check if AI limit reached
  bool isAILimitReached();
}

/// Recipe Local Datasource Implementation
class RecipeLocalDatasourceImpl implements RecipeLocalDatasource {
  final LocalStorageService storage;

  RecipeLocalDatasourceImpl({required this.storage});

  //═══════════════════════════════════════════════════════════════
  // RECIPES CACHE
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<RecipeModel>> getCachedRecipes() async {
    try {
      final jsonString = storage.getString(StorageKeys.recipesCache);

      if (jsonString == null) {
        throw CacheException.notFound(StorageKeys.recipesCache);
      }

      if (!isCacheValid()) {
        throw CacheException.expired(StorageKeys.recipesCache);
      }

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => RecipeModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException.readError(e.toString());
    }
  }

  @override
  Future<void> cacheRecipes(List<RecipeModel> recipes) async {
    try {
      final jsonList = recipes.map((r) => r.toJson()).toList();
      final jsonString = jsonEncode(jsonList);

      await storage.setString(StorageKeys.recipesCache, jsonString);
      await storage.setString(
        StorageKeys.recipesCacheTime,
        DateTime.now().toIso8601String(),
      );
    } catch (e) {
      throw CacheException.writeError(e.toString());
    }
  }

  //═══════════════════════════════════════════════════════════════
  // FEATURED RECIPES CACHE
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<RecipeModel>> getCachedFeaturedRecipes() async {
    try {
      final jsonString = storage.getString(StorageKeys.featuredRecipesCache);

      if (jsonString == null) {
        throw CacheException.notFound(StorageKeys.featuredRecipesCache);
      }

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => RecipeModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException.readError(e.toString());
    }
  }

  @override
  Future<void> cacheFeaturedRecipes(List<RecipeModel> recipes) async {
    try {
      final jsonList = recipes.map((r) => r.toJson()).toList();
      final jsonString = jsonEncode(jsonList);

      await storage.setString(StorageKeys.featuredRecipesCache, jsonString);
    } catch (e) {
      throw CacheException.writeError(e.toString());
    }
  }

  //═══════════════════════════════════════════════════════════════
  // LAST GENERATED RECIPE
  //═══════════════════════════════════════════════════════════════

  @override
  Future<RecipeModel?> getLastGeneratedRecipe() async {
    try {
      final jsonString = storage.getString(StorageKeys.lastGeneratedRecipe);
      if (jsonString == null) return null;

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return RecipeModel.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheLastGeneratedRecipe(RecipeModel recipe) async {
    try {
      final jsonString = jsonEncode(recipe.toJson());
      await storage.setString(StorageKeys.lastGeneratedRecipe, jsonString);
    } catch (e) {
      throw CacheException.writeError(e.toString());
    }
  }

  //═══════════════════════════════════════════════════════════════
  // CLEAR CACHE
  //═══════════════════════════════════════════════════════════════

  @override
  Future<void> clearCache() async {
    await storage.remove(StorageKeys.recipesCache);
    await storage.remove(StorageKeys.recipesCacheTime);
    await storage.remove(StorageKeys.featuredRecipesCache);
  }

  //═══════════════════════════════════════════════════════════════
  // CACHE VALIDATION
  //═══════════════════════════════════════════════════════════════

  @override
  bool isCacheValid() {
    final timestampStr = storage.getString(StorageKeys.recipesCacheTime);
    if (timestampStr == null) return false;

    try {
      final timestamp = DateTime.parse(timestampStr);
      final now = DateTime.now();
      final difference = now.difference(timestamp);

      return difference < AppConstants.recipesCacheDuration;
    } catch (e) {
      return false;
    }
  }

  //═══════════════════════════════════════════════════════════════
  // AI RECIPES COUNTER
  //═══════════════════════════════════════════════════════════════

  @override
  int getAIRecipesUsedToday() {
    _checkAndResetCounterIfNewDay();
    return storage.getInt(StorageKeys.aiRecipesUsedToday) ?? 0;
  }

  @override
  Future<void> incrementAIRecipesUsed() async {
    _checkAndResetCounterIfNewDay();
    final current = getAIRecipesUsedToday();
    await storage.setInt(StorageKeys.aiRecipesUsedToday, current + 1);
    await storage.setString(
      StorageKeys.aiRecipesUsedDate,
      DateTime.now().toIso8601String().split('T')[0],
    );
  }

  @override
  Future<void> resetAIRecipesCounter() async {
    await storage.setInt(StorageKeys.aiRecipesUsedToday, 0);
    await storage.setString(
      StorageKeys.aiRecipesUsedDate,
      DateTime.now().toIso8601String().split('T')[0],
    );
  }

  @override
  bool isAILimitReached() {
    return getAIRecipesUsedToday() >= AppConstants.maxFreeAIRecipes;
  }

  void _checkAndResetCounterIfNewDay() {
    final lastDateStr = storage.getString(StorageKeys.aiRecipesUsedDate);
    final today = DateTime.now().toIso8601String().split('T')[0];

    if (lastDateStr != today) {
      // It's a new day, counter will be reset on next increment
      storage.setInt(StorageKeys.aiRecipesUsedToday, 0);
      storage.setString(StorageKeys.aiRecipesUsedDate, today);
    }
  }
}
