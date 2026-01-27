import 'package:barakah_pantry/core/errors/failures.dart';
import 'package:barakah_pantry/core/usecase/usecase.dart';
import 'package:barakah_pantry/domain/entities/daily_tip_entity.dart';
import 'package:barakah_pantry/domain/repositories/daily_tip_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllTipsUseCase implements UseCase<List<DailyTipEntity>, NoParams> {
  final DailyTipRepository repository;

  GetAllTipsUseCase(this.repository);

  @override
  Future<Either<Failure, List<DailyTipEntity>>> call(NoParams params) async {
    return await repository.getAllTips();
  }
}
