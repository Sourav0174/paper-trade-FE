import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:paper_trade/app/data/models/stock_model.dart';
import 'package:paper_trade/app/data/models/market_index_model.dart';
import 'package:paper_trade/app/data/models/holding_model.dart';
import 'package:paper_trade/app/data/models/trade_model.dart';
import 'package:paper_trade/app/data/models/user_model.dart';
import 'package:paper_trade/app/data/dummy/dummy_data.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://mock-api.papertrade.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  Future<T> _mockApiCall<T>(Future<T> Function() callback) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return await callback();
    } catch (e) {
      debugPrint('API Error: $e');
      rethrow;
    }
  }

  Future<List<StockModel>> fetchStocks({String? category}) async {
    return _mockApiCall(() async {
      debugPrint('Fetching stocks for category: ${category ?? "All"}');
      if (category == null || category == 'All Stocks') {
        return DummyData.stocks;
      }
      return DummyData.stocks.where((s) => s.category == category).toList();
    });
  }

  Future<List<MarketIndexModel>> fetchMarketIndices() async {
    return _mockApiCall(() async {
      debugPrint('Fetching market indices');
      return DummyData.marketIndices;
    });
  }

  Future<List<HoldingModel>> fetchPortfolio(String userId) async {
    return _mockApiCall(() async {
      debugPrint('Fetching portfolio for user: $userId');
      return DummyData.getHoldings();
    });
  }

  Future<List<TradeModel>> fetchTradeHistory(
    String userId, {
    String? filter,
  }) async {
    return _mockApiCall(() async {
      debugPrint(
        'Fetching trade history for user: $userId, filter: ${filter ?? "All"}',
      );
      final trades = DummyData.getTrades(userId);
      if (filter == null || filter == 'All Trades') {
        return trades;
      }
      return trades
          .where((t) => t.type.toUpperCase() == filter.toUpperCase())
          .toList();
    });
  }

  Future<UserModel> authenticateUser(String email, String password) async {
    return _mockApiCall(() async {
      debugPrint('Authenticating user: $email');
      await Future.delayed(const Duration(seconds: 1));
      final now = DateTime.now();
      return UserModel(
        id: 'user_${email.hashCode}',
        name: 'Arjun Sharma',
        email: email,
        phone: '+91 98765 43210',
        isPremium: false,
        virtualBalance: 100000.0,
        createdAt: now,
        updatedAt: now,
      );
    });
  }

  Future<bool> verifyOtp(String phone, String otp) async {
    return _mockApiCall(() async {
      debugPrint('Verifying OTP for: $phone');
      await Future.delayed(const Duration(seconds: 1));
      return otp == '482' || otp.length == 6;
    });
  }

  Future<Map<String, dynamic>> placeTrade(
    String userId,
    String symbol,
    String type,
    int quantity,
    double price,
  ) async {
    return _mockApiCall(() async {
      debugPrint('Placing $type order: $symbol x $quantity @ ₹$price');
      await Future.delayed(const Duration(milliseconds: 800));
      return {
        'success': true,
        'orderId': 'ORD${DateTime.now().millisecondsSinceEpoch}',
        'message': 'Order placed successfully',
      };
    });
  }
}
