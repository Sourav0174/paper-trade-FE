import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paper_trade/app/modules/login/controllers/login_controller.dart';
import 'package:paper_trade/app/routes/app_pages.dart';
import 'package:paper_trade/app/themes/app_theme.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
              // SizedBox(height: 32.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: AppColors.lightPrimary,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Icon(
                      Icons.trending_up_rounded,
                      color: AppColors.lightOnPrimary,
                      size: 32.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Paper Trade',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppColors.darkPrimaryText
                          : AppColors.lightPrimaryText,
                    ),
                  ),
                  Text(
                    'Master the Indian stock market without risk.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColors.darkSecondaryText
                          : AppColors.lightSecondaryText,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              Container(
                margin: EdgeInsets.only(bottom: 24.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.lightPrimary,
                              width: 2.w,
                            ),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Login',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: AppColors.lightPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),

                    // Expanded(
                    //   child: Container(
                    //     height: 48.h,
                    //     decoration: BoxDecoration(
                    //       border: Border(
                    //         bottom: BorderSide(
                    //           color: isDark
                    //               ? AppColors.darkDivider
                    //               : AppColors.lightDivider,
                    //           width: 1.w,
                    //         ),
                    //       ),
                    //     ),
                    //     alignment: Alignment.center,
                    //     child: Text(
                    //       'Sign Up',
                    //       style: Theme.of(context).textTheme.titleSmall
                    //           ?.copyWith(
                    //             color: isDark
                    //                 ? AppColors.darkSecondaryText
                    //                 : AppColors.lightSecondaryText,
                    //           ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),

              Column(
                children: [
                  _buildAuthInput(
                    context,
                    label: 'EMAIL ADDRESS',
                    hint: 'name@example.com',
                    icon: Icons.email_outlined,
                    controller: controller.emailController,
                    isDark: isDark,
                  ),
                  SizedBox(height: 24.h),
                  Obx(
                    () => _buildAuthInput(
                      context,
                      label: 'PASSWORD',
                      hint: '••••••••',
                      icon: Icons.lock_outline_rounded,
                      controller: controller.passwordController,
                      obscureText: controller.obscurePassword.value,
                      isDark: isDark,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscurePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: isDark
                              ? AppColors.darkSecondaryText
                              : AppColors.lightSecondaryText,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: AppColors.lightPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Obx(
                () => SizedBox(
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.login,
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
                            'Sign In to Dashboard',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: AppColors.lightOnPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              InkWell(
                onTap: () => Get.toNamed(Routes.SIGN_UP),
                child: Center(
                  child: Text(
                    'Dont have any account? Sign up',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: isDark
                          ? AppColors.darkPrimary
                          : AppColors.lightPrimary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: isDark
                          ? AppColors.darkDivider
                          : AppColors.lightDivider,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'OR CONTINUE WITH',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: isDark
                            ? AppColors.darkHint
                            : AppColors.lightHint,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: isDark
                          ? AppColors.darkDivider
                          : AppColors.lightDivider,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: _buildSocialButton(
                      context,
                      Icons.g_mobiledata,
                      'Google',
                      isDark,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _buildSocialButton(
                      context,
                      Icons.apple,
                      'Apple',
                      isDark,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Center(
                child: Column(
                  children: [
                    Text(
                      'By continuing, you agree to our',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppColors.darkSecondaryText
                            : AppColors.lightSecondaryText,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Terms of Service',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.lightPrimary,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                        Text(
                          ' & ',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: isDark
                                    ? AppColors.darkSecondaryText
                                    : AppColors.lightSecondaryText,
                              ),
                        ),
                        Text(
                          'Privacy Policy',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.lightPrimary,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2F1),
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: const Color(0xFFB2DFDB)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: const Color(0xFF00796B),
                      size: 18.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Market is currently closed. All trades will be simulated based on last closing prices.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF00796B),
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthInput(
    BuildContext context, {
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool obscureText = false,
    required bool isDark,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: isDark
                ? AppColors.darkSecondaryText
                : AppColors.lightSecondaryText,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: BorderSide(
                color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: BorderSide(
                color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    IconData icon,
    String label,
    bool isDark,
  ) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: isDark
                ? AppColors.darkPrimaryText
                : AppColors.lightPrimaryText,
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: isDark
                  ? AppColors.darkPrimaryText
                  : AppColors.lightPrimaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
