import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/cooking_history_entity.dart'; // verify existence or use recipe entity wrapper

abstract class CookingHistoryRepository {
  Future<Either<Failure, List<CookingHistoryEntity>>> getHistory(String userId);
  Future<Either<Failure, void>> addToHistory({
    required String userId,
    required String recipeId,
    String? notes,
    double? rating,
  });
  Future<Either<Failure, Map<String, dynamic>>> getCookingStats(String userId);
}
