import 'dart:convert';
import '../../../core/constants/storage_keys.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/errors/exceptions.dart';
import '../../../core/services/storage/local_storage_service.dart';
import '../../models/ingredient_model.dart';

/// Ingredient Local Datasource Interface
abstract class IngredientLocalDatasource {
  /// Get cached ingredients
  Future<List<IngredientModel>> getCachedIngredients();

  /// Cache ingredients
  Future<void> cacheIngredients(List<IngredientModel> ingredients);

  /// Get cached ingredient by ID
  Future<IngredientModel?> getCachedIngredientById(String id);

  /// Clear cached ingredients
  Future<void> clearCache();

  /// Check if cache is valid
  bool isCacheValid();

  /// Get cache timestamp
  DateTime? getCacheTimestamp();
}

/// Ingredient Local Datasource Implementation
class IngredientLocalDatasourceImpl implements IngredientLocalDatasource {
  final LocalStorageService storage;

  IngredientLocalDatasourceImpl({required this.storage});

  //═══════════════════════════════════════════════════════════════
  // GET CACHED INGREDIENTS
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<IngredientModel>> getCachedIngredients() async {
    try {
      final jsonString = storage.getString(StorageKeys.ingredientsCache);

      if (jsonString == null) {
        throw CacheException.notFound(StorageKeys.ingredientsCache);
      }

      if (!isCacheValid()) {
        throw CacheException.expired(StorageKeys.ingredientsCache);
      }

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => IngredientModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException.readError(e.toString());
    }
  }

  //═══════════════════════════════════════════════════════════════
  // CACHE INGREDIENTS
  //═══════════════════════════════════════════════════════════════

  @override
  Future<void> cacheIngredients(List<IngredientModel> ingredients) async {
    try {
      final jsonList = ingredients.map((i) => i.toJson()).toList();
      final jsonString = jsonEncode(jsonList);

      await storage.setString(StorageKeys.ingredientsCache, jsonString);
      await storage.setString(
        StorageKeys.ingredientsCacheTime,
        DateTime.now().toIso8601String(),
      );
    } catch (e) {
      throw CacheException.writeError(e.toString());
    }
  }

  //═══════════════════════════════════════════════════════════════
  // GET BY ID
  //═══════════════════════════════════════════════════════════════

  @override
  Future<IngredientModel?> getCachedIngredientById(String id) async {
    try {
      final ingredients = await getCachedIngredients();
      return ingredients.firstWhere(
        (i) => i.id == id,
        orElse: () => throw NotFoundException.ingredient(id),
      );
    } on NotFoundException {
      return null;
    } on CacheException {
      return null;
    }
  }

  //═══════════════════════════════════════════════════════════════
  // CLEAR CACHE
  //═══════════════════════════════════════════════════════════════

  @override
  Future<void> clearCache() async {
    await storage.remove(StorageKeys.ingredientsCache);
    await storage.remove(StorageKeys.ingredientsCacheTime);
  }

  //═══════════════════════════════════════════════════════════════
  // CACHE VALIDATION
  //═══════════════════════════════════════════════════════════════

  @override
  bool isCacheValid() {
    final timestamp = getCacheTimestamp();
    if (timestamp == null) return false;

    final now = DateTime.now();
    final difference = now.difference(timestamp);

    return difference < AppConstants.ingredientsCacheDuration;
  }

  @override
  DateTime? getCacheTimestamp() {
    final timestampStr = storage.getString(StorageKeys.ingredientsCacheTime);
    if (timestampStr == null) return null;

    try {
      return DateTime.parse(timestampStr);
    } catch (e) {
      return null;
    }
  }
}
