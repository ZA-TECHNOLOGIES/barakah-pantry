import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/config/supabase_config.dart';
import '../../../core/errors/exceptions.dart';
import '../../models/ingredient_model.dart';

/// Ingredient Remote Datasource Interface
abstract class IngredientRemoteDatasource {
  /// Get all ingredients
  Future<List<IngredientModel>> getIngredients({
    String? category,
    bool? isSunnah,
    int? limit,
    int? offset,
  });

  /// Get ingredient by ID
  Future<IngredientModel> getIngredientById(String id);

  /// Get ingredient by slug
  Future<IngredientModel> getIngredientBySlug(String slug);

  /// Search ingredients
  Future<List<IngredientModel>> searchIngredients(String query, {int? limit});

  /// Get ingredients by category
  Future<List<IngredientModel>> getIngredientsByCategory(String category);

  /// Get Sunnah ingredients only
  Future<List<IngredientModel>> getSunnahIngredients();

  /// Get ingredient categories
  Future<List<String>> getCategories();
}

/// Ingredient Remote Datasource Implementation
class IngredientRemoteDatasourceImpl implements IngredientRemoteDatasource {
  final SupabaseClient client;

  IngredientRemoteDatasourceImpl({required this.client});

  //═══════════════════════════════════════════════════════════════
  // GET INGREDIENTS
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<IngredientModel>> getIngredients({
    String? category,
    bool? isSunnah,
    int? limit,
    int? offset,
  }) async {
    try {
      dynamic query = client
          .from(SupabaseConfig.ingredientsTable)
          .select(SupabaseConfig.ingredientWithReferencesQuery);

      // Apply filters
      if (category != null && category.toLowerCase() != 'all') {
        query = query.eq('category', category.toLowerCase());
      }

      if (isSunnah != null) {
        query = query.eq('is_sunnah', isSunnah);
      }

      // Apply ordering
      query = query.order('name');

      // Apply pagination
      if (limit != null) {
        final start = offset ?? 0;
        query = query.range(start, start + limit - 1);
      }

      final response = await query;

      return (response as List)
          .map((json) => IngredientModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to fetch ingredients',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // GET BY ID
  //═══════════════════════════════════════════════════════════════

  @override
  Future<IngredientModel> getIngredientById(String id) async {
    try {
      final response = await client
          .from(SupabaseConfig.ingredientsTable)
          .select(SupabaseConfig.ingredientWithReferencesQuery)
          .eq('id', id)
          .single();

      return IngredientModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw NotFoundException.ingredient(id);
      }
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ServerException(
        message: 'Failed to fetch ingredient',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // GET BY SLUG
  //═══════════════════════════════════════════════════════════════

  @override
  Future<IngredientModel> getIngredientBySlug(String slug) async {
    try {
      final response = await client
          .from(SupabaseConfig.ingredientsTable)
          .select(SupabaseConfig.ingredientWithReferencesQuery)
          .eq('slug', slug)
          .single();

      return IngredientModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw NotFoundException.ingredient(slug);
      }
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ServerException(
        message: 'Failed to fetch ingredient',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // SEARCH
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<IngredientModel>> searchIngredients(
    String query, {
    int? limit,
  }) async {
    try {
      dynamic request = client
          .from(SupabaseConfig.ingredientsTable)
          .select(SupabaseConfig.ingredientWithReferencesQuery)
          .or('name.ilike.%$query%,name_arabic.ilike.%$query%')
          .order('name');

      if (limit != null) {
        request = request.limit(limit);
      }

      final response = await request;

      return (response as List)
          .map((json) => IngredientModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to search ingredients',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // GET BY CATEGORY
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<IngredientModel>> getIngredientsByCategory(
      String category) async {
    return getIngredients(category: category);
  }

  //═══════════════════════════════════════════════════════════════
  // GET SUNNAH INGREDIENTS
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<IngredientModel>> getSunnahIngredients() async {
    return getIngredients(isSunnah: true);
  }

  //═══════════════════════════════════════════════════════════════
  // GET CATEGORIES
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<String>> getCategories() async {
    try {
      final response = await client
          .from(SupabaseConfig.ingredientsTable)
          .select('category')
          .order('category');

      final categories = (response as List)
          .map((item) => item['category'] as String)
          .toSet()
          .toList();

      return categories;
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to fetch categories',
        originalError: e,
      );
    }
  }
}
