import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/config/supabase_config.dart';
import '../../../core/errors/exceptions.dart';
import '../../models/daily_tip_model.dart';

/// Daily Tip Remote Datasource Interface
abstract class DailyTipRemoteDatasource {
  /// Get today's tip
  Future<DailyTipModel?> getTodayTip();

  /// Get all tips
  Future<List<DailyTipModel>> getAllTips({int? limit, int? offset});

  /// Get tip by ID
  Future<DailyTipModel> getTipById(String id);

  /// Get tips by date range
  Future<List<DailyTipModel>> getTipsByDateRange(
    DateTime startDate,
    DateTime endDate,
  );
}

/// Daily Tip Remote Datasource Implementation
class DailyTipRemoteDatasourceImpl implements DailyTipRemoteDatasource {
  final SupabaseClient client;

  DailyTipRemoteDatasourceImpl({required this.client});

  //═══════════════════════════════════════════════════════════════
  // GET TODAY'S TIP
  //═══════════════════════════════════════════════════════════════

  @override
  Future<DailyTipModel?> getTodayTip() async {
    try {
      final today = DateTime.now().toIso8601String().split('T')[0];

      final response = await client
          .from(SupabaseConfig.dailyTipsTable)
          .select(SupabaseConfig.dailyTipWithIngredientQuery)
          .eq('display_date', today)
          .eq('is_active', true)
          .maybeSingle();

      if (response == null) {
        // If no tip for today, get the most recent one
        final fallbackResponse = await client
            .from(SupabaseConfig.dailyTipsTable)
            .select(SupabaseConfig.dailyTipWithIngredientQuery)
            .eq('is_active', true)
            .order('display_date', ascending: false)
            .limit(1)
            .maybeSingle();

        if (fallbackResponse == null) return null;
        return DailyTipModel.fromJson(fallbackResponse);
      }

      return DailyTipModel.fromJson(response);
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to fetch today\'s tip',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // GET ALL TIPS
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<DailyTipModel>> getAllTips({int? limit, int? offset}) async {
    try {
      var query = client
          .from(SupabaseConfig.dailyTipsTable)
          .select(SupabaseConfig.dailyTipWithIngredientQuery)
          .eq('is_active', true)
          .order('display_date', ascending: false);

      if (limit != null) {
        final start = offset ?? 0;
        query = query.range(start, start + limit - 1);
      }

      final response = await query;

      return (response as List)
          .map((json) => DailyTipModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to fetch daily tips',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // GET BY ID
  //═══════════════════════════════════════════════════════════════

  @override
  Future<DailyTipModel> getTipById(String id) async {
    try {
      final response = await client
          .from(SupabaseConfig.dailyTipsTable)
          .select(SupabaseConfig.dailyTipWithIngredientQuery)
          .eq('id', id)
          .single();

      return DailyTipModel.fromJson(response);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        throw NotFoundException(
          message: 'Daily tip not found',
          code: 'TIP_NOT_FOUND',
        );
      }
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw ServerException(
        message: 'Failed to fetch daily tip',
        originalError: e,
      );
    }
  }

  //═══════════════════════════════════════════════════════════════
  // GET BY DATE RANGE
  //═══════════════════════════════════════════════════════════════

  @override
  Future<List<DailyTipModel>> getTipsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final start = startDate.toIso8601String().split('T')[0];
      final end = endDate.toIso8601String().split('T')[0];

      final response = await client
          .from(SupabaseConfig.dailyTipsTable)
          .select(SupabaseConfig.dailyTipWithIngredientQuery)
          .eq('is_active', true)
          .gte('display_date', start)
          .lte('display_date', end)
          .order('display_date', ascending: false);

      return (response as List)
          .map((json) => DailyTipModel.fromJson(json))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(
        message: e.message,
        code: e.code,
        originalError: e,
      );
    } catch (e) {
      throw ServerException(
        message: 'Failed to fetch daily tips',
        originalError: e,
      );
    }
  }
}
