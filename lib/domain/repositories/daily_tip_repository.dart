import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/daily_tip_entity.dart';

/// Daily Tip Repository
/// Repository for daily tip operations
abstract class DailyTipRepository {
  /// Get today's tip
  Future<Either<Failure, DailyTipEntity>> getTodayTip();

  /// Get tip by date
  Future<Either<Failure, DailyTipEntity>> getTipByDate(DateTime date);

  /// Get all tips (for archive)
  Future<Either<Failure, List<DailyTipEntity>>> getAllTips({int? limit});

  /// Get random tip
  Future<Either<Failure, DailyTipEntity>> getRandomTip();
}
