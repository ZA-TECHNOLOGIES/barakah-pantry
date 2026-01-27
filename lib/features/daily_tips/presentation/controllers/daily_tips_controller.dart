import 'package:get/get.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../domain/entities/daily_tip_entity.dart';
import '../../../../domain/usecases/daily_tip/get_today_tip_usecase.dart';
import '../../../../domain/usecases/daily_tip/get_all_tips_usecase.dart';

class DailyTipsController extends GetxController {
  final GetTodayTipUseCase _getTodayTipUseCase;
  final GetAllTipsUseCase _getAllTipsUseCase;

  DailyTipsController(
    this._getTodayTipUseCase,
    this._getAllTipsUseCase,
  );

  final isLoading = true.obs;
  final todaysTip = Rx<DailyTipEntity?>(null);
  final allTips = <DailyTipEntity>[].obs;
  final errorMessage = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    errorMessage.value = null;

    final todayResult = await _getTodayTipUseCase(const NoParams());
    todayResult.fold(
      (l) => errorMessage.value = _mapFailureToMessage(l),
      (r) => todaysTip.value = r,
    );

    final allResult = await _getAllTipsUseCase(const NoParams());
    allResult.fold(
      (l) => null, // Non-critical
      (r) => allTips.value = r,
    );

    isLoading.value = false;
  }

  void shareTip(DailyTipEntity tip) {
    // Implement share logic
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) return failure.message;
    return 'Unexpected error occurred';
  }
}
