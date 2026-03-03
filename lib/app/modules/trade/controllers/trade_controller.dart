import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:paper_trade/app/data/api_provider.dart';
import 'package:paper_trade/app/data/models/stock_model.dart';

import '../../../data/api_constants.dart';

class TradeController extends GetxController {
  final APIProvider _apiProvider = APIProvider();

  final isLoading = false.obs;
  final stocks = <StockModel>[].obs;

  final selectedCategory = 'ALL'.obs;
  final searchQuery = ''.obs;

  final currentPage = 1.obs;
  final totalItems = 0.obs;
  final limit = 20;

  late Worker _debounce;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    loadStocks();
    _setupScrollListener();

    _debounce = debounce(
      searchQuery,
      (_) => loadStocks(isRefresh: true),
      time: const Duration(milliseconds: 500),
    );
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        _loadMore();
      }
    });
  }

  void _loadMore() {
    if (isLoading.value) return;

    if (stocks.length >= totalItems.value) return;

    currentPage.value++;
    loadStocks();
  }

  Future<void> loadStocks({bool isRefresh = false}) async {
    if (isLoading.value) return;
    try {
      if (isRefresh) {
        currentPage.value = 1;
        stocks.clear();
      }

      isLoading.value = true;

      final indexParam = selectedCategory.value == 'ALL'
          ? null
          : selectedCategory.value;

      final queryParams = {
        "page": currentPage.value,
        "limit": limit,
        if (indexParam != null) "index": indexParam,
        if (searchQuery.value.isNotEmpty) "search": searchQuery.value.trim(),
      };

      // final queryParams = {
      //   "page": currentPage.value,
      //   "limit": limit,
      //   if (indexParam != null) "index": indexParam,
      //   if (searchQuery.value.isNotEmpty) "search": searchQuery.value.trim(),
      // };

      log("📤 Stocks Request: $queryParams", name: "TRADE");

      final response = await _apiProvider.getAPICall(
        ApiConstants.marketStocks,
        header: {"Accept": "application/json"},
        queryParameters: queryParams,
      );

      final resData = response.data;

      log("📥 Stocks Response: $resData", name: "TRADE");

      // 🔥 EDGE CASE 1: Unexpected response
      if (resData == null || resData["data"] == null) {
        stocks.clear();
        return;
      }

      totalItems.value = resData["total"] ?? 0;

      final List dataList = resData["data"];

      final fetchedStocks = dataList
          .map((json) => StockModel.fromJson(json))
          .toList();

      if (isRefresh) {
        stocks.value = fetchedStocks;
      } else {
        stocks.addAll(fetchedStocks);
      }

      // 🔥 EDGE CASE 2: No results
      if (stocks.isEmpty) {
        Get.snackbar(
          "No Results",
          "No stocks found",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e, stack) {
      log("🔥 Stocks Error", name: "TRADE", error: e, stackTrace: stack);

      Get.snackbar(
        "Error",
        "Failed to load stocks",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    loadStocks(isRefresh: true);
  }

  void onSearch(String query) {
    searchQuery.value = query;
  }

  void showOrderSheet(StockModel stock) {
    Get.bottomSheet(
      TradeOrderSheet(stock: stock),
      isScrollControlled: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF0A0A0F) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
    );
  }
}

class TradeOrderSheet extends StatefulWidget {
  final StockModel stock;
  const TradeOrderSheet({super.key, required this.stock});
  @override
  State<TradeOrderSheet> createState() => _TradeOrderSheetState();
}

class _TradeOrderSheetState extends State<TradeOrderSheet> {
  int quantity = 1;
  String orderType = 'BUY';
  String productType = 'Intraday';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.stock.symbol,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₹${widget.stock.currentPrice}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => setState(() => orderType = 'BUY'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orderType == 'BUY'
                        ? const Color(0xFF4ADE80)
                        : Colors.grey,
                  ),
                  child: const Text('BUY'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => setState(() => orderType = 'SELL'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orderType == 'SELL'
                        ? const Color(0xFFFF3B3B)
                        : Colors.grey,
                  ),
                  child: const Text('SELL'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              IconButton(
                onPressed: () =>
                    setState(() => quantity = quantity > 1 ? quantity - 1 : 1),
                icon: const Icon(Icons.remove),
              ),
              Expanded(
                child: Text(
                  quantity.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => setState(() => quantity++),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
                Get.snackbar(
                  'Success',
                  '$orderType order placed for ${widget.stock.symbol}',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: const Color(0xFF4ADE80),
                  colorText: Colors.white,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066FF),
              ),
              child: Text('PLACE $orderType ORDER'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
