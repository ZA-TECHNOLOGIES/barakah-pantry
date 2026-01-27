import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import '../../repositories/ingredient_repository.dart';
import '../../entities/ingredient_entity.dart';

class GetIngredientDetailUseCase
    implements UseCase<IngredientEntity, GetIngredientDetailParams> {
  final IngredientRepository repository;

  GetIngredientDetailUseCase(this.repository);

  @override
  Future<Either<Failure, IngredientEntity>> call(
      GetIngredientDetailParams params) async {
    return await repository.getIngredientById(params.id);
  }
}

class GetIngredientDetailParams extends Equatable {
  final String id;

  const GetIngredientDetailParams({required this.id});

  @override
  List<Object?> get props => [id];
}
