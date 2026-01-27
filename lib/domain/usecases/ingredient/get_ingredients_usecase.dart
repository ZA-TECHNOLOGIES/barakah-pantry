import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import '../../repositories/ingredient_repository.dart';
import '../../entities/ingredient_entity.dart';

class GetIngredientsUseCase
    implements UseCase<List<IngredientEntity>, GetIngredientsParams> {
  final IngredientRepository repository;

  GetIngredientsUseCase(this.repository);

  @override
  Future<Either<Failure, List<IngredientEntity>>> call(
      GetIngredientsParams params) async {
    return await repository.getIngredients(
      category: params.category,
      isSunnah: params.isSunnah,
    );
  }
}

class GetIngredientsParams extends Equatable {
  final String? category;
  final bool? isSunnah;

  const GetIngredientsParams({this.category, this.isSunnah});

  @override
  List<Object?> get props => [category, isSunnah];
}
