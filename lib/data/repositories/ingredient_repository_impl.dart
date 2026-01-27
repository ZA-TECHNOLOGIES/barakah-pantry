import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../core/errors/failures.dart';
import '../../domain/entities/ingredient_entity.dart';
import '../../domain/repositories/ingredient_repository.dart';
import '../models/ingredient_model.dart';

class IngredientRepositoryImpl implements IngredientRepository {
  final supabase.SupabaseClient _supabaseClient;

  IngredientRepositoryImpl(this._supabaseClient);

  @override
  Future<Either<Failure, List<IngredientEntity>>> getIngredients({
    String? category,
    bool? isSunnah,
  }) async {
    try {
      var query = _supabaseClient
          .from('ingredients')
          .select('*, quran_references(*), hadith_references(*)');

      if (category != null && category != 'All') {
        query = query.eq('category', category);
      }

      if (isSunnah != null) {
        query = query.eq('is_sunnah', isSunnah);
      }

      final response = await query.order('name');

      final ingredients = (response as List)
          .map((json) => IngredientModel.fromJson(json))
          .toList();

      return Right(ingredients);
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, IngredientEntity>> getIngredientById(String id) async {
    try {
      final response = await _supabaseClient
          .from('ingredients')
          .select('*, quran_references(*), hadith_references(*)')
          .eq('id', id)
          .single();

      return Right(IngredientModel.fromJson(response));
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, IngredientEntity>> getIngredientBySlug(
      String slug) async {
    try {
      final response = await _supabaseClient
          .from('ingredients')
          .select('*, quran_references(*), hadith_references(*)')
          .eq('slug', slug)
          .single();

      return Right(IngredientModel.fromJson(response));
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<IngredientEntity>>> searchIngredients(
      String query) async {
    try {
      final response = await _supabaseClient
          .from('ingredients')
          .select('*, quran_references(*), hadith_references(*)')
          .ilike('name', '%$query%')
          .order('name');

      final ingredients = (response as List)
          .map((json) => IngredientModel.fromJson(json))
          .toList();

      return Right(ingredients);
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<IngredientEntity>>> getIngredientsByCategory(
      String category) async {
    return getIngredients(category: category);
  }

  @override
  Future<Either<Failure, IngredientEntity>> getFeaturedIngredient() async {
    try {
      final response = await _supabaseClient
          .from('ingredients')
          .select('*, quran_references(*), hadith_references(*)')
          .eq('is_sunnah', true)
          .limit(1)
          .maybeSingle();

      if (response == null) {
        final list = await getIngredients(isSunnah: true);
        return list.fold(
            (l) => Left(l),
            (r) => r.isNotEmpty
                ? Right(r.first)
                : Left(ServerFailure(message: "No featured ingredient found")));
      }

      return Right(IngredientModel.fromJson(response));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, IngredientEntity>> getRandomSunnahIngredient() async {
    try {
      final response = await _supabaseClient
          .from('ingredients')
          .select('*, quran_references(*), hadith_references(*)')
          .eq('is_sunnah', true)
          .limit(10);

      final list = (response as List)
          .map((json) => IngredientModel.fromJson(json))
          .toList();
      if (list.isEmpty)
        return Left(ServerFailure(message: 'No Sunnah ingredients found'));

      list.shuffle();
      return Right(list.first);
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
