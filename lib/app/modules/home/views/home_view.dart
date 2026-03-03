import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paper_trade/app/data/local_storage.dart';
import 'package:paper_trade/app/modules/home/controllers/home_controller.dart';
import 'package:paper_trade/app/routes/app_pages.dart';

import 'package:intl/intl.dart';
import 'package:paper_trade/app/themes/app_theme.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currencyFormat = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    );

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      body: SafeArea(
        child: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(24.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Namaste, Trader',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: isDark
                                            ? AppColors.darkSecondaryText
                                            : AppColors.lightSecondaryText,
                                      ),
                                ),
                                Text(
                                  LocalStorage.getUserName().toString(),
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(
                                        color: isDark
                                            ? AppColors.darkPrimaryText
                                            : AppColors.lightPrimaryText,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ],
                            ),
                            Container(
                              width: 44.w,
                              height: 44.h,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.darkSurface
                                    : AppColors.lightSurface,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: isDark
                                      ? AppColors.darkDivider
                                      : AppColors.lightDivider,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.notifications_none_rounded,
                                      color: isDark
                                          ? AppColors.darkPrimaryText
                                          : AppColors.lightPrimaryText,
                                      size: 24.sp,
                                    ),
                                  ),
                                  Positioned(
                                    right: 8.w,
                                    top: 8.h,
                                    child: Container(
                                      width: 8.w,
                                      height: 8.h,
                                      decoration: const BoxDecoration(
                                        color: AppColors.lightError,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 24.w,
                        ).copyWith(bottom: 24.h),
                        padding: EdgeInsets.all(32.w),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(0, 95, 255, 108),
                              Color(0xFF1A1A1A),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.lightPrimary.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_rounded,
                                  color: Colors.white.withValues(alpha: 0.8),
                                  size: 16.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'TOTAL VIRTUAL BALANCE',
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: Colors.white.withValues(
                                          alpha: 0.8,
                                        ),
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              currencyFormat.format(
                                controller.virtualBalance.value,
                              ),
                              style: Theme.of(context).textTheme.headlineLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward_rounded,
                                      color: AppColors.lightSuccess,
                                      size: 14.sp,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      '${currencyFormat.format(controller.todayPnl.value)} Today',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: AppColors.lightSuccess,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 16.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.13),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    '+${controller.todayPnlPercent.value}%',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Market Indices',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                        color: isDark
                                            ? AppColors.darkPrimaryText
                                            : AppColors.lightPrimaryText,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                Text(
                                  'View Markets',
                                  style: Theme.of(context).textTheme.labelLarge
                                      ?.copyWith(color: AppColors.lightPrimary),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          SizedBox(
                            height: 100.h,
                            child: ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.marketIndices.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(width: 16.w),
                              itemBuilder: (context, index) {
                                final market = controller.marketIndices[index];
                                return Container(
                                  width: 160.w,
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? AppColors.darkSurface
                                        : AppColors.lightSurface,
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: isDark
                                          ? AppColors.darkDivider
                                          : AppColors.lightDivider,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.05,
                                        ),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        market.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                              color: isDark
                                                  ? AppColors.darkSecondaryText
                                                  : AppColors
                                                        .lightSecondaryText,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      Text(
                                        NumberFormat(
                                          '#,##0.00',
                                        ).format(market.value),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: isDark
                                                  ? AppColors.darkPrimaryText
                                                  : AppColors.lightPrimaryText,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            market.isUp
                                                ? Icons.trending_up_rounded
                                                : Icons.trending_down_rounded,
                                            size: 14.sp,
                                            color: market.isUp
                                                ? AppColors.lightSuccess
                                                : AppColors.lightError,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            '${market.changePercent.abs()}%',
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(
                                                  color: market.isUp
                                                      ? AppColors.lightSuccess
                                                      : AppColors.lightError,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.SETTINGS),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 24.w),
                          padding: EdgeInsets.all(24.w),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkSurface
                                : AppColors.lightSurface,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: isDark
                                  ? AppColors.darkDivider
                                  : AppColors.lightDivider,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildQuickAction(
                                context,
                                Icons.search_rounded,
                                'Search',
                                const Color(0xFF22D3EE),
                                isDark,
                              ),
                              _buildQuickAction(
                                context,
                                Icons.assessment_rounded,
                                'Analysis',
                                const Color(0xFFF472B6),
                                isDark,
                              ),
                              _buildQuickAction(
                                context,
                                Icons.history_rounded,
                                'Orders',
                                const Color(0xFF4ADE80),
                                isDark,
                              ),
                              _buildQuickAction(
                                context,
                                Icons.school_rounded,
                                'Learn',
                                const Color(0xFFFB923C),
                                isDark,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Top Movers',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: isDark
                                        ? AppColors.darkPrimaryText
                                        : AppColors.lightPrimaryText,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            Text(
                              'See All',
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(color: AppColors.lightPrimary),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Column(
                        children: controller.topMovers.map((stock) {
                          return Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppColors.darkSurface
                                  : AppColors.lightSurface,
                              border: Border(
                                bottom: BorderSide(
                                  color: isDark
                                      ? AppColors.darkDivider
                                      : AppColors.lightDivider,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? AppColors.darkBackground
                                        : AppColors.lightBackground,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    stock.symbolInitial,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: AppColors.lightPrimary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        stock.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: isDark
                                                  ? AppColors.darkPrimaryText
                                                  : AppColors.lightPrimaryText,
                                              fontWeight: FontWeight.w600,
                                            ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'NSE',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall
                                            ?.copyWith(
                                              color: isDark
                                                  ? AppColors.darkHint
                                                  : AppColors.lightHint,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      currencyFormat.format(stock.currentPrice),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: isDark
                                                ? AppColors.darkPrimaryText
                                                : AppColors.lightPrimaryText,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      '${stock.isUp ? '+' : ''}${stock.changePercent.toStringAsFixed(2)}%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: stock.isUp
                                                ? AppColors.lightSuccess
                                                : AppColors.lightError,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
    bool isDark,
  ) {
    return Column(
      children: [
        Container(
          width: 56.w,
          height: 56.h,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 24.sp),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: isDark
                ? AppColors.darkSecondaryText
                : AppColors.lightSecondaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
