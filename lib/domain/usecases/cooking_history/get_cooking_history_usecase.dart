import 'package:barakah_pantry/core/errors/failures.dart';
import 'package:barakah_pantry/domain/entities/cooking_history_entity.dart';
import 'package:barakah_pantry/domain/repositories/cooking_history_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../features/progress/presentation/controllers/progress_controller.dart'; // For Params

class GetCookingHistoryUseCase {
  final CookingHistoryRepository repository;
  GetCookingHistoryUseCase(this.repository);

  Future<Either<Failure, List<CookingHistoryEntity>>> call(
      GetHistoryParams params) async {
    return await repository.getHistory(params.userId);
  }
}
