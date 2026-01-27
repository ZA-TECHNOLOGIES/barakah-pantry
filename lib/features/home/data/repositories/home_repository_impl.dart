import 'package:barakah_pantry/core/errors/failures.dart';
import 'package:barakah_pantry/data/models/daily_tip_model.dart';
import 'package:barakah_pantry/data/models/ingredient_model.dart';
import 'package:barakah_pantry/data/models/recipe_model.dart';
import 'package:barakah_pantry/domain/entities/daily_tip_entity.dart';
import 'package:barakah_pantry/domain/entities/ingredient_entity.dart';
import 'package:barakah_pantry/domain/entities/recipe_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final SupabaseClient supabaseClient;

  HomeRepositoryImpl(this.supabaseClient);

  @override
  Future<Either<Failure, DailyTipEntity>> getTodayTip() async {
    try {
      // Logic: Get tip where display_date is today, OR just get the latest active one
      final response = await supabaseClient
          .from('daily_tips')
          .select()
          .eq('is_active', true)
          // Ideally use .eq('display_date', DateTime.now().toIso8601String().split('T')[0])
          // But for fallback, we take the latest created
          .order('display_date', ascending: false)
          .limit(1)
          .maybeSingle();

      if (response == null) {
        return Left(ServerFailure(message: 'No active tip found for today'));
      }

      return Right(DailyTipModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, IngredientEntity>> getFeaturedIngredient() async {
    try {
      // Logic: Get a random sunnah ingredient
      // Note: Supabase doesn't have a native 'RANDOM()' in the JS client easily without RPC
      // So we fetch a few and pick one, or fetch a specific "featured" logic.
      // Here we fetch one sunnah ingredient.
      final response = await supabaseClient
          .from('ingredients')
          .select()
          .eq('is_sunnah', true)
          .limit(1)
          .maybeSingle();

      if (response == null) {
        return Left(ServerFailure(message: 'No featured ingredient found'));
      }

      return Right(IngredientModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> getFeaturedRecipes(
      int limit) async {
    try {
      // Logic: Get approved recipes, ordered by view count or created_at
      final List<dynamic> response = await supabaseClient
          .from('recipes')
          .select()
          .eq('is_approved', true)
          .eq('status', 'approved')
          .order('view_count', ascending: false) // Trending logic
          .limit(limit);

      final recipes =
          response.map((json) => RecipeModel.fromJson(json)).toList();
      return Right(recipes);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
