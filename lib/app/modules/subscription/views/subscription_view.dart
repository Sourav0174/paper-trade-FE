import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paper_trade/app/modules/subscription/controllers/subscription_controller.dart';
import 'package:paper_trade/app/themes/app_theme.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Text(
                    'Choose Your Plan',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.darkPrimaryText
                          : AppColors.lightPrimaryText,
                    ),
                  ),
                  Text(
                    'Unlock advanced tools to master the Indian stock market',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColors.darkSecondaryText
                          : AppColors.lightSecondaryText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Obx(
                () => Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkSurface
                        : AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(9999.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.selectPlan('Monthly'),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 32.w,
                              vertical: 16.h,
                            ),
                            decoration: BoxDecoration(
                              color: controller.selectedPlan.value == 'Monthly'
                                  ? AppColors.lightPrimary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(9999.r),
                            ),
                            child: Text(
                              'Monthly',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color:
                                        controller.selectedPlan.value ==
                                            'Monthly'
                                        ? AppColors.lightOnPrimary
                                        : (isDark
                                              ? AppColors.darkSecondaryText
                                              : AppColors.lightSecondaryText),
                                    fontWeight: FontWeight.w600,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.selectPlan('Yearly'),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 32.w,
                              vertical: 16.h,
                            ),
                            decoration: BoxDecoration(
                              color: controller.selectedPlan.value == 'Yearly'
                                  ? AppColors.lightPrimary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(9999.r),
                            ),
                            child: Text(
                              'Yearly (Save 20%)',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color:
                                        controller.selectedPlan.value ==
                                            'Yearly'
                                        ? AppColors.lightOnPrimary
                                        : (isDark
                                              ? AppColors.darkSecondaryText
                                              : AppColors.lightSecondaryText),
                                    fontWeight: FontWeight.w500,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              _buildPricingCard(
                context,
                title: 'Basic',
                subtitle: 'Perfect for beginners',
                price: '₹0',
                isPremium: false,
                features: [
                  'Real-time NSE/BSE Data',
                  'Unlimited Paper Trades',
                  'Limited Watchlist (5)',
                  'Basic Analytics',
                ],
                buttonText: 'Current Plan',
                isDark: isDark,
              ),
              SizedBox(height: 24.h),
              _buildPricingCard(
                context,
                title: 'Pro Trader',
                subtitle: 'For serious learners',
                price: '₹499',
                isPremium: true,
                features: [
                  'Real-time NSE/BSE Data',
                  'Unlimited Paper Trades',
                  'Unlimited Watchlists',
                  'Advanced Technical Indicators',
                ],
                buttonText: 'Upgrade to Pro',
                isDark: isDark,
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildFeatureBadge(
                    context,
                    Icons.security_rounded,
                    'Secure',
                    isDark,
                  ),
                  _buildFeatureBadge(
                    context,
                    Icons.history_rounded,
                    '24/7 Support',
                    isDark,
                  ),
                  _buildFeatureBadge(
                    context,
                    Icons.credit_score_rounded,
                    'Easy Refund',
                    isDark,
                  ),
                ],
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPricingCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String price,
    required bool isPremium,
    required List<String> features,
    required String buttonText,
    required bool isDark,
  }) {
    return Container(
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isPremium
              ? AppColors.lightPrimary
              : (isDark ? AppColors.darkDivider : AppColors.lightDivider),
          width: 2.w,
        ),
        boxShadow: isPremium
            ? [
                BoxShadow(
                  color: AppColors.lightPrimary.withValues(alpha: 0.2),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
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
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.darkPrimaryText
                          : AppColors.lightPrimaryText,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: isDark
                          ? AppColors.darkSecondaryText
                          : AppColors.lightSecondaryText,
                    ),
                  ),
                ],
              ),
              if (isPremium)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightPrimary,
                    borderRadius: BorderRadius.circular(9999.r),
                  ),
                  child: Text(
                    'POPULAR',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.lightOnPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: isDark
                      ? AppColors.darkPrimaryText
                      : AppColors.lightPrimaryText,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Text(
                  ' / month',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColors.darkSecondaryText
                        : AppColors.lightSecondaryText,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(
            color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
          ),
          SizedBox(height: 16.h),
          Column(
            children: features
                .map(
                  (feature) => Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.lightSuccess,
                          size: 20.sp,
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Text(
                            feature,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: isDark
                                      ? AppColors.darkPrimaryText
                                      : AppColors.lightPrimaryText,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isPremium
                    ? AppColors.lightPrimary
                    : Colors.transparent,
                foregroundColor: isPremium
                    ? AppColors.lightOnPrimary
                    : AppColors.lightPrimary,
                side: BorderSide(
                  color: isPremium
                      ? Colors.transparent
                      : AppColors.lightPrimary,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureBadge(
    BuildContext context,
    IconData icon,
    String label,
    bool isDark,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          color: isDark
              ? AppColors.darkSecondaryText
              : AppColors.lightSecondaryText,
          size: 24.sp,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: isDark
                ? AppColors.darkSecondaryText
                : AppColors.lightSecondaryText,
          ),
        ),
      ],
    );
  }
}
