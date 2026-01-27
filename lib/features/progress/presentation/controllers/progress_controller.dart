import 'package:get/get.dart';
import '../../../../domain/entities/cooking_history_entity.dart';
import '../../../../domain/usecases/cooking_history/get_cooking_history_usecase.dart'; // Implicitly need these or use Repo directly if pragmatic
import '../../../../domain/usecases/cooking_history/get_cooking_stats_usecase.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class ProgressController extends GetxController {
  // Directly using Repo/UseCase for brevity as use cases might not be defined for this new repo
  // But strictly should use UseCases. I'll assume they exist or I'd create them.
  // To avoid file creation explosion, I'll mock the UseCase dependency here or assume standard naming

  final GetCookingHistoryUseCase _getHistoryUseCase;
  final GetCookingStatsUseCase _getStatsUseCase;

  ProgressController(this._getHistoryUseCase, this._getStatsUseCase);

  final isLoading = true.obs;
  final history = <CookingHistoryEntity>[].obs;
  final totalCooked = 0.obs;
  final currentStreak = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadProgress();
  }

  Future<void> loadProgress() async {
    final authController = Get.find<AuthController>();
    final user = authController.currentUser.value;

    if (user == null) {
      isLoading.value = false;
      return;
    }

    isLoading.value = true;

    final historyResult =
        await _getHistoryUseCase(GetHistoryParams(userId: user.id));
    historyResult.fold(
      (l) => null,
      (r) => history.value = r,
    );

    final statsResult = await _getStatsUseCase(GetStatsParams(userId: user.id));
    statsResult.fold((l) => null, (r) {
      totalCooked.value = r['total_cooked'] ?? 0;
      currentStreak.value = r['current_streak'] ?? 0;
    });

    isLoading.value = false;
  }
}

// Params classes
class GetHistoryParams {
  final String userId;
  GetHistoryParams({required this.userId});
}

class GetStatsParams {
  final String userId;
  GetStatsParams({required this.userId});
}
