import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paper_trade/app/modules/history/controllers/history_controller.dart';

import 'package:intl/intl.dart';
import 'package:paper_trade/app/themes/app_theme.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currencyFormat = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    );
    final timeFormat = DateFormat('hh:mm a');

    final filters = ['All Trades', 'Buy', 'Sell', 'Options', 'Intraday'];

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? AppColors.darkDivider
                        : AppColors.lightDivider,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trade History',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppColors.darkPrimaryText
                          : AppColors.lightPrimaryText,
                    ),
                  ),
                  Text(
                    'Review your past paper trading activity',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColors.darkSecondaryText
                          : AppColors.lightSecondaryText,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 64.h,
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  final isSelected = controller.selectedFilter.value == filter;
                  return Center(
                    child: GestureDetector(
                      onTap: () => controller.selectFilter(filter),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.lightPrimary
                              : (isDark
                                    ? AppColors.darkSurface
                                    : AppColors.lightSurface),
                          borderRadius: BorderRadius.circular(9999.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.lightPrimary
                                : (isDark
                                      ? AppColors.darkDivider
                                      : AppColors.lightDivider),
                          ),
                        ),
                        child: Text(
                          filter,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: isSelected
                                    ? AppColors.lightOnPrimary
                                    : (isDark
                                          ? AppColors.darkSecondaryText
                                          : AppColors.lightSecondaryText),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        padding: EdgeInsets.all(24.w),
                        itemCount: controller.trades.length,
                        itemBuilder: (context, index) {
                          final trade = controller.trades[index];
                          final isBuy = trade.type == 'BUY';

                          return Container(
                            margin: EdgeInsets.only(bottom: 8.h),
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
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 4.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: isBuy
                                        ? AppColors.lightSuccess
                                        : AppColors.lightError,
                                    borderRadius: BorderRadius.circular(9999.r),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            trade.symbol,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: isDark
                                                      ? AppColors
                                                            .darkPrimaryText
                                                      : AppColors
                                                            .lightPrimaryText,
                                                ),
                                          ),
                                          Text(
                                            currencyFormat.format(trade.total),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: isDark
                                                      ? AppColors
                                                            .darkPrimaryText
                                                      : AppColors
                                                            .lightPrimaryText,
                                                ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w,
                                                  vertical: 2.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: isBuy
                                                      ? const Color(0xFFE8F5E9)
                                                      : const Color(0xFFFFEBEE),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        4.r,
                                                      ),
                                                ),
                                                child: Text(
                                                  trade.type,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall
                                                      ?.copyWith(
                                                        color: isBuy
                                                            ? AppColors
                                                                  .lightSuccess
                                                            : AppColors
                                                                  .lightError,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                              SizedBox(width: 4.w),
                                              Text(
                                                '${trade.quantity} Shares • Avg. ${currencyFormat.format(trade.price)}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: isDark
                                                          ? AppColors
                                                                .darkSecondaryText
                                                          : AppColors
                                                                .lightSecondaryText,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            timeFormat.format(trade.timestamp),
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
