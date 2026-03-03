import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paper_trade/app/modules/portfolio/controllers/portfolio_controller.dart';

import 'package:intl/intl.dart';
import 'package:paper_trade/app/themes/app_theme.dart';

class PortfolioView extends GetView<PortfolioController> {
  const PortfolioView({super.key});

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
                      Container(
                        padding: EdgeInsets.all(24.w),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Portfolio',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? AppColors.darkPrimaryText
                                        : AppColors.lightPrimaryText,
                                  ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Current Value',
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(
                                    color: isDark
                                        ? AppColors.darkSecondaryText
                                        : AppColors.lightSecondaryText,
                                  ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  currencyFormat.format(
                                    controller.currentValue.value,
                                  ),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: isDark
                                            ? AppColors.darkPrimaryText
                                            : AppColors.lightPrimaryText,
                                      ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightSuccess,
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    '+${currencyFormat.format(controller.totalPnl)} (${controller.totalPnlPercent.toStringAsFixed(1)}%)',
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
                      Padding(
                        padding: EdgeInsets.all(24.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Invested',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: isDark
                                                ? AppColors.darkSecondaryText
                                                : AppColors.lightSecondaryText,
                                          ),
                                    ),
                                    Text(
                                      currencyFormat.format(
                                        controller.invested.value,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: isDark
                                                ? AppColors.darkPrimaryText
                                                : AppColors.lightPrimaryText,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Container(
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Day's P&L",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: isDark
                                                ? AppColors.darkSecondaryText
                                                : AppColors.lightSecondaryText,
                                          ),
                                    ),
                                    Text(
                                      '+${currencyFormat.format(controller.todayPnl.value)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: isDark
                                                ? AppColors.darkPrimaryText
                                                : AppColors.lightPrimaryText,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 16.h,
                        ),
                        color: isDark
                            ? AppColors.darkBackground
                            : AppColors.lightBackground,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your Holdings (${controller.holdings.length})',
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? AppColors.darkPrimaryText
                                        : AppColors.lightPrimaryText,
                                  ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.sort_rounded,
                                  size: 18.sp,
                                  color: isDark
                                      ? AppColors.darkSecondaryText
                                      : AppColors.lightSecondaryText,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Value',
                                  style: Theme.of(context).textTheme.labelMedium
                                      ?.copyWith(
                                        color: isDark
                                            ? AppColors.darkSecondaryText
                                            : AppColors.lightSecondaryText,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: controller.holdings.map((holding) {
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
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            holding.symbol,
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
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            '${holding.quantity} Shares • Avg. ${currencyFormat.format(holding.avgPrice)}',
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
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          currencyFormat.format(
                                            holding.currentPrice,
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: isDark
                                                    ? AppColors.darkPrimaryText
                                                    : AppColors
                                                          .lightPrimaryText,
                                              ),
                                        ),
                                        Text(
                                          '${holding.pnlValue > 0 ? '+' : ''}${currencyFormat.format(holding.pnlValue)} (${holding.pnlPercent.toStringAsFixed(1)}%)',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                color: holding.pnlValue > 0
                                                    ? AppColors.lightSuccess
                                                    : AppColors.lightError,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: LinearProgressIndicator(
                                        value: holding.weight,
                                        backgroundColor: isDark
                                            ? AppColors.darkDivider
                                            : AppColors.lightDivider,
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                              AppColors.lightPrimary,
                                            ),
                                        minHeight: 4.h,
                                        borderRadius: BorderRadius.circular(
                                          2.r,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      '${(holding.weight * 100).toStringAsFixed(0)}%',
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
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 80.h),
                    ],
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('New Trade'),
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: AppColors.lightOnPrimary,
      ),
    );
  }
}
