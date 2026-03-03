import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:paper_trade/app/themes/app_theme.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

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
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 32.h),

                /// TITLE
                Text(
                  "Create Account",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: isDark
                        ? AppColors.darkPrimaryText
                        : AppColors.lightPrimaryText,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Start your risk-free trading journey.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColors.darkSecondaryText
                        : AppColors.lightSecondaryText,
                  ),
                ),

                SizedBox(height: 32.h),

                /// NAME
                _buildInput(
                  context,
                  label: "FULL NAME",
                  hint: "Sourav Kumar",
                  icon: Icons.person_outline,
                  controller: controller.nameController,
                  isDark: isDark,
                ),

                SizedBox(height: 24.h),

                /// EMAIL
                _buildInput(
                  context,
                  label: "EMAIL ADDRESS",
                  hint: "name@example.com",
                  icon: Icons.email_outlined,
                  controller: controller.emailController,
                  isDark: isDark,
                ),

                SizedBox(height: 24.h),

                /// GENDER
                Text(
                  "GENDER",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkSecondaryText
                        : AppColors.lightSecondaryText,
                  ),
                ),
                SizedBox(height: 8.h),
                Obx(
                  () => Row(
                    children: ["Male", "Female", "Others"]
                        .map(
                          (gender) => Expanded(
                            child: GestureDetector(
                              onTap: () => controller.setGender(gender),
                              child: Container(
                                margin: EdgeInsets.only(right: 8.w),
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                decoration: BoxDecoration(
                                  color:
                                      controller.selectedGender.value == gender
                                      ? AppColors.lightPrimary
                                      : (isDark
                                            ? AppColors.darkSurface
                                            : AppColors.lightSurface),
                                  borderRadius: BorderRadius.circular(4.r),
                                  border: Border.all(
                                    color: isDark
                                        ? AppColors.darkDivider
                                        : AppColors.lightDivider,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  gender,
                                  style: TextStyle(
                                    color:
                                        controller.selectedGender.value ==
                                            gender
                                        ? Colors.white
                                        : (isDark
                                              ? AppColors.darkPrimaryText
                                              : AppColors.lightPrimaryText),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),

                SizedBox(height: 24.h),

                /// PASSWORD
                Obx(
                  () => _buildInput(
                    context,
                    label: "PASSWORD",
                    hint: "••••••••",
                    icon: Icons.lock_outline,
                    controller: controller.passwordController,
                    obscureText: controller.isPasswordVisible.value,
                    isDark: isDark,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                /// CONFIRM PASSWORD
                Obx(
                  () => _buildInput(
                    context,
                    label: "CONFIRM PASSWORD",
                    hint: "••••••••",
                    icon: Icons.lock_outline,
                    controller: controller.confirmPasswordController,
                    obscureText: controller.isConfirmPasswordVisible.value,
                    isDark: isDark,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isConfirmPasswordVisible.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: controller.toggleConfirmPasswordVisibility,
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                /// TERMS CHECKBOX
                Obx(
                  () => Row(
                    children: [
                      Checkbox(
                        value: controller.areTermsAccepted.value,
                        onChanged: controller.toggleTerms,
                      ),
                      Expanded(
                        child: Text(
                          "I accept the Terms & Conditions",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                /// REGISTER BUTTON
                Obx(
                  () => SizedBox(
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.onSignUpPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Create Account",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(
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
        Text(label),
        SizedBox(height: 8.h),

        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: (value) {
            switch (label) {
              case "FULL NAME":
                return this.controller.validateName(value);
              case "EMAIL ADDRESS":
                return this.controller.validateEmail(value);
              case "PASSWORD":
                return this.controller.validatePassword(value);
              case "CONFIRM PASSWORD":
                return this.controller.validateConfirmPassword(value);
              default:
                return null;
            }
          },
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ),
      ],
    );
  }
}
