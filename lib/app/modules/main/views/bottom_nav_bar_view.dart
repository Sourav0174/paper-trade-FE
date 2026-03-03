import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';

import 'package:paper_trade/app/modules/history/views/history_view.dart';
import 'package:paper_trade/app/modules/home/views/home_view.dart';
import 'package:paper_trade/app/modules/main/controllers/bottom_nav_bar_controller.dart';
import 'package:paper_trade/app/modules/portfolio/views/portfolio_view.dart';
import 'package:paper_trade/app/modules/subscription/views/subscription_view.dart';
import 'package:paper_trade/app/modules/trade/views/trade_view.dart';
import 'package:paper_trade/app/themes/app_theme.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final pages = [
      const HomeView(),
      const TradeView(),
      const PortfolioView(),
      const HistoryView(),
      const SubscriptionView(),
    ];

    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),

      bottomNavigationBar: Obx(
        () => MotionTabBar(
          initialSelectedTab: controller.tabs[controller.currentIndex.value],
          labels: controller.tabs,
          icons: const [
            Icons.home_rounded,
            Icons.candlestick_chart_rounded,
            Icons.pie_chart_rounded,
            Icons.history_rounded,
            Icons.workspace_premium_rounded,
          ],
          tabIconSize: 26.h,

          tabSize: 45.h,
          tabBarHeight: 50.h,
          textStyle: Theme.of(context).textTheme.labelSmall,

          tabIconColor: isDark
              ? AppColors.darkSecondaryText
              : AppColors.lightSecondaryText,
          tabIconSelectedColor: Colors.white,
          tabSelectedColor: isDark
              ? AppColors.darkPrimary
              : AppColors.lightPrimary,
          tabBarColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,

          onTabItemSelected: (index) {
            controller.changePage(index);
          },
        ),
      ),
    );
  }
}
