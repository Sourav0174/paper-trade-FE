import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paper_trade/app/modules/trade/controllers/trade_controller.dart';
import 'package:intl/intl.dart';
import 'package:paper_trade/app/themes/app_theme.dart';

class TradeView extends GetView<TradeController> {
  const TradeView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currencyFormat = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    );

    final categories = ['ALL', 'NIFTY_50', 'BANK_NIFTY', 'SENSEX'];

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(24.w).copyWith(bottom: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Market Watch',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? AppColors.darkPrimaryText
                                      : AppColors.lightPrimaryText,
                                ),
                          ),
                          Text(
                            'Search and trade Indian stocks',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: isDark
                                      ? AppColors.darkSecondaryText
                                      : AppColors.lightSecondaryText,
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
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark
                                ? AppColors.darkDivider
                                : AppColors.lightDivider,
                          ),
                        ),
                        child: Icon(
                          Icons.notifications_none_rounded,
                          color: isDark
                              ? AppColors.darkPrimaryText
                              : AppColors.lightPrimaryText,
                          size: 22.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  TextField(
                    onChanged: controller.onSearch,
                    decoration: InputDecoration(
                      hintText: 'Search stocks (e.g. RELIANCE, TCS)',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: isDark
                          ? AppColors.darkSurface
                          : AppColors.lightSurface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                          color: isDark
                              ? AppColors.darkDivider
                              : AppColors.lightDivider,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        borderSide: BorderSide(
                          color: isDark
                              ? AppColors.darkDivider
                              : AppColors.lightDivider,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 48.h,
              child: Obx(() {
                final selected = controller.selectedCategory.value;
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => SizedBox(width: 8.w),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = selected == category;

                    return GestureDetector(
                      onTap: () => controller.selectCategory(category),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
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
                                ? Colors.transparent
                                : (isDark
                                      ? AppColors.darkDivider
                                      : AppColors.lightDivider),
                          ),
                        ),
                        child: Text(
                          category,
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
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Obx(() {
                final isLoading = controller.isLoading.value;
                final stocks = controller.stocks;
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (stocks.isEmpty) {
                  return const Center(child: Text("No Stocks Found"));
                }

                return ListView.separated(
                  controller: controller.scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  itemCount: controller.stocks.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (context, index) {
                    final stock = controller.stocks[index];
                    return GestureDetector(
                      onTap: () => controller.showOrderSheet(stock),
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
                        child: Row(
                          children: [
                            Container(
                              width: 48.w,
                              height: 48.h,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.darkBackground
                                    : AppColors.lightBackground,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                stock.symbolInitial,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.lightPrimary,
                                    ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    stock.name,
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: isDark
                                              ? AppColors.darkPrimaryText
                                              : AppColors.lightPrimaryText,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  currencyFormat.format(stock.currentPrice),
                                  style: Theme.of(context).textTheme.bodyLarge
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
                                      stock.isUp
                                          ? Icons.trending_up_rounded
                                          : Icons.trending_down_rounded,
                                      size: 14.sp,
                                      color: stock.isUp
                                          ? AppColors.lightSuccess
                                          : AppColors.lightError,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      '${stock.changePercent.toStringAsFixed(2)}%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: stock.isUp
                                                ? AppColors.lightSuccess
                                                : AppColors.lightError,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
