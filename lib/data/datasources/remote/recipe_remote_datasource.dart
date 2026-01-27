import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/config/supabase_config.dart';
import '../../../core/errors/exceptions.dart';
import '../../models/recipe_model.dart';

/// Recipe Remote Datasource Interface
abstract class RecipeRemoteDatasource {
  /// Get all recipes
  Future<List<RecipeModel>> getRecipes({
    String? category,
    bool? isApproved,
    bool? isFeatured,
    String? userId,
    int? limit,
    int? offset,
  });

  /// Get recipe by ID
  Future<RecipeModel> getRecipeById(String id);

  /// Get recipe by slug
  Future<RecipeModel> getRecipeBySlug(String slug);

  /// Search recipes
  Future<List<RecipeModel>> searchRecipes(String query, {int? limit});

  /// Get featured recipes
  Future<List<RecipeModel>> getFeaturedRecipes({int? limit});

  /// Get recipes by category
  Future<List<RecipeModel>> getRecipesByCategory(String category, {int? limit});

  /// Get user's recipes
  Future<List<RecipeModel>> getUserRecipes(String userId);

  /// Create recipe
  Future<RecipeModel> createRecipe(RecipeModel recipe);

  /// Update recipe
  Future<RecipeModel> updateRecipe(String id, Map<String, dynamic> data);

  /// Delete recipe
  Future<void> deleteRecipe(String id);

  /// Increment view count
  Future<void> incrementViewCount(String id);

  /// Rate recipe
  Future<void> rateRecipe(String recipeId, String userId, int rating,
      {String? review});

  /// Get recipe rating
  Future<Map<String, dynamic>> getRecipeRating(String recipeId);
}

/// Recipe Remote Datasource Implementation
class RecipeRemoteDatasourceImpl implements RecipeRemoteDatasource {
  final SupabaseClient client;

  RecipeRemoteDatasourceImpl({required this.client});

  //═══════════════════════════════════════════════════════════════
  // GET RECIPES
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<RecipeModel>> getRecipes({
    String? category,
    bool? isApproved,
    bool? isFeatured,
    String? userId,
    int? limit,
    int? offset,
  }) async {
    try {
      dynamic query = client
          .from(SupabaseConfig.recipesTable)
          .select(SupabaseConfig.recipeWithDetailsQuery);

      // Apply filters
      if (category != null && category.toLowerCase() != 'all') {
        query = query.eq('category', category.toLowerCase());
      }

      if (isApproved != null) {
        query = query.eq('is_approved', isApproved);
      }

      if (isFeatured != null) {
        query = query.eq('is_featured', isFeatured);
      }

      if (userId != null) {
        query = query.eq('user_id', userId);
      }

      // Order by created_at descending
      query = query.order('created_at', ascending: false);

      // Apply pagination
      if (limit != null) {
        final start = offset ?? 0;
        query = query.range(start, start + limit - 1);
      }

      final response = await query;

      return (response as List)
          .map((json) => RecipeModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to fetch recipes',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // GET BY ID
  //═══════════════════════════════════════════════════════════════

  @override
  Future<RecipeModel> getRecipeById(String id) async {
    try {
      final response = await client
          .from(SupabaseConfig.recipesTable)
          .select(SupabaseConfig.recipeWithDetailsQuery)
          .eq('id', id)
          .single();

      return RecipeModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw NotFoundException.recipe(id);
      }
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ServerException(
        message: 'Failed to fetch recipe',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // GET BY SLUG
  //═══════════════════════════════════════════════════════════════

  @override
  Future<RecipeModel> getRecipeBySlug(String slug) async {
    try {
      final response = await client
          .from(SupabaseConfig.recipesTable)
          .select(SupabaseConfig.recipeWithDetailsQuery)
          .eq('slug', slug)
          .single();

      return RecipeModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw NotFoundException.recipe(slug);
      }
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ServerException(
        message: 'Failed to fetch recipe',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // SEARCH
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<RecipeModel>> searchRecipes(String query, {int? limit}) async {
    try {
      dynamic request = client
          .from(SupabaseConfig.recipesTable)
          .select(SupabaseConfig.recipeWithDetailsQuery)
          .eq('is_approved', true)
          .or('title.ilike.%$query%,description.ilike.%$query%')
          .order('created_at', ascending: false);

      if (limit != null) {
        request = request.limit(limit);
      }

      final response = await request;

      return (response as List)
          .map((json) => RecipeModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to search recipes',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // GET FEATURED
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<RecipeModel>> getFeaturedRecipes({int? limit}) async {
    return getRecipes(
      isApproved: true,
      isFeatured: true,
      limit: limit ?? 10,
    );
  }

  //═══════════════════════════════════════════════════════════════
  // GET BY CATEGORY
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<RecipeModel>> getRecipesByCategory(
    String category, {
    int? limit,
  }) async {
    return getRecipes(
      category: category,
      isApproved: true,
      limit: limit,
    );
  }

  //═══════════════════════════════════════════════════════════════
  // GET USER RECIPES
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<RecipeModel>> getUserRecipes(String userId) async {
    return getRecipes(userId: userId);
  }

  //═══════════════════════════════════════════════════════════════
  // CREATE RECIPE
  //═══════════════════════════════════════════════════════════════

  @override
  Future<RecipeModel> createRecipe(RecipeModel recipe) async {
    try {
      final data = recipe.toJson();
      data.remove('id'); // Let Supabase generate the ID

      final response = await client
          .from(SupabaseConfig.recipesTable)
          .insert(data)
          .select()
          .single();

      return RecipeModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to create recipe',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // UPDATE RECIPE
  //═══════════════════════════════════════════════════════════════

  @override
  Future<RecipeModel> updateRecipe(String id, Map<String, dynamic> data) async {
    try {
      data['updated_at'] = DateTime.now().toIso8601String();

      final response = await client
          .from(SupabaseConfig.recipesTable)
          .update(data)
          .eq('id', id)
          .select()
          .single();

      return RecipeModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to update recipe',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // DELETE RECIPE
  //═══════════════════════════════════════════════════════════════

  @override
  Future<void> deleteRecipe(String id) async {
    try {
      await client.from(SupabaseConfig.recipesTable).delete().eq('id', id);
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to delete recipe',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // INCREMENT VIEW COUNT
  //═══════════════════════════════════════════════════════════════

  @override
  Future<void> incrementViewCount(String id) async {
    try {
      await client.rpc('increment_recipe_view', params: {'recipe_id': id});
    } catch (e) {
      // Silently fail - view count is not critical
    }
  }

  //═══════════════════════════════════════════════════════════════
  // RATINGS
  //═══════════════════════════════════════════════════════════════

  @override
  Future<void> rateRecipe(
    String recipeId,
    String userId,
    int rating, {
    String? review,
  }) async {
    try {
      await client.from(SupabaseConfig.recipeRatingsTable).upsert({
        'recipe_id': recipeId,
        'user_id': userId,
        'rating': rating,
        'review': review,
      });
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to rate recipe',
        originalError: e,
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getRecipeRating(String recipeId) async {
    try {
      final response = await client.rpc(
        'get_recipe_rating',
        params: {'recipe_uuid': recipeId},
      );

      if (response is List && response.isNotEmpty) {
        return response.first as Map<String, dynamic>;
      }

      return {'average_rating': 0.0, 'total_ratings': 0};
    } catch (e) {
      return {'average_rating': 0.0, 'total_ratings': 0};
    }
  }
}
