import 'package:dartz/dartz.dart';
import 'package:barakah_pantry/core/errors/failures.dart';
import 'package:barakah_pantry/core/usecase/usecase.dart';
import '../../repositories/ingredient_repository.dart';
import '../../entities/ingredient_entity.dart';

class GetIngredientsByCategoryUseCase
    implements UseCase<List<IngredientEntity>, String> {
  final IngredientRepository repository;

  GetIngredientsByCategoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<IngredientEntity>>> call(String category) async {
    return await repository.getIngredientsByCategory(category);
  }
}
