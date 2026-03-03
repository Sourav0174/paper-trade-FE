import 'package:get/get.dart';
import 'package:paper_trade/app/data/models/holding_model.dart';
import 'package:paper_trade/app/data/services/api_service.dart';

class PortfolioController extends GetxController {
  final ApiService _apiService = ApiService();

  final isLoading = false.obs;
  final holdings = <HoldingModel>[].obs;
  final currentValue = 124500.0.obs;
  final invested = 120300.0.obs;
  final todayPnl = 850.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadPortfolio();
  }

  Future<void> loadPortfolio() async {
    try {
      isLoading.value = true;
      final data = await _apiService.fetchPortfolio('user_1');
      holdings.value = data;
    } finally {
      isLoading.value = false;
    }
  }

  double get totalPnl => currentValue.value - invested.value;
  double get totalPnlPercent => (totalPnl / invested.value) * 100;
}
