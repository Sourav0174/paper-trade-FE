import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paper_trade/app/modules/otp/controllers/otp_controller.dart';
import 'package:paper_trade/app/themes/app_theme.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: isDark
                      ? AppColors.darkPrimaryText
                      : AppColors.lightPrimaryText,
                  size: 20.sp,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: isDark
                      ? AppColors.darkSurface
                      : AppColors.lightSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verify Identity',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppColors.darkPrimaryText
                          : AppColors.lightPrimaryText,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Code sent to ',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDark
                              ? AppColors.darkSecondaryText
                              : AppColors.lightSecondaryText,
                        ),
                      ),
                      Text(
                        '+91 98765 43210',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.lightPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < 3; i++)
                      _buildOtpBox(context, i, isDark),
                    Container(
                      width: 12.w,
                      height: 2.h,
                      color: isDark
                          ? AppColors.darkDivider
                          : AppColors.lightDivider,
                    ),
                    for (int i = 3; i < 6; i++)
                      _buildOtpBox(context, i, isDark),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive the code? ",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.darkSecondaryText
                            : AppColors.lightSecondaryText,
                      ),
                    ),
                    GestureDetector(
                      onTap: controller.resendOtp,
                      child: Text(
                        controller.resendTimer.value > 0
                            ? 'Resend in 00:${controller.resendTimer.value.toString().padLeft(2, '0')}'
                            : 'Resend Now',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 12.sp,
                          color: AppColors.lightPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  children: [
                    _buildKeypadRow(
                      context,
                      ['1', '2', '3'],
                      [false, true, true],
                    ),
                    SizedBox(height: 16.h),
                    _buildKeypadRow(
                      context,
                      ['4', '5', '6'],
                      [true, true, true],
                    ),
                    SizedBox(height: 16.h),
                    _buildKeypadRow(
                      context,
                      ['7', '8', '9'],
                      [true, true, true],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(width: 80.w, height: 80.h),
                        _buildKeypadButton(context, '0', false),
                        GestureDetector(
                          onTap: controller.removeDigit,
                          child: Container(
                            width: 80.w,
                            height: 80.h,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.backspace_outlined,
                              color: isDark
                                  ? AppColors.darkPrimaryText
                                  : AppColors.lightPrimaryText,
                              size: 24.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Obx(
                () => SizedBox(
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed:
                        controller.isLoading.value ||
                            controller.otp.value.length < 6
                        ? null
                        : controller.verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightPrimary,
                      foregroundColor: AppColors.lightOnPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Verify & Continue',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: AppColors.lightOnPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shield_rounded,
                    color: AppColors.lightSuccess,
                    size: 14.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Secure encrypted verification',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
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
      ),
    );
  }

  Widget _buildOtpBox(BuildContext context, int index, bool isDark) {
    final hasDigit = controller.otp.value.length > index;
    final isActive = controller.otp.value.length == index;

    return Container(
      width: 56.w,
      height: 64.h,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: isActive
              ? AppColors.lightPrimary
              : (isDark ? AppColors.darkDivider : AppColors.lightDivider),
          width: 1.w,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.lightPrimary.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: hasDigit
          ? Text(
              controller.otp.value[index],
              style: GoogleFonts.jetBrainsMono(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? AppColors.darkPrimaryText
                    : AppColors.lightPrimaryText,
              ),
            )
          : null,
    );
  }

  Widget _buildKeypadRow(
    BuildContext context,
    List<String> labels,
    List<bool> hasSub,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        labels.length,
        (index) => _buildKeypadButton(context, labels[index], hasSub[index]),
      ),
    );
  }

  Widget _buildKeypadButton(BuildContext context, String label, bool hasSub) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    String? subtitle;

    if (hasSub) {
      final subs = {
        '2': 'ABC',
        '3': 'DEF',
        '4': 'GHI',
        '5': 'JKL',
        '6': 'MNO',
        '7': 'PQRS',
        '8': 'TUV',
        '9': 'WXYZ',
      };
      subtitle = subs[label];
    }

    return GestureDetector(
      onTap: () => controller.addDigit(label),
      child: Container(
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(9999.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.darkPrimaryText
                    : AppColors.lightPrimaryText,
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isDark
                      ? AppColors.darkSecondaryText
                      : AppColors.lightSecondaryText,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
