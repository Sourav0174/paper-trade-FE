import 'dart:developer';
import 'package:get/get.dart';

import 'package:paper_trade/app/data/api_provider.dart';
import 'package:paper_trade/app/data/models/market_index_model.dart';
import 'package:paper_trade/app/data/models/stock_model.dart';

import '../../../data/api_constants.dart';

class HomeController extends GetxController {
  final APIProvider _apiProvider = APIProvider();

  final isLoading = false.obs;
  final virtualBalance = 100000.0.obs;
  final todayPnl = 2450.0.obs;
  final todayPnlPercent = 2.45.obs;

  final marketIndices = <MarketIndexModel>[].obs;
  final topMovers = <StockModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMarketIndices();
  }

  // 🔥 FETCH MARKET INDICES FROM BACKEND
  Future<void> loadMarketIndices() async {
    try {
      isLoading.value = true;

      final headers = {"Accept": "application/json"};

      log("📤 Fetching Market Indices...", name: "HOME");

      final response = await _apiProvider.getAPICall(
        ApiConstants.marketIndexes,
        // headers,
      );

      final List data = response.data;

      log("📥 Market Indices Response: $data", name: "HOME");

      marketIndices.value = data
          .map((json) => MarketIndexModel.fromJson(json))
          .toList();
    } catch (e, stack) {
      log("🔥 Market Indices Error", name: "HOME", error: e, stackTrace: stack);

      Get.snackbar(
        "Error",
        "Failed to load market indices",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
