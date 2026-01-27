import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../core/errors/failures.dart';
import '../../domain/entities/daily_tip_entity.dart';
import '../../domain/repositories/daily_tip_repository.dart';
import '../models/daily_tip_model.dart';
import 'dart:math';

class DailyTipRepositoryImpl implements DailyTipRepository {
  final supabase.SupabaseClient _supabaseClient;

  DailyTipRepositoryImpl(this._supabaseClient);

  DailyTipEntity? _cachedTodaysTip;
  // ignore: unused_field
  DateTime? _cachedDate;

  @override
  Future<Either<Failure, DailyTipEntity>> getTodayTip() async {
    if (_cachedTodaysTip != null) {
      return Right(_cachedTodaysTip!);
    }

    try {
      final todayStr = DateTime.now().toIso8601String().split('T').first;
      var response = await _supabaseClient
          .from('daily_tips')
          .select()
          .eq('date_for', todayStr)
          .maybeSingle();

      if (response == null) {
        final allResponse =
            await _supabaseClient.from('daily_tips').select().limit(20);

        if ((allResponse as List).isNotEmpty) {
          final random = Random();
          response = allResponse[random.nextInt(allResponse.length)];
        }
      }

      if (response == null) {
        return Left(const ServerFailure(message: 'No tips available'));
      }

      final tip = DailyTipModel.fromJson(response);
      _cachedTodaysTip = tip;
      _cachedDate = DateTime.now();
      return Right(tip);
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DailyTipEntity>>> getAllTips({int? limit}) async {
    try {
      dynamic query = _supabaseClient.from('daily_tips').select();

      if (limit != null) {
        query = query.limit(limit);
      }

      final response = await query.order('created_at', ascending: false);

      final tips = (response as List)
          .map((json) => DailyTipModel.fromJson(json))
          .toList();

      return Right(tips);
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DailyTipEntity>> getTipByDate(DateTime date) async {
    try {
      final dateStr = date.toIso8601String().split('T').first;
      final response = await _supabaseClient
          .from('daily_tips')
          .select()
          .eq('date_for', dateStr)
          .single();

      return Right(DailyTipModel.fromJson(response));
    } on supabase.PostgrestException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DailyTipEntity>> getRandomTip() async {
    return getTodayTip();
  }
}
