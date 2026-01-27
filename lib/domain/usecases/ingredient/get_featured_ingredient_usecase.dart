import 'package:barakah_pantry/core/errors/failures.dart';
import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:barakah_pantry/domain/entities/ingredient_entity.dart';
import 'package:barakah_pantry/domain/repositories/ingredient_repository.dart';
import 'package:dartz/dartz.dart';

class GetFeaturedIngredientUseCase
    implements UseCase<IngredientEntity, NoParams> {
  final IngredientRepository repository;
  GetFeaturedIngredientUseCase(this.repository);

  @override
  Future<Either<Failure, IngredientEntity>> call(NoParams params) async {
    return await repository.getFeaturedIngredient();
  }
}
