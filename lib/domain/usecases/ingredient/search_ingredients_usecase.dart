import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import 'package:barakah_pantry/core/usecase/usecase.dart';
import '../../repositories/ingredient_repository.dart';
import '../../entities/ingredient_entity.dart';

class SearchIngredientsUseCase
    implements UseCase<List<IngredientEntity>, SearchIngredientsParams> {
  final IngredientRepository repository;

  SearchIngredientsUseCase(this.repository);

  @override
  Future<Either<Failure, List<IngredientEntity>>> call(
      SearchIngredientsParams params) async {
    return await repository.searchIngredients(params.query);
  }
}

class SearchIngredientsParams extends Equatable {
  final String query;

  const SearchIngredientsParams({required this.query});

  @override
  List<Object?> get props => [query];
}
