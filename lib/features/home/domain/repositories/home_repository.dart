import 'package:dartz/dartz.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import 'package:barakah_pantry/domain/entities/daily_tip_entity.dart';
import 'package:barakah_pantry/domain/entities/ingredient_entity.dart';
import 'package:barakah_pantry/domain/entities/recipe_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, DailyTipEntity>> getTodayTip();
  Future<Either<Failure, IngredientEntity>> getFeaturedIngredient();
  Future<Either<Failure, List<RecipeEntity>>> getFeaturedRecipes(int limit);
}
