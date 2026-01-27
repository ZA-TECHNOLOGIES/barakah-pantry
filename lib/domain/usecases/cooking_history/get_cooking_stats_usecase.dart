import 'package:barakah_pantry/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../features/progress/presentation/controllers/progress_controller.dart';
import '../../repositories/cooking_history_repository.dart'; // For Params

class GetCookingStatsUseCase {
  final CookingHistoryRepository repository;
  GetCookingStatsUseCase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> call(
      GetStatsParams params) async {
    return await repository.getCookingStats(params.userId);
  }
}
