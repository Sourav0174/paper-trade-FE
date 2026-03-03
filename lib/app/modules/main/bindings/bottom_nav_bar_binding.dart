import 'package:get/get.dart';
import 'package:paper_trade/app/modules/history/controllers/history_controller.dart';
import 'package:paper_trade/app/modules/home/controllers/home_controller.dart';
import 'package:paper_trade/app/modules/main/controllers/bottom_nav_bar_controller.dart';
import 'package:paper_trade/app/modules/portfolio/controllers/portfolio_controller.dart';
import 'package:paper_trade/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:paper_trade/app/modules/trade/controllers/trade_controller.dart';

class BottomNavBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavBarController>(() => BottomNavBarController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<TradeController>(() => TradeController());
    Get.lazyPut<PortfolioController>(() => PortfolioController());
    Get.lazyPut<HistoryController>(() => HistoryController());
    Get.lazyPut<SubscriptionController>(() => SubscriptionController());
  }
}
