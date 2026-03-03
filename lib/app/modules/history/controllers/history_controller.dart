import 'package:get/get.dart';
import 'package:paper_trade/app/data/models/trade_model.dart';
import 'package:paper_trade/app/data/services/api_service.dart';

class HistoryController extends GetxController {
  final ApiService _apiService = ApiService();

  final isLoading = false.obs;
  final trades = <TradeModel>[].obs;
  final selectedFilter = 'All Trades'.obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory() async {
    try {
      isLoading.value = true;
      final data = await _apiService.fetchTradeHistory(
        'user_1',
        filter: selectedFilter.value == 'All Trades'
            ? null
            : selectedFilter.value,
      );
      trades.value = data;
    } finally {
      isLoading.value = false;
    }
  }

  void selectFilter(String filter) {
    selectedFilter.value = filter;
    loadHistory();
  }
}
